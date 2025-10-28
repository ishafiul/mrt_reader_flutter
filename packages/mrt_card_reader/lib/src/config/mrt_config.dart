/// Configuration constants for Dhaka MRT card reading.
class MrtConfig {
  MrtConfig._();

  /// Service code for FeliCa card communication (0x220F).
  static const int serviceCode = 0x220F;

  /// Number of transaction blocks to read from the card.
  static const int numberOfBlocks = 15;

  /// Size of each transaction block in bytes.
  static const int blockSize = 16;

  /// Command code for reading data from the card.
  static const int commandCode = 0x06;

  /// Block descriptor byte for two-byte block descriptors.
  static const int blockDescriptor = 0x80;

  /// Default timeout duration for NFC operations.
  static const Duration defaultTimeout = Duration(seconds: 30);

  /// Minimum valid card balance in paisa (Taka * 100).
  static const int minBalance = 0;

  /// Maximum valid card balance in paisa (Taka * 100).
  static const int maxBalance = 999900;

  /// Map of station codes to their display names.
  static final Map<int, String> stationNames = {
    10: 'Motijheel',
    20: 'Bangladesh Secretariat',
    25: 'Dhaka University',
    30: 'Shahbagh',
    35: 'Karwan Bazar',
    40: 'Farmgate',
    45: 'Bijoy Sarani',
    50: 'Agargaon',
    55: 'Shewrapara',
    60: 'Kazipara',
    65: 'Mirpur 10',
    70: 'Mirpur 11',
    75: 'Pallabi',
    80: 'Uttara South',
    85: 'Uttara Center',
    95: 'Uttara North',
  };

  /// Ordered list of all station codes on Line 6.
  static final List<int> stationCodes = [
    10,
    20,
    25,
    30,
    35,
    40,
    45,
    50,
    55,
    60,
    65,
    70,
    75,
    80,
    85,
      95,
  ];

  /// Map of station codes to their position index on the line.
  static final Map<int, int> stationIndices = {
    for (var i = 0; i < stationCodes.length; i++) stationCodes[i]: i,
  };

  /// Calculates the fare between two stations based on distance.
  ///
  /// Returns the fare in paisa (Taka * 100). Default fare is 20 paisa
  /// if either station is unknown.
  ///
  /// The calculation uses: Base fare (10 paisa) +
  /// distance * 5 paisa per station.
  static int calculateFare(int fromStationCode, int toStationCode) {
    if (!stationIndices.containsKey(fromStationCode) ||
        !stationIndices.containsKey(toStationCode)) {
      return 20;
    }

    final distance =
        (stationIndices[fromStationCode]! - stationIndices[toStationCode]!)
            .abs();

    return 10 + (distance * 5);
  }

  /// Gets the display name for a station code.
  ///
  /// Returns the station name if found, or 'Unknown Station (code)' if not.
  static String getStationName(int code) {
    return stationNames[code] ?? 'Unknown Station ($code)';
  }
}
