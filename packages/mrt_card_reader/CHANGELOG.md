# Changelog

## 0.1.0 - Initial Release (2025-03-16)

### Added
- Initial implementation of MRT card reading functionality
- Support for reading transaction history from MRT cards
- Detailed transaction parsing with timestamps, station names, and fare amounts
- Top-up transaction detection and amount calculation
- Balance retrieval from cards
- NFC availability checking
- Comprehensive documentation and usage examples
- Station mapping for Dhaka MRT Line 6

### Dependencies
- Uses nfc_manager v3.0.2 for NFC communication

### Notes
- Based on the work by the MRT Buddy team, adapted for Flutter/Dart
- Compatible with Android API level 19+ and iOS 13+
