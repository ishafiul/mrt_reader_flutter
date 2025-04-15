/// Represents a transaction record from an MRT card.
/// 
/// This class contains information about a single transaction including
/// its type (journey or top-up), stations involved, balance, and cost.
class MrtTransaction {

  /// Creates a new MRT transaction instance.
  MrtTransaction({
    required this.fixedHeader,
    required this.timestamp,
    required this.transactionType,
    required this.fromStation,
    required this.toStation,
    required this.balance,
    required this.trailing, required this.isTopup, this.cost,
  });

  /// Creates a transaction instance from a map.
  factory MrtTransaction.fromMap(Map<String, dynamic> map) {
    return MrtTransaction(
      fixedHeader: map['fixedHeader'] as String,
      timestamp: map['timestamp']  as String,
      transactionType: map['transactionType']  as String,
      fromStation: map['fromStation']  as String,
      toStation: map['toStation']  as String,
      balance: map['balance']  as int,
      cost: map['cost'] as int?,
      trailing: map['trailing']  as String,
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
