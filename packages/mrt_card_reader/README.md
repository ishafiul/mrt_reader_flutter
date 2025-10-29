# MRT Card Reader

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Pub Version](https://img.shields.io/pub/v/mrt_card_reader.svg)](https://pub.dev/packages/mrt_card_reader)
[![License: GPL-3.0][license_badge]][license_link]

A Flutter package for reading transaction data from Dhaka MRT (Mass Rapid Transit) metro rail cards using NFC. This package allows you to easily access card balance and transaction history.

![MRT Card Reader Demo](https://raw.githubusercontent.com/ishafiul/mrt_reader_flutter/refs/heads/main/packages/mrt_card_reader/doc/assets/mrt_card_reader_demo.jpg)
## Features

- **Cross-platform support**: Works on both Android and iOS
- Check NFC availability on the device
- Read Dhaka MRT card balance
- Retrieve transaction history (journeys and top-ups)
- Parse transaction details including:
  - Transaction timestamps
  - Origin and destination
  - Journey costs
  - Top-up amounts
  - Current balance
- **Typed exception handling** for better error management
- **Session management** with cancellation and timeout support
- **Configurable logging** for debugging
- **Data validation** for card responses

## Requirements

- Flutter 3.0.0 or higher
- Android device with NFC capabilities (API level 19+)
- iOS device with NFC capabilities (iOS 13+)

### Platform Support

- **Android**: Fully supported using NFC-F (FeliCa) protocol via native `transceive()` API
- **iOS**: Fully supported using FeliCa `readWithoutEncryption()` API. The implementation automatically converts between raw commands (Android) and higher-level FeliCa API (iOS), providing seamless cross-platform compatibility with identical transaction data output.

## Installation

Add `mrt_card_reader` to your `pubspec.yaml`:

```yaml
dependencies:
  mrt_card_reader: ^0.1.0
```

Then run:

```bash
flutter pub get
```

### Platform-specific setup

#### Android

Add the following permissions to your `AndroidManifest.xml` file:

```xml
<uses-permission android:name="android.permission.NFC" />
<uses-feature android:name="android.hardware.nfc" android:required="true" />
```

#### iOS

Add the following to your `Info.plist` file:

```xml
<key>NFCReaderUsageDescription</key>
<string>This app needs access to NFC to read MRT card data.</string>

<key>com.apple.developer.nfc.readersession.formats</key>
<array>
    <string>TAG</string>
</array>
```

You also need to enable the "Near Field Communication Tag Reading" capability in your Xcode project:

1. Open your project in Xcode
2. Select your target
3. Go to "Signing & Capabilities" tab
4. Click "+ Capability"
5. Add "Near Field Communication Tag Reading"

## Usage

### Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:mrt_card_reader/mrt_card_reader.dart';

class MrtCardReaderDemo extends StatefulWidget {
  const MrtCardReaderDemo({Key? key}) : super(key: key);

  @override
  State<MrtCardReaderDemo> createState() => _MrtCardReaderDemoState();
}

class _MrtCardReaderDemoState extends State<MrtCardReaderDemo> {
  String _status = 'Ready to scan';
  int? _balance;
  List<MrtTransaction> _transactions = [];

  Future<void> _startScan() async {
    // Check if NFC is available
    final isNfcAvailable = await MrtCardReader.isAvailable();
    
    if (!isNfcAvailable) {
      setState(() {
        _status = 'NFC is not available on this device';
      });
      return;
    }

    // Start NFC session to read the card
    await MrtCardReader.startSession(
      onStatus: (status) {
        setState(() {
          _status = status;
        });
      },
      onBalance: (balance) {
        setState(() {
          _balance = balance;
        });
      },
      onTransactions: (transactions) {
        setState(() {
          _transactions = transactions;
        });
      },
      onError: (exception) {
        setState(() {
          _status = 'Error: ${exception.message}';
        });
      },
      timeout: const Duration(seconds: 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MRT Card Reader')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Status: $_status'),
            if (_balance != null) Text('Balance: \$${_balance! / 100}'),
            ElevatedButton(
              onPressed: _startScan,
              child: const Text('Scan MRT Card'),
            ),
            if (_transactions.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text('Recent Transactions', 
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = _transactions[index];
                    return ListTile(
                      title: Text(transaction.isTopup 
                        ? 'Top-up at ${transaction.fromStation}'
                        : 'Journey from ${transaction.fromStation} to ${transaction.toStation}'),
                      subtitle: Text(transaction.timestamp),
                      trailing: Text(
                        transaction.isTopup
                          ? '+\$${transaction.cost ?? 0 / 100}'
                          : '-\$${transaction.cost ?? 0 / 100}',
                        style: TextStyle(
                          color: transaction.isTopup ? Colors.green : Colors.red,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```

### Advanced Usage with Instance API

For more control, use the instance-based API:

```dart
final reader = MrtCardReaderInstance(
  logger: ConsoleLogger(),
  timeout: const Duration(seconds: 60),
);

await reader.startSession(
  onStatus: (status) => print(status),
  onBalance: (balance) => print('Balance: $balance'),
  onTransactions: (transactions) => print(transactions),
  onError: (exception) => print('Error: ${exception.toString()}'),

// Check if session is active
if (reader.isSessionActive) {
  print('Reading in progress...');
}

// Cancel session if needed
await reader.cancelSession();
```

For a complete example, check out the [example](https://github.com/ishafiul/mrt_reader_flutter/tree/main/packages/mrt_card_reader/example) directory in the repository.

## API Reference

### MrtCardReader

#### `static Future<bool> isAvailable()`

Checks if NFC is available on the device.

Returns `true` if NFC is available and enabled, `false` otherwise.

#### `static Future<void> startSession({required Function(String) onStatus, required Function(int?) onBalance, required Function(List<MrtTransaction>) onTransactions, Function(MrtException)? onError, Duration timeout})`

Starts an NFC reading session to retrieve MRT card data.

Parameters:
- `onStatus`: Callback that provides status updates during the reading process.
- `onBalance`: Callback that provides the current card balance after successful reading (in paisa).
- `onTransactions`: Callback that provides the list of transactions read from the card.
- `onError`: Optional callback for typed exceptions (recommended).
- `timeout`: Optional timeout duration (default: 30 seconds).

### MrtTransaction

Represents a transaction record from an MRT card.

#### Properties

- `fixedHeader`: Raw header data from the card's data block.
- `timestamp`: Timestamp of when the transaction occurred (YYYY-MM-DD HH:MM).
- `transactionType`: Transaction type in hexadecimal format.
- `fromStation`: Name of the origin station (or top-up location).
- `toStation`: Name of the destination station (may be empty for top-ups).
- `balance`: Card balance after this transaction (in paisa, Taka * 100).
- `cost`: Cost of the journey or amount topped up (in paisa, null if unknown).
- `trailing`: Trailing data from the card's data block.
- `isTopup`: Whether this transaction represents a top-up rather than a journey.

#### Methods

- `copyWith({...})`: Creates a copy with updated fields.
- `toMap()`: Converts to a map for serialization.
- `fromMap(Map<String, dynamic>)`: Factory constructor to create from a map.
- `toString()`: Returns a string representation.

### Exception Types

The package provides typed exceptions for better error handling:

- `MrtException`: Base exception class
- `NfcNotAvailableException`: NFC not available or disabled
- `InvalidCardException`: Invalid or unsupported card
- `DataCorruptionException`: Corrupted or unreadable card data
- `NfcTimeoutException`: Reading operation timed out
- `SessionAlreadyActiveException`: Session already in progress

## Platform-Specific Notes

### Android
- Uses native NFC-F (FeliCa) `transceive()` for direct card communication
- Compatible with Android API level 19+

### iOS
- Uses FeliCa `readWithoutEncryption()` API (iOS 13+)
- Automatically handles platform differences internally
- Same transaction data output as Android
- Requires FeliCa-compatible iPhone (iPhone 7 or later, except iPhone X)

## Troubleshooting

### Common Issues

**NFC not available**: Ensure NFC is enabled in device settings and the device supports NFC. On iOS, ensure you have a compatible device (iPhone 7 or later).

**Card reading timeout**: Increase the timeout duration or check card proximity.

**Invalid card errors**: Ensure you're using a valid Dhaka MRT Line 6 card (FeliCa card).

**Data corruption**: Card may be damaged or incompatible with the reader.

**iOS not reading card**: Ensure you have enabled the NFC capability in Xcode and have a FeliCa-compatible iPhone model.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the terms of the GNU General Public License v3.0 (GPL-3.0). See the [LICENSE](LICENSE) file for details.

## Acknowledgements

The core idea and logic for this project were inspired by MRT Buddy, created by Aniruddha Adhikary. Thanks to the team for the original work!

[dart_install_link]: https://dart.dev/get-dart
[license_badge]: https://img.shields.io/badge/license-GPL--3.0-blue.svg
[license_link]: https://www.gnu.org/licenses/gpl-3.0.en.html
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
