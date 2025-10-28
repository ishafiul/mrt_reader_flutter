/// A Flutter package for reading transaction data from Dhaka MRT (Mass Rapid
/// Transit) metro rail cards using NFC.
///
/// This library provides a simple interface to interact with Dhaka MRT cards,
/// allowing developers to retrieve card balance and transaction history
/// information from Line 6 metro rail cards via NFC.
///
/// To use this package, you need a device with NFC capabilities.
///
/// Main features:
/// * Check NFC availability on the device
/// * Read Dhaka MRT card balance
/// * Retrieve transaction history (journeys and top-ups)
/// * Parse transaction details including timestamps, stations, costs,
///   and balance
library mrt_card_reader;

export 'src/config/mrt_config.dart';
export 'src/exceptions/mrt_exceptions.dart';
export 'src/models/transaction.dart';
export 'src/mrt_card_reader.dart';
export 'src/utils/logger.dart';
export 'src/validators/data_validator.dart';
