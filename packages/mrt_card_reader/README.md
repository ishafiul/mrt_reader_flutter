# MRT Card Reader

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Pub Version](https://img.shields.io/pub/v/mrt_card_reader.svg)](https://pub.dev/packages/mrt_card_reader)
[![License: GPL-3.0][license_badge]][license_link]

A Flutter package for reading transaction data from Dhaka MRT (Mass Rapid Transit) metro rail cards using NFC. This package allows you to easily access card balance and transaction history.

![MRT Card Reader Demo](apps/mrt_reader/screenshot/Screenshot_2025-03-16-12-51-21-06_eb82b154c83aa12c1261fb94d847cad9.jpg)
## Features

- Check NFC availability on the device
- Read Dhaka MRT card balance
- Retrieve transaction history (journeys and top-ups)
- Parse transaction details including:
  - Transaction timestamps
  - Origin and destination
  - Journey costs
  - Top-up amounts
  - Current balance

## Requirements

- Flutter 3.0.0 or higher
- Android device with NFC capabilities (API level 19+)
- iOS device with NFC capabilities (iOS 13+)

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

You also need to enable the Near Field Communication Tag Reading capability in your Xcode project.

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

For a complete example, check out the [example](https://github.com/ishafiul/mrt_reader_flutter/tree/main/packages/mrt_card_reader/example) directory in the repository.

## API Reference

### MrtCardReader

#### `static Future<bool> isAvailable()`

Checks if NFC is available on the device.

Returns `true` if NFC is available and enabled, `false` otherwise.

#### `static Future<void> startSession({required Function(String) onStatus, required Function(int?) onBalance, required Function(List<MrtTransaction>) onTransactions})`

Starts an NFC reading session to retrieve MRT card data.

Parameters:
- `onStatus`: Callback that provides status updates during the reading process.
- `onBalance`: Callback that provides the current card balance after successful reading.
- `onTransactions`: Callback that provides the list of transactions read from the card.

### MrtTransaction

Represents a transaction record from an MRT card.

#### Properties

- `timestamp`: Timestamp of when the transaction occurred.
- `fromStation`: Name of the origin station (or top-up location).
- `toStation`: Name of the destination station (may be empty for top-ups).
- `balance`: Card balance after this transaction (in local currency).
- `cost`: Cost of the journey or amount topped up (in local currency).
- `isTopup`: Whether this transaction represents a top-up rather than a journey.

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
