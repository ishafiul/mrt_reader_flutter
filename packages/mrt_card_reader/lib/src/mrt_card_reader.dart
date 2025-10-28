import 'dart:async';
import 'dart:typed_data';

import 'package:mrt_card_reader/src/config/mrt_config.dart';
import 'package:mrt_card_reader/src/exceptions/mrt_exceptions.dart';
import 'package:mrt_card_reader/src/models/transaction.dart';
import 'package:mrt_card_reader/src/utils/logger.dart';
import 'package:mrt_card_reader/src/validators/data_validator.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';

/// A utility class for reading MRT (Mass Rapid Transit) card data via NFC.
///
/// This class provides functionality to check NFC availability and read
/// transaction history from compatible MRT cards. It handles the low-level
/// communication with the NFC hardware and parses the raw data into
/// meaningful transaction records.
///
/// Example usage:
/// ```dart
/// // Check if NFC is available
/// final isNfcAvailable = await MrtCardReader.isAvailable();
///
/// // Start NFC session to read card data
/// await MrtCardReader.startSession(
///   onStatus: (status) => print('Status: $status'),
///   onBalance: (balance) => print('Balance: $balance'),
///   onTransactions: (transactions) => print('Transactions: $transactions'),
/// );
/// ```
/// A utility class for reading MRT (Mass Rapid Transit) card data via NFC.
class MrtCardReader {
  /// Checks if NFC is available on the device.
  ///
  /// Returns `true` if NFC is available and enabled, `false` otherwise.
  ///
  /// This method should be called before attempting to start an NFC session
  /// to ensure that the device supports NFC functionality.
  static Future<bool> isAvailable() async {
    return NfcManager.instance.isAvailable();
  }

  /// Starts an NFC reading session to retrieve MRT card data.
  ///
  /// This method initiates an NFC session that waits for a compatible
  /// MRT card to be presented to the device. Once a card is detected,
  /// it reads the card's transaction history.
  ///
  /// Parameters:
  /// - [onStatus]: Callback for status updates during reading.
  /// - [onBalance]: Callback with current card balance (paisa).
  /// - [onTransactions]: Callback with list of transactions.
  ///   Most recent first.
  ///
  /// The session stays active until card is read or an error occurs.
  ///
  /// Example:
  /// ```dart
  /// await MrtCardReader.startSession(
  ///   onStatus: (status) => setState(() => _status = status),
  ///   onBalance: (balance) => setState(() => _balance = balance),
  ///   onTransactions: (transactions) =>
  ///     setState(() => _transactions = transactions),
  /// );
  /// ```
  static Future<void> startSession({
    required void Function(String status) onStatus,
    required void Function(int? balance) onBalance,
    required void Function(List<MrtTransaction> transactions) onTransactions,
    void Function(MrtException exception)? onError,
    Duration timeout = MrtConfig.defaultTimeout,
  }) async {
    final instance = MrtCardReaderInstance(
      logger: const NoOpLogger(),
      timeout: timeout,
    );

    await instance.startSession(
      onStatus: onStatus,
      onBalance: onBalance,
      onTransactions: onTransactions,
      onError: onError ?? (e) => onStatus('Error: ${e.message}'),
    );
  }
}

/// Instance-based MRT card reader with configurable dependencies.
///
/// Use this class for advanced scenarios where you need:
/// - Session cancellation
/// - Custom logging
/// - Configurable timeouts
/// - Multiple concurrent instances
///
/// For simple use cases, prefer the static methods on [MrtCardReader].
class MrtCardReaderInstance {
  /// Creates a new instance with optional logger and timeout configuration.
  MrtCardReaderInstance({
    MrtLogger? logger,
    Duration? timeout,
  })  : _logger = logger ?? const NoOpLogger(),
        _timeout = timeout ?? MrtConfig.defaultTimeout;

  final MrtLogger _logger;
  final Duration _timeout;
  bool _isSessionActive = false;

  /// Whether a session is currently active.
  bool get isSessionActive => _isSessionActive;

  /// Cancels the current session if one is active.
  ///
  /// This will stop the NFC reader and prevent further callbacks.
  Future<void> cancelSession() async {
    if (_isSessionActive) {
      await NfcManager.instance.stopSession(errorMessage: 'Session cancelled');
      _isSessionActive = false;
      _logger.info('Session cancelled');
    }
  }

