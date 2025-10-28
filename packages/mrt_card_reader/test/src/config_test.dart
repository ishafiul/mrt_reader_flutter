import 'package:mrt_card_reader/mrt_card_reader.dart';
import 'package:test/test.dart';

void main() {
  group('MrtConfig Constants', () {
    test('serviceCode is 0x220F', () {
      expect(MrtConfig.serviceCode, 0x220F);
    });

    test('numberOfBlocks is 15', () {
      expect(MrtConfig.numberOfBlocks, 15);
    });

    test('blockSize is 16', () {
      expect(MrtConfig.blockSize, 16);
    });

    test('commandCode is 0x06', () {
      expect(MrtConfig.commandCode, 0x06);
    });

    test('blockDescriptor is 0x80', () {
      expect(MrtConfig.blockDescriptor, 0x80);
    });

    test('defaultTimeout is 30 seconds', () {
      expect(MrtConfig.defaultTimeout, const Duration(seconds: 30));
    });

    test('minBalance is 0', () {
      expect(MrtConfig.minBalance, 0);
    });

    test('maxBalance is 999900', () {
      expect(MrtConfig.maxBalance, 999900);
    });
  });

  group('MrtConfig Station Names', () {
    test('contains all expected stations', () {
      expect(MrtConfig.stationNames.length, 16);
      expect(MrtConfig.stationNames[10], 'Motijheel');
      expect(MrtConfig.stationNames[95], 'Uttara North');
    });

    test('getStationName returns correct name for valid code', () {
      expect(MrtConfig.getStationName(10), 'Motijheel');
      expect(MrtConfig.getStationName(95), 'Uttara North');
    });

    test('getStationName returns unknown for invalid code', () {
      expect(MrtConfig.getStationName(99), 'Unknown Station (99)');
      expect(MrtConfig.getStationName(0), 'Unknown Station (0)');
    });
  });

  group('MrtConfig Fare Calculation', () {
    test('calculateFare for adjacent stations', () {
      expect(MrtConfig.calculateFare(10, 20), 15);
      expect(MrtConfig.calculateFare(95, 85), 15);
    });

    test('calculateFare for distant stations', () {
      expect(MrtConfig.calculateFare(10, 95), 110);
      expect(MrtConfig.calculateFare(95, 10), 110);
    });

    test('calculateFare returns default for unknown stations', () {
      expect(MrtConfig.calculateFare(99, 10), 20);
      expect(MrtConfig.calculateFare(10, 99), 20);
    });
  });

  group('MrtConfig Station Indices', () {
    test('stationIndices contains all station codes', () {
      expect(MrtConfig.stationIndices.length, 16);
      expect(MrtConfig.stationIndices[10], 0);
      expect(MrtConfig.stationIndices[95], 15);
    });

    test('stationCodes is ordered', () {
      expect(MrtConfig.stationCodes.first, 10);
      expect(MrtConfig.stationCodes.last, 95);
      expect(MrtConfig.stationCodes.length, 16);
    });
  });
}
