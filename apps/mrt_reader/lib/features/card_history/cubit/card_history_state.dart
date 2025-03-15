import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mrt_reader/core/models/card_data.dart';

part 'card_history_state.freezed.dart';
part 'card_history_state.g.dart';

@freezed
sealed class CardHistoryState with _$CardHistoryState {
  const CardHistoryState._();
  const factory CardHistoryState.initial() = CardHistoryStateInitial;
  const factory CardHistoryState.loading() = CardHistoryStateLoding;
  const factory CardHistoryState.loaded(List<CardData> cards) = CardHistoryStateLoaded;
  const factory CardHistoryState.error(String message) = CardHistoryStateError;

  factory CardHistoryState.fromJson(Map<String, dynamic> json) =>
      _$CardHistoryStateFromJson(json);
} 