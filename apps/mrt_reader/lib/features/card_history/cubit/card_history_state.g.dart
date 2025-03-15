// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_history_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardHistoryStateInitial _$CardHistoryStateInitialFromJson(
        Map<String, dynamic> json) =>
    CardHistoryStateInitial(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$CardHistoryStateInitialToJson(
        CardHistoryStateInitial instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

CardHistoryStateLoding _$CardHistoryStateLodingFromJson(
        Map<String, dynamic> json) =>
    CardHistoryStateLoding(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$CardHistoryStateLodingToJson(
        CardHistoryStateLoding instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

CardHistoryStateLoaded _$CardHistoryStateLoadedFromJson(
        Map<String, dynamic> json) =>
    CardHistoryStateLoaded(
      (json['cards'] as List<dynamic>)
          .map((e) => CardData.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$CardHistoryStateLoadedToJson(
        CardHistoryStateLoaded instance) =>
    <String, dynamic>{
      'cards': instance.cards,
      'runtimeType': instance.$type,
    };

CardHistoryStateError _$CardHistoryStateErrorFromJson(
        Map<String, dynamic> json) =>
    CardHistoryStateError(
      json['message'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$CardHistoryStateErrorToJson(
        CardHistoryStateError instance) =>
    <String, dynamic>{
      'message': instance.message,
      'runtimeType': instance.$type,
    };
