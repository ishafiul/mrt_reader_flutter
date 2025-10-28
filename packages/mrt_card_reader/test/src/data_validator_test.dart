import 'dart:typed_data';
import 'package:mrt_card_reader/mrt_card_reader.dart';
import 'package:test/test.dart';

void main() {
  group('DataValidator', () {
    group('validateBalance', () {
      test('validates balance within range', () {
        expect(() => DataValidator.validateBalance(5000), returnsNormally);
        expect(() => DataValidator.validateBalance(0), returnsNormally);
        expect(() => DataValidator.validateBalance(999900), returnsNormally);
      });

      test('throws for balance below minimum', () {
        expect(
          () => DataValidator.validateBalance(-1),
          throwsA(isA<DataCorruptionException>()),
        );
      });

      test('throws for balance above maximum', () {
        expect(
          () => DataValidator.validateBalance(1000000),
          throwsA(isA<DataCorruptionException>()),
        );
      });
    });

    group('validateStationCode', () {
      test('validates known station codes', () {
        expect(() => DataValidator.validateStationCode(10), returnsNormally);
        expect(() => DataValidator.validateStationCode(95), returnsNormally);
      });

      test('validates zero as unknown', () {
        expect(() => DataValidator.validateStationCode(0), returnsNormally);
      });

      test('throws for invalid station code', () {
        expect(
          () => DataValidator.validateStationCode(99),
          throwsA(isA<DataCorruptionException>()),
        );
      });
    });

    group('validateResponse', () {
      test('validates response with correct length and status', () {
        final response = Uint8List(20);
        response[10] = 0x00;
        response[11] = 0x00;
        expect(() => DataValidator.validateResponse(response), returnsNormally);
      });

      test('throws for response too short', () {
        final response = Uint8List(10);
        expect(
          () => DataValidator.validateResponse(response),
          throwsA(isA<DataCorruptionException>()),
        );
      });

      test('throws for error status flag 1', () {
        final response = Uint8List(20);
        response[10] = 0x01;
        response[11] = 0x00;
        expect(
          () => DataValidator.validateResponse(response),
          throwsA(isA<DataCorruptionException>()),
        );
      });

      test('throws for error status flag 2', () {
        final response = Uint8List(20);
        response[10] = 0x00;
        response[11] = 0x01;
        expect(
          () => DataValidator.validateResponse(response),
          throwsA(isA<DataCorruptionException>()),
        );
      });
    });

    group('validateBlock', () {
      test('validates block with correct size', () {
        final block = Uint8List(16);
        expect(() => DataValidator.validateBlock(block), returnsNormally);
      });

      test('throws for block too small', () {
        final block = Uint8List(15);
        expect(
          () => DataValidator.validateBlock(block),
          throwsA(isA<DataCorruptionException>()),
        );
      });

      test('throws for block too large', () {
        final block = Uint8List(17);
        expect(
          () => DataValidator.validateBlock(block),
          throwsA(isA<DataCorruptionException>()),
        );
      });
    });
  });
}