  /// Starts an NFC reading session to retrieve MRT card data.
  ///
  /// This method initiates an NFC session that waits for a compatible MRT card.
  /// Once detected, it reads the card's transaction history.
  ///
  /// Parameters:
  /// - [onStatus]: Callback for status updates during reading
  /// - [onBalance]: Callback with current card balance (in paisa)
  /// - [onTransactions]: Callback with transactions (most recent first)
  /// - [onError]: Callback for typed exceptions
  ///
  /// Throws [SessionAlreadyActiveException] if a session is already running.
  Future<void> startSession({
    required void Function(String status) onStatus,
    required void Function(int? balance) onBalance,
    required void Function(List<MrtTransaction> transactions) onTransactions,
    required void Function(MrtException exception) onError,
  }) async {
    if (_isSessionActive) {
      onError(const SessionAlreadyActiveException());
      return;
    }

    final timeoutTimer = Timer(_timeout, () {
      if (_isSessionActive) {
        _isSessionActive = false;
        NfcManager.instance.stopSession(errorMessage: 'Timeout');
        onError(NfcTimeoutException(_timeout));
      }
    });

    try {
      _isSessionActive = true;
      onStatus('Waiting for card...');

      await NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          try {
            final nfcF = NfcF.from(tag);

            if (nfcF == null) {
              onError(const InvalidCardException('This is not a FeliCa card'));
              await NfcManager.instance.stopSession();
              return;
            }

            onStatus('Reading card...');

            final transactions = await _readTransactionHistory(nfcF);

            if (transactions.isNotEmpty) {
              final latestBalance = transactions.first.balance;

              onBalance(latestBalance);
              onTransactions(transactions);
              onStatus('Card read successfully');
            } else {
              onStatus('No transactions found. Try again.');
            }

            await NfcManager.instance.stopSession();
            _isSessionActive = false;
            timeoutTimer.cancel();
          } catch (e) {
            _logger.error('Error during card reading', e);
            if (e is MrtException) {
              onError(e);
            } else {
              onError(DataCorruptionException('Failed to read card: $e'));
            }
            await NfcManager.instance.stopSession();
            _isSessionActive = false;
            timeoutTimer.cancel();
          }
        },
        onError: (error) {
          _logger.error('NFC error', error);
          _isSessionActive = false;
          timeoutTimer.cancel();
          onError(DataCorruptionException('NFC error: $error'));
          return Future<void>.value();
        },
      );
    } catch (e) {
      _isSessionActive = false;
      timeoutTimer.cancel();
      _logger.error('Failed to start session', e);
      onError(const NfcNotAvailableException());
    }
  }

  Future<List<MrtTransaction>> _readTransactionHistory(NfcF nfcF) async {
    final transactions = <MrtTransaction>[];

    try {
      final idm = nfcF.identifier;

      final serviceCodeList = Uint8List.fromList([
        (MrtConfig.serviceCode & 0xFF),
        ((MrtConfig.serviceCode >> 8) & 0xFF),
      ]);

      final blockListElements = Uint8List(MrtConfig.numberOfBlocks * 2);
      for (var i = 0; i < MrtConfig.numberOfBlocks; i++) {
        blockListElements[i * 2] = MrtConfig.blockDescriptor;
        blockListElements[i * 2 + 1] = i;
      }

      // Calculate command length
      final commandLength = 14 + blockListElements.length;
      final command = Uint8List(commandLength);

      var idx = 0;
      command[idx++] = commandLength;
      command[idx++] = MrtConfig.commandCode;

      for (var i = 0; i < idm.length; i++) {
        command[idx++] = idm[i];
      }

      command[idx++] = 0x01;
      command[idx++] = serviceCodeList[0];
      command[idx++] = serviceCodeList[1];
      command[idx++] = MrtConfig.numberOfBlocks;

      for (var i = 0; i < blockListElements.length; i++) {
        command[idx++] = blockListElements[i];
      }

      final response = await nfcF.transceive(data: command);

      DataValidator.validateResponse(response);

      final numBlocks = response[12];
      final blockData = response.sublist(13);

      if (blockData.length < numBlocks * MrtConfig.blockSize) {
        throw const DataCorruptionException('Invalid block data length');
      }

      for (var i = 0; i < numBlocks; i++) {
        final offset = i * MrtConfig.blockSize;
        final block = blockData.sublist(offset, offset + MrtConfig.blockSize);

        try {
          final transaction = _parseTransactionBlock(block);
          transactions.add(transaction);
        } catch (e) {
          _logger.warning('Error parsing block $i: $e');
        }
      }

      _calculateTopupAmounts(transactions);
    } catch (e) {
      _logger.error('Error reading transaction history', e);
      rethrow;
    }

    return transactions;
  }

  MrtTransaction _parseTransactionBlock(Uint8List block) {
    DataValidator.validateBlock(block);

    // Fixed Header (Offsets 0-3)
    final fixedHeader = block.sublist(0, 4);
    final fixedHeaderStr = fixedHeader
        .map((b) => b.toRadixString(16).padLeft(2, '0').toUpperCase())
        .join(' ');

    // Timestamp (Offsets 4-5)
    final timestampBytes = block.sublist(4, 6);
    final timestampValue =
        ((timestampBytes[1] & 0xFF) << 8) | (timestampBytes[0] & 0xFF);

    // Transaction Type (Offsets 6-7)
    final transactionTypeBytes = block.sublist(6, 8);
    final transactionType = transactionTypeBytes
        .map((b) => b.toRadixString(16).padLeft(2, '0').toUpperCase())
        .join(' ');

    // From Station (Offset 8)
    final fromStationCode = block[8] & 0xFF;

    // Separator (Offset 9)
    // The separator byte is at position 9 but we don't use it currently

    // To Station (Offset 10)
    final toStationCode = block[10] & 0xFF;

    // Balance (Offsets 11-13), little-endian format
    final balanceBytes = block.sublist(11, 14);
    final balance = ((balanceBytes[2] & 0xFF) << 16) |
        ((balanceBytes[1] & 0xFF) << 8) |
        (balanceBytes[0] & 0xFF);

    // Trailing (Offsets 14-15)
    final trailingBytes = block.sublist(14, 16);
    final trailing = trailingBytes
        .map(
          (b) => b.toRadixString(16).padLeft(2, '0').toUpperCase(),
        )
        .join(' ');

    final timestamp = _decodeTimestamp(timestampValue);

    final fromStation = MrtConfig.getStationName(fromStationCode);
    final toStation = MrtConfig.getStationName(toStationCode);

    // Determine if this is a topup transaction
    final isTopup = fromStation != 'Unknown Station ($fromStationCode)' &&
        (toStation == 'Unknown Station ($toStationCode)' || toStationCode == 0);

    int? cost;

    if (isTopup) {
      cost = null;
    } else if (fromStation != 'Unknown Station ($fromStationCode)' &&
        toStation != 'Unknown Station ($toStationCode)') {
      cost = MrtConfig.calculateFare(fromStationCode, toStationCode);
    }

    return MrtTransaction(
      fixedHeader: fixedHeaderStr,
      timestamp: timestamp,
      transactionType: transactionType,
      fromStation: fromStation,
      toStation: toStation,
      balance: balance,
      cost: cost,
      trailing: trailing,
      isTopup: isTopup,
    );
  }

  String _decodeTimestamp(int value) {
    // Simple implementation - adjust based on actual encoding
    final baseTime =
        DateTime.now().millisecondsSinceEpoch - (value * 60 * 1000);
    final date = DateTime.fromMillisecondsSinceEpoch(baseTime);
    final year = date.year;
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$year-$month-$day $hour:$minute';
  }

  void _calculateTopupAmounts(List<MrtTransaction> transactions) {
    if (transactions.isEmpty) return;

    for (var i = 0; i < transactions.length - 1; i++) {
      final current = transactions[i];
      final next = transactions[i + 1];

      // Check if current transaction is a topup
      if (current.isTopup) {
        // Calculate topup amount by comparing balances
        // Topup: current balance should be higher than previous balance
        final topupAmount = current.balance - next.balance;

        // Only set positive topup amounts
        if (topupAmount > 0) {
          // Update the cost field in the current transaction
          transactions[i] = current.copyWith(cost: topupAmount);
        }
      }
    }
  }
}
