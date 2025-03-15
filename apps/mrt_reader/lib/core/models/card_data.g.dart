// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CardData _$CardDataFromJson(Map<String, dynamic> json) => _CardData(
      cardId: json['cardId'] as String,
      balance: (json['balance'] as num).toInt(),
      lastScanned: DateTime.parse(json['lastScanned'] as String),
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => const MrtTransactionConverter()
              .fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CardDataToJson(_CardData instance) => <String, dynamic>{
      'cardId': instance.cardId,
      'balance': instance.balance,
      'lastScanned': instance.lastScanned.toIso8601String(),
      'transactions': instance.transactions
          .map(const MrtTransactionConverter().toJson)
          .toList(),
    };
