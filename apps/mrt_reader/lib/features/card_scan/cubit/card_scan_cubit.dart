import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mrt_card_reader/mrt_card_reader.dart';
import 'package:mrt_reader/core/database/app_database.dart';
import 'package:mrt_reader/core/models/card_data.dart';
import 'package:mrt_reader/features/card_scan/cubit/card_scan_state.dart';

@injectable
class CardScanCubit extends Cubit<CardScanState> {
  final DatabaseService _databaseService;

  CardScanCubit(this._databaseService) : super(const CardScanState.initial());

  Future<void> startScan() async {
    print("object");
    // Check if NFC is available
    final isAvailable = await MrtCardReader.isAvailable();
    if (!isAvailable) {
      emit(const CardScanState.error('NFC is not available on this device'));
      return;
    }

    emit(const CardScanState.waiting());

    try {
      await MrtCardReader.startSession(
        onStatus: (status) {
          if (status.contains('Reading')) {
           // emit(const CardScanState.reading());
          } else if (status.contains('Error')) {
            emit(CardScanState.error(status));
          }
        },
        onBalance: (balance) {
          print(balance);
        },
        onTransactions: (transactions) async {
          print(transactions);
          if (transactions.isNotEmpty) {
            // Use the first 8 bytes of the fixed header as the card ID
            // This is a simplification - in a real app, you'd use a proper ID from the card
            final cardId = transactions.first.fixedHeader.replaceAll(' ', '');
            final balance = transactions.first.balance;

            // Save to database
            await _databaseService.saveCardData(
              CardData(
                cardId: cardId,
                balance: balance,
                lastScanned: DateTime.now(),
                transactions: transactions,
              ),
            );

            emit(CardScanState.success(
              cardId: cardId,
              balance: balance,
              transactions: transactions,
            ),);
          }
        },
      );
    } catch (e) {
      emit(CardScanState.error('Error scanning card: $e'));
    }
  }

  void resetScan() {
    emit(const CardScanState.initial());
  }

  Future<void> stopScan() async {
    try {
      //await MrtCardReader.stopSession();
    } catch (e) {
      // Ignore errors when stopping
    }
    emit(const CardScanState.initial());
  }
} 