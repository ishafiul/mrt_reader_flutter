import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mrt_reader/core/database/app_database.dart';
import 'package:mrt_reader/core/models/card_data.dart';
import 'package:mrt_reader/features/card_history/cubit/card_history_state.dart';

@injectable
class CardHistoryCubit extends Cubit<CardHistoryState> {
  final DatabaseService _databaseService;

  CardHistoryCubit(this._databaseService) : super(const CardHistoryState.initial());

  Future<void> loadCards() async {
    emit(const CardHistoryState.loading());
    try {
      final cards = await _databaseService.getAllCards();
      // Sort by last scanned date, newest first
      cards.sort((a, b) => b.lastScanned.compareTo(a.lastScanned));
      emit(CardHistoryState.loaded(cards));
    } catch (e) {
      emit(CardHistoryState.error('Failed to load cards: $e'));
    }
  }

  Future<void> deleteCard(String cardId) async {
    try {
      await _databaseService.deleteCard(cardId);
      // Reload cards after deletion
      await loadCards();
    } catch (e) {
      emit(CardHistoryState.error('Failed to delete card: $e'));
    }
  }
} 