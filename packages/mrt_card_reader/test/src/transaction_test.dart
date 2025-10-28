import 'package:mrt_card_reader/mrt_card_reader.dart';
import 'package:test/test.dart';

void main() {
  group('MrtTransaction', () {
    final validTransaction = MrtTransaction(
      fixedHeader: '00 01 02 03',
      timestamp: '2023-01-15 14:30',
      transactionType: '00 00',
      fromStation: 'Uttara North',
      toStation: 'Motijheel',
      balance: 5000,
      cost: 100,
      trailing: '00 00',
      isTopup: false,
    );

    test('creates valid transaction', () {
      expect(validTransaction.balance, 5000);
      expect(validTransaction.fromStation, 'Uttara North');
      expect(validTransaction.isTopup, false);
    });

    test('creates transaction with null cost', () {
      final transaction = MrtTransaction(
        fixedHeader: '00 01',
        timestamp: '2023-01-15 14:30',
        transactionType: '01 00',
        fromStation: 'Station A',
        toStation: 'Station B',
        balance: 1000,
        trailing: '00 00',
        isTopup: false,
      );
      expect(transaction.cost, isNull);
    });

    group('copyWith', () {
      test('updates balance field', () {
        final updated = validTransaction.copyWith(balance: 6000);
        expect(updated.balance, 6000);
        expect(updated.fromStation, validTransaction.fromStation);
      });

      test('updates cost field', () {
        final updated = validTransaction.copyWith(cost: 200);
        expect(updated.cost, 200);
        expect(updated.balance, validTransaction.balance);
      });

      test('updates multiple fields', () {
        final updated = validTransaction.copyWith(
          balance: 7000,
          cost: 300,
        );
        expect(updated.balance, 7000);
        expect(updated.cost, 300);
      });

      test('creates new instance without modifying original', () {
        final updated = validTransaction.copyWith(balance: 8000);
        expect(validTransaction.balance, 5000);
        expect(updated.balance, 8000);
      });
    });

    group('fromMap', () {
      test('creates transaction from map', () {
        final map = {
          'fixedHeader': '00 01 02 03',
          'timestamp': '2023-01-15 14:30',
          'transactionType': '00 00',
          'fromStation': 'Uttara North',
          'toStation': 'Motijheel',
          'balance': 5000,
          'cost': 100,
          'trailing': '00 00',
          'isTopup': false,
        };
        final transaction = MrtTransaction.fromMap(map);
        expect(transaction.balance, 5000);
        expect(transaction.isTopup, false);
      });

      test('handles null cost in map', () {
        final map = {
          'fixedHeader': '00 01',
          'timestamp': '2023-01-15 14:30',
          'transactionType': '00 00',
          'fromStation': 'Station A',
          'toStation': 'Station B',
          'balance': 1000,
          'cost': null,
          'trailing': '00 00',
          'isTopup': false,
        };
        final transaction = MrtTransaction.fromMap(map);
        expect(transaction.cost, isNull);
      });
    });

    group('toMap', () {
      test('converts to map', () {
        final map = validTransaction.toMap();
        expect(map['balance'], 5000);
        expect(map['isTopup'], false);
        expect(map['cost'], 100);
      });

      test('includes null cost in map', () {
        final transaction = MrtTransaction(
          fixedHeader: '00 01',
          timestamp: '2023-01-15 14:30',
          transactionType: '00 00',
          fromStation: 'Station A',
          toStation: 'Station B',
          balance: 1000,
          trailing: '00 00',
          isTopup: false,
        );
        final map = transaction.toMap();
        expect(map['cost'], isNull);
      });

      test('roundtrip with fromMap', () {
        final map = validTransaction.toMap();
        final recreated = MrtTransaction.fromMap(map);
        expect(recreated.balance, validTransaction.balance);
        expect(recreated.fromStation, validTransaction.fromStation);
      });
    });

    group('toString', () {
      test('includes all fields', () {
        final str = validTransaction.toString();
        expect(str, contains('Uttara North'));
        expect(str, contains('5000'));
        expect(str, contains('MrtTransaction'));
      });
    });

    group('topup transactions', () {
      final topupTransaction = MrtTransaction(
        fixedHeader: '00 01',
        timestamp: '2023-01-15 15:00',
        transactionType: '01 00',
        fromStation: 'Station A',
        toStation: 'Unknown Station (0)',
        balance: 6000,
        trailing: '00 00',
        isTopup: true,
      );

      test('creates topup transaction', () {
        expect(topupTransaction.isTopup, true);
      });
    });
  });
}
