import 'package:mrt_card_reader/src/validators/data_validator.dart';

/// Represents a transaction record from an MRT card.
///
/// This class contains information about a single transaction including
/// its type (journey or top-up), stations involved, balance, and cost.
class MrtTransaction {
  /// Creates a new MRT transaction instance.
  ///
  /// All parameters are required except [cost]. The [balance] must be
  /// within valid range or a validation error will be thrown.
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
  }) {
    DataValidator.validateBalance(balance);
  }

  /// Creates a transaction instance from a map.
  ///
  /// This factory constructor is useful for converting data from
  /// storage or network sources into [MrtTransaction] objects.
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

  /// Card balance after this transaction in paisa (Taka * 100).
  final int balance;

  /// Cost of the journey or amount topped up in paisa (Taka * 100).
  /// Null if unknown or not applicable.
  final int? cost;

  /// Trailing data from the card's data block.
  final String trailing;

  /// Whether this transaction represents a top-up rather than a journey.
  final bool isTopup;

  /// Creates a copy of this transaction with updated fields.
  ///
  /// Only the specified fields will be updated; all others remain unchanged.
  MrtTransaction copyWith({
    String? fixedHeader,
    String? timestamp,
    String? transactionType,
    String? fromStation,
    String? toStation,
    int? balance,
    int? cost,
    String? trailing,
    bool? isTopup,
  }) {
    return MrtTransaction(
      fixedHeader: fixedHeader ?? this.fixedHeader,
      timestamp: timestamp ?? this.timestamp,
      transactionType: transactionType ?? this.transactionType,
      fromStation: fromStation ?? this.fromStation,
      toStation: toStation ?? this.toStation,
      balance: balance ?? this.balance,
      cost: cost ?? this.cost,
      trailing: trailing ?? this.trailing,
      isTopup: isTopup ?? this.isTopup,
    );
  }

  /// Converts this transaction to a map.
  ///
  /// This is useful for serializing the transaction for storage
  /// or transmission. The resulting map can be converted back using the
  /// [MrtTransaction.fromMap] factory constructor.
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
    return 'MrtTransaction(fixedHeader: $fixedHeader, '
        'timestamp: $timestamp, transactionType: $transactionType, '
        'fromStation: $fromStation, toStation: $toStation, '
        'balance: $balance, cost: $cost, trailing: $trailing, '
        'isTopup: $isTopup)';
  }
}
