import 'package:mrt_card_reader/mrt_card_reader.dart';
import 'package:test/test.dart';

void main() {
  group('MrtCardReader', () {
    test('isAvailable returns boolean', () async {
      final result = await MrtCardReader.isAvailable();
      expect(result, isA<bool>());
    });
  });

  group('MrtCardReaderInstance', () {
    late MrtCardReaderInstance instance;

    setUp(() {
      instance = MrtCardReaderInstance();
    });

    test('creates instance with default logger', () {
      expect(instance, isNotNull);
      expect(instance.isSessionActive, false);
    });

    test('creates instance with custom timeout', () {
      final customInstance = MrtCardReaderInstance(
        timeout: const Duration(seconds: 60),
      );
      expect(customInstance, isNotNull);
    });

    test('isSessionActive returns false initially', () {
      expect(instance.isSessionActive, false);
    });

    test('cancelSession when no session active does nothing', () async {
      await instance.cancelSession();
      expect(instance.isSessionActive, false);
    });
  });
}
