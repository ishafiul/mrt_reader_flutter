// ignore_for_file: require_trailing_commas

import 'dart:typed_data';

import 'package:mrt_card_reader/src/config/mrt_config.dart';
import 'package:mrt_card_reader/src/exceptions/mrt_exceptions.dart';

/// Validates data integrity for MRT card responses.
class DataValidator {
  /// Validates that a balance is within acceptable range.
  ///
  /// Throws [DataCorruptionException] if balance is invalid.
  static void validateBalance(int balance) {
    if (balance < MrtConfig.minBalance || balance > MrtConfig.maxBalance) {
      throw DataCorruptionException(
        'Balance value out of range: $balance '
        '(expected ${MrtConfig.minBalance}-${MrtConfig.maxBalance})',
      );
    }
  }

  /// Validates that a station code is known or zero (unknown).
  ///
  /// Throws [DataCorruptionException] if station code is invalid.
  static void validateStationCode(int stationCode) {
    if (!MrtConfig.stationNames.containsKey(stationCode) && stationCode != 0) {
      throw DataCorruptionException('Unknown station code: $stationCode');
    }
  }

  /// Validates that a card response has proper structure and status flags.
  ///
  /// Throws [DataCorruptionException] if response is malformed or has
  /// error status.
  static void validateResponse(Uint8List response) {
    if (response.length < 13) {
      throw DataCorruptionException(
        'Response too short: ${response.length} bytes',
      );
    }

    final statusFlag1 = response[10];
    final statusFlag2 = response[11];

    if (statusFlag1 != 0x00 || statusFlag2 != 0x00) {
      throw DataCorruptionException(
        'Invalid status flags: $statusFlag1, $statusFlag2',
      );
    }
  }

  /// Validates that a transaction block has the correct size.
  ///
  /// Throws [DataCorruptionException] if block size is invalid.
  static void validateBlock(Uint8List block) {
    if (block.length != MrtConfig.blockSize) {
      throw DataCorruptionException('Invalid block size: ${block.length}');
    }
  }
}
