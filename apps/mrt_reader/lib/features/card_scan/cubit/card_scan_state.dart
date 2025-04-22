import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mrt_card_reader/mrt_card_reader.dart';

part 'card_scan_state.freezed.dart';

@freezed
sealed class CardScanState with _$CardScanState {
  const CardScanState._();
  const factory CardScanState.initial() = CardScanStateInitial;
  const factory CardScanState.waiting() = CardScanStateWaiting;
  const factory CardScanState.reading() = CardScanStateReading;
  const factory CardScanState.success({
    required String cardId,
    required int balance,
    required List<MrtTransaction> transactions,
  }) = CardScanStateSuccess;
  const factory CardScanState.error(String message) = CardScanStateError;
}
