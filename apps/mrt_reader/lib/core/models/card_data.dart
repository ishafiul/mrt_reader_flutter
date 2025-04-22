import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mrt_card_reader/mrt_card_reader.dart';

part 'card_data.freezed.dart';
part 'card_data.g.dart';

class MrtTransactionConverter
    implements JsonConverter<MrtTransaction, Map<String, dynamic>> {
  const MrtTransactionConverter();

  @override
  MrtTransaction fromJson(Map<String, dynamic> json) {
    return MrtTransaction.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(MrtTransaction transaction) {
    return transaction.toMap();
  }
}

@freezed
sealed class CardData with _$CardData {
  const factory CardData({
    required String cardId,
    required int balance,
    required DateTime lastScanned,
    @MrtTransactionConverter() required List<MrtTransaction> transactions,
  }) = _CardData;

  factory CardData.fromJson(Map<String, dynamic> json) =>
      _$CardDataFromJson(json);
}
