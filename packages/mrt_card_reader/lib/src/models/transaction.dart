import 'package:mrt_card_reader/mrt_card_reader.dart' show MrtCardReader;
import 'package:mrt_card_reader/src/mrt_card_reader.dart' show MrtCardReader;

/// Represents a transaction record from an MRT card.
///
/// This class contains information about a single transaction including
/// its type (journey or top-up), stations involved, balance, and cost.
///
/// MrtTransaction objects are created when an MRT card is scanned using
/// the [MrtCardReader] class, which parses raw card data into structured
/// transaction records.
///
/// Example:
/// ```dart
/// final transaction = MrtTransaction(
///   fixedHeader: '00 00 00 00',
///   timestamp: '2023-05-15 14:30',
///   transactionType: '00 00',
///   fromStation: 'Uttara North',
///   toStation: 'Agargaon',
///   balance: 5000,
///   cost: 100,
///   trailing: '00 00',
///   isTopup: false,
/// );
/// ```
class MrtTransaction {
  /// Creates a new MRT transaction instance.
  ///
  /// All parameters except [cost] are required:
  /// - [fixedHeader]: Raw header data from the card
  /// - [timestamp]: Date and time of the transaction
  /// - [transactionType]: Type of transaction in hex format
  /// - [fromStation]: Origin station or top-up location
  /// - [toStation]: Destination station (may be empty for top-ups)
  /// - [balance]: Remaining balance after transaction
  /// - [trailing]: Raw trailing data from the card
  /// - [isTopup]: Whether this is a top-up transaction
  /// - [cost]: Transaction amount (optional, may be null)
  MrtTransaction({
    required this.fixedHeader,
    required this.timestamp,
    required this.transactionType,
    required this.fromStation,
    required this.toStation,
    required this.balance,
    required this.trailing,
    required this.isTopup,
    this.cost,
  });

  /// Creates a transaction instance from a map.
  ///
  /// This factory constructor is useful for converting data from
  /// storage or network sources into MrtTransaction objects.
  ///
  /// The map must contain the same keys as would be produced by [toMap].
  factory MrtTransaction.fromMap(Map<String, dynamic> map) {
    return MrtTransaction(
      fixedHeader: map['fixedHeader'] as String,
      timestamp: map['timestamp'] as String,
      transactionType: map['transactionType'] as String,
      fromStation: map['fromStation'] as String,
      toStation: map['toStation'] as String,
      balance: map['balance'] as int,
      cost: map['cost'] as int?,
      trailing: map['trailing'] as String,
      isTopup: map['isTopup'] as bool,
    );
  }

  /// Raw header data from the card's data block.
  final String fixedHeader;

  /// Timestamp of when the transaction occurred.
  /// Format: YYYY-MM-DD HH:MM
  final String timestamp;

  /// Transaction type in hexadecimal format.
  final String transactionType;

  /// Name of the origin station (or top-up location).
  final String fromStation;

  /// Name of the destination station (may be empty for top-ups).
  final String toStation;

  /// Card balance after this transaction (in local currency).
  final int balance;

  /// Cost of the journey or amount topped up (in local currency).
  /// Null if unknown or not applicable.
  final int? cost;

  /// Trailing data from the card's data block.
  final String trailing;

  /// Whether this transaction represents a top-up rather than a journey.
  final bool isTopup;

  /// Converts this transaction to a map.
  ///
  /// This is useful for serializing the transaction for storage
  /// or transmission. The resulting map can be converted back into
  /// an MrtTransaction using the [MrtTransaction.fromMap] constructor.
  Map<String, dynamic> toMap() {
    return {
      'fixedHeader': fixedHeader,
      'timestamp': timestamp,
      'transactionType': transactionType,
      'fromStation': fromStation,
      'toStation': toStation,
      'balance': balance,
      'cost': cost,
      'trailing': trailing,
      'isTopup': isTopup,
    };
  }

  @override
  String toString() {
    return 'MrtTransaction(fixedHeader: $fixedHeader, timestamp: $timestamp, transactionType: $transactionType, fromStation: $fromStation, toStation: $toStation, balance: $balance, cost: $cost, trailing: $trailing, isTopup: $isTopup)';
  }
}
