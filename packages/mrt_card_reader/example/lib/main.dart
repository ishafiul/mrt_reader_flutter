import 'package:flutter/material.dart';
import 'package:mrt_card_reader/mrt_card_reader.dart';

void main() {
  runApp(const MrtReaderApp());
}

class MrtReaderApp extends StatelessWidget {
  const MrtReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dhaka MRT Card Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MrtReaderHomePage(),
    );
  }
}

class MrtReaderHomePage extends StatefulWidget {
  const MrtReaderHomePage({super.key});

  @override
  State<MrtReaderHomePage> createState() => _MrtReaderHomePageState();
}

class _MrtReaderHomePageState extends State<MrtReaderHomePage> {
  String _status = 'Ready to scan';
  int? _balance;
  final List<MrtTransaction> _transactions = [];
  bool _isNfcAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkNfcAvailability();
  }

  Future<void> _checkNfcAvailability() async {
    final isAvailable = await MrtCardReader.isAvailable();
    setState(() {
      _isNfcAvailable = isAvailable;
      _status = isAvailable
          ? 'NFC is available. Ready to scan.'
          : 'NFC is not available on this device.';
    });
  }

  Future<void> _startScan() async {
    if (!_isNfcAvailable) {
      return;
    }

    setState(() {
      _status = 'Please tap your Dhaka MRT card...';
    });

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
          _transactions.clear();
          _transactions.addAll(transactions);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dhaka MRT Card Reader'),
        elevation: 2,
      ),
      body: Column(
        children: [
          // Status and balance section
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[200],
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Status: $_status',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                if (_balance != null) ...[
                  Text(
                    'Balance: ৳${(_balance! / 100).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: _isNfcAvailable ? _startScan : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      'Scan Dhaka MRT Card',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Transactions list for Line 6 metro
          Expanded(
            child: _transactions.isEmpty
                ? const Center(
                    child: Text('No transactions found. Scan your MRT card.'),
                  )
                : ListView.builder(
                    itemCount: _transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = _transactions[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: ListTile(
                          title: Text(
                            transaction.isTopup
                                ? 'Top-up at ${transaction.fromStation}'
                                : 'Journey from ${transaction.fromStation} to ${transaction.toStation}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(transaction.timestamp),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (transaction.cost != null)
                                Text(
                                  transaction.isTopup
                                      ? '+৳${(transaction.cost! / 100).toStringAsFixed(2)}'
                                      : '-৳${(transaction.cost! / 100).toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: transaction.isTopup
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              Text(
                                'Balance: ৳${(transaction.balance / 100).toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
