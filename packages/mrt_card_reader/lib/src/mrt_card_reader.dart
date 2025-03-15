import 'dart:typed_data';

import 'package:mrt_card_reader/src/models/transaction.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';

class MrtCardReader {
  static Future<bool> isAvailable() async {
    return await NfcManager.instance.isAvailable();
  }

  static Future<void> startSession({
    required Function(String) onStatus,
    required Function(int?) onBalance,
    required Function(List<MrtTransaction>) onTransactions,
  }) async {
    onStatus('Waiting for card...');

    await NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        try {
          // Get NfcF instance from the tag
          final nfcF = NfcF.from(tag);

          if (nfcF == null) {
            onStatus('This is not a FeliCa card');
            return;
          }

          onStatus('Reading card...');

          // Read transaction history
          final transactions = await _readTransactionHistory(nfcF);

          if (transactions.isNotEmpty) {
            // Get latest balance
            final latestBalance = transactions.first.balance;

            // Update UI
            onBalance(latestBalance);
            onTransactions(transactions);
            onStatus('Card read successfully');
          } else {
            onStatus('No transactions found. Try again.');
          }

          // Stop session after reading
          await NfcManager.instance.stopSession();
        } catch (e) {
          onStatus('Error: $e');
          await NfcManager.instance.stopSession();
        }
      },
      onError: (error) {
        onStatus('Error: $error');
        return Future.value(); // Return a non-null Future
      },
    );
  }

  static Future<List<MrtTransaction>> _readTransactionHistory(NfcF nfcF) async {
    final transactions = <MrtTransaction>[];

    try {
      final idm = nfcF.identifier;

      // Service code for MRT card (0x220F)
      const serviceCode = 0x220F;
      final serviceCodeList = Uint8List.fromList([
        (serviceCode & 0xFF),
        ((serviceCode >> 8) & 0xFF),
      ]);

      const numberOfBlocksToRead = 15;

      // Build block list elements
      final blockListElements = Uint8List(numberOfBlocksToRead * 2);
      for (var i = 0; i < numberOfBlocksToRead; i++) {
        blockListElements[i * 2] = 0x80; // Two-byte block descriptor
        blockListElements[i * 2 + 1] = i; // Block number
      }

      // Calculate command length
      final commandLength = 14 + blockListElements.length;
      final command = Uint8List(commandLength);

      var idx = 0;
      command[idx++] = commandLength; // Length
      command[idx++] = 0x06; // Command code

      // Copy IDM
      for (int i = 0; i < idm.length; i++) {
        command[idx++] = idm[i];
      }

      command[idx++] = 0x01; // Number of services
      command[idx++] = serviceCodeList[0];
      command[idx++] = serviceCodeList[1];
      command[idx++] = numberOfBlocksToRead; // Number of blocks

      // Copy block list elements
      for (int i = 0; i < blockListElements.length; i++) {
        command[idx++] = blockListElements[i];
      }

      // Send command and get response
      final response = await nfcF.transceive(data: command);

      // Parse response
      if (response.length < 13) {
        return transactions;
      }

      final statusFlag1 = response[10];
      final statusFlag2 = response[11];

      if (statusFlag1 != 0x00 || statusFlag2 != 0x00) {
        return transactions;
      }

      final numBlocks = response[12];
      final blockData = response.sublist(13);

      const blockSize = 16; // Each block is 16 bytes
      if (blockData.length < numBlocks * blockSize) {
        return transactions;
      }

      for (int i = 0; i < numBlocks; i++) {
        final offset = i * blockSize;
        final block = blockData.sublist(offset, offset + blockSize);

        try {
          final transaction = _parseTransactionBlock(block);
          transactions.add(transaction);
        } catch (e) {
          print('Error parsing block: $e');
        }
      }
      
      // Post-process transactions to calculate topup amounts
      _calculateTopupAmounts(transactions);
    } catch (e) {
      print('Error reading transaction history: $e');
    }

    return transactions;
  }

  static MrtTransaction _parseTransactionBlock(Uint8List block) {
    if (block.length != 16) {
      throw Exception('Invalid block size');
    }

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
    final separator = block[9] & 0xFF;

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

    // Convert timestamp to human-readable date/time
    final timestamp = _decodeTimestamp(timestampValue);

    // Map station codes to station names
    final fromStation = _getStationName(fromStationCode);
    final toStation = _getStationName(toStationCode);

    // Determine if this is a topup transaction
    final isTopup = fromStation != "Unknown Station ($fromStationCode)" && 
                   (toStation == "Unknown Station ($toStationCode)" || toStationCode == 0);

    // Calculate cost
    int? cost;
    
    // If it's a topup transaction
    if (isTopup) {
      // For topup, the cost is positive (amount added to the card)
      // We need to compare with previous transaction to determine the amount
      // For now, we'll set it to null and calculate it later
      cost = null;
    } else if (fromStation != "Unknown Station ($fromStationCode)" && 
               toStation != "Unknown Station ($toStationCode)") {
      // For a journey, calculate fare based on stations
      cost = _calculateFare(fromStationCode, toStationCode);
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

  static int _calculateFare(int fromStationCode, int toStationCode) {
    // Simple fare calculation based on distance between stations
    // This is a placeholder - replace with actual fare calculation logic
    
    // Get the station indices from the station map
    final stationIndices = _getStationIndices();
    
    // If either station is not in the map, return a default fare
    if (!stationIndices.containsKey(fromStationCode) || 
        !stationIndices.containsKey(toStationCode)) {
      return 20; // Default fare
    }
    
    // Calculate fare based on distance (number of stations)
    final distance = (stationIndices[fromStationCode]! - stationIndices[toStationCode]!).abs();
    
    // Base fare + per station charge
    return 10 + (distance * 5);
  }
  
  static Map<int, int> _getStationIndices() {
    // Map station codes to their position on the line
    // This helps calculate distance between stations
    final indices = <int, int>{};
    
    final stationCodes = [10, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 95];
    
    for (int i = 0; i < stationCodes.length; i++) {
      indices[stationCodes[i]] = i;
    }
    
    return indices;
  }

  static String _decodeTimestamp(int value) {
    // Simple implementation - adjust based on actual encoding
    final baseTime =
        DateTime.now().millisecondsSinceEpoch - (value * 60 * 1000);
    final date = DateTime.fromMillisecondsSinceEpoch(baseTime);
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  static String _getStationName(int code) {
    // Map station codes to names - update with actual station codes
    final stationMap = {
      10: "Motijheel",
      20: "Bangladesh Secretariat",
      25: "Dhaka University",
      30: "Shahbagh",
      35: "Karwan Bazar",
      40: "Farmgate",
      45: "Bijoy Sarani",
      50: "Agargaon",
      55: "Shewrapara",
      60: "Kazipara",
      65: "Mirpur 10",
      70: "Mirpur 11",
      75: "Pallabi",
      80: "Uttara South",
      85: "Uttara Center",
      95: "Uttara North",
    };

    return stationMap[code] ?? "Unknown Station ($code)";
  }

  static void _calculateTopupAmounts(List<MrtTransaction> transactions) {
    // Skip if there are no transactions
    if (transactions.isEmpty) return;
    
    for (int i = 0; i < transactions.length - 1; i++) {
      final current = transactions[i];
      final next = transactions[i + 1];
      
      // Check if current transaction is a topup
      if (current.isTopup) {
        // Calculate topup amount by comparing balances
        // For topup, current balance should be higher than the previous transaction's balance
        final topupAmount = current.balance - next.balance;
        
        // Only set positive topup amounts
        if (topupAmount > 0) {
          // Update the cost field in the current transaction
          transactions[i] = MrtTransaction(
            fixedHeader: current.fixedHeader,
            timestamp: current.timestamp,
            transactionType: current.transactionType,
            fromStation: current.fromStation,
            toStation: current.toStation,
            balance: current.balance,
            cost: topupAmount,
            trailing: current.trailing,
            isTopup: current.isTopup,
          );
        }
      }
    }
  }
}
