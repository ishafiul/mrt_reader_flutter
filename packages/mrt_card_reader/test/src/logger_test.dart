import 'package:mrt_card_reader/mrt_card_reader.dart';
import 'package:test/test.dart';

void main() {
  group('NoOpLogger', () {
    late NoOpLogger logger;

    setUp(() {
      logger = NoOpLogger();
    });

    test('discards debug messages', () {
      expect(() => logger.debug('test'), returnsNormally);
    });

    test('discards info messages', () {
      expect(() => logger.info('test'), returnsNormally);
    });

    test('discards warning messages', () {
      expect(() => logger.warning('test'), returnsNormally);
    });

    test('discards error messages', () {
      expect(() => logger.error('test'), returnsNormally);
    });

    test('discards error messages with exception', () {
      expect(
        () => logger.error('test', Exception('error')),
        returnsNormally,
      );
    });

    test('discards error messages with stack trace', () {
      expect(
        () => logger.error('test', null, StackTrace.current),
        returnsNormally,
      );
    });
  });

  group('ConsoleLogger', () {
    late ConsoleLogger logger;

    setUp(() {
      logger = ConsoleLogger();
    });

    test('creates instance', () {
      expect(logger, isNotNull);
    });

    test('debug method exists', () {
      expect(() => logger.debug('test'), returnsNormally);
    });

    test('info method exists', () {
      expect(() => logger.info('test'), returnsNormally);
    });

    test('warning method exists', () {
      expect(() => logger.warning('test'), returnsNormally);
    });

    test('error method exists', () {
      expect(() => logger.error('test'), returnsNormally);
    });

    test('error with exception works', () {
      expect(
        () => logger.error('test', Exception('error')),
        returnsNormally,
      );
    });

    test('error with stack trace works', () {
      expect(
        () => logger.error('test', null, StackTrace.current),
        returnsNormally,
      );
    });
  });
}
