import 'package:mrt_card_reader/mrt_card_reader.dart';
import 'package:test/test.dart';

void main() {
  group('MrtException', () {
    test('creates with message', () {
      const exception = DataCorruptionException('Test error');
      expect(exception.message, 'Test error');
      expect(exception.toString(), 'Test error');
    });
  });

  group('NfcNotAvailableException', () {
    test('creates with default message', () {
      const exception = NfcNotAvailableException();
      expect(exception.message, 'NFC is not available on this device');
    });

    test('creates with custom message', () {
      const exception = NfcNotAvailableException('Custom error');
      expect(exception.message, 'Custom error');
    });
  });

  group('InvalidCardException', () {
    test('creates with default message', () {
      const exception = InvalidCardException();
      expect(exception.message, 'Invalid or unsupported card');
    });

    test('creates with custom message', () {
      const exception = InvalidCardException('Not a MRT card');
      expect(exception.message, 'Not a MRT card');
    });
  });

  group('DataCorruptionException', () {
    test('creates with default message', () {
      const exception = DataCorruptionException();
      expect(exception.message, 'Card data is corrupted or unreadable');
    });

    test('creates with custom message', () {
      const exception = DataCorruptionException('Invalid checksum');
      expect(exception.message, 'Invalid checksum');
    });
  });

  group('NfcTimeoutException', () {
    test('creates with timeout duration', () {
      const duration = Duration(seconds: 30);
      const exception = NfcTimeoutException(duration);
      expect(exception.timeout, duration);
      expect(exception.message, 'NFC read operation timed out');
    });

    test('toString includes timeout information', () {
      const duration = Duration(seconds: 15);
      const exception = NfcTimeoutException(duration);
      expect(
          exception.toString(), 'NFC read operation timed out (timeout: 15s)');
    });

    test('creates with custom message', () {
      const duration = Duration(seconds: 60);
      const exception = NfcTimeoutException(duration, 'Read timeout exceeded');
      expect(exception.message, 'Read timeout exceeded');
    });
  });

  group('SessionAlreadyActiveException', () {
    test('creates with default message', () {
      const exception = SessionAlreadyActiveException();
      expect(exception.message, 'A session is already active');
    });

    test('creates with custom message', () {
      const exception = SessionAlreadyActiveException('Already reading');
      expect(exception.message, 'Already reading');
    });
  });
}
