class MrtTransaction {
  final String fixedHeader;
  final String timestamp;
  final String transactionType;
  final String fromStation;
  final String toStation;
  final int balance;
  final int? cost;
  final String trailing;
  final bool isTopup;

  MrtTransaction({
    required this.fixedHeader,
    required this.timestamp,
    required this.transactionType,
    required this.fromStation,
    required this.toStation,
    required this.balance,
    this.cost,
    required this.trailing,
    required this.isTopup,
  });

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