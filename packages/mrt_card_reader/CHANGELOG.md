## 0.1.1+1

 - **DOCS**: updated image. ([e05e1d1e](https://github.com/yourusername/mrt_buddy_flutter/commit/e05e1d1ee5cce92f953dcee8cca25b696bed2c61))

## 0.1.1

 - **FEAT**: Update MRT card reader. ([f707b254](https://github.com/yourusername/mrt_buddy_flutter/commit/f707b25494458734b7d11c8ab33851d2d711fea4))
 - **DOCS**: updated image. ([fbc7a358](https://github.com/yourusername/mrt_buddy_flutter/commit/fbc7a3584357b86bc3cd75958ca90be452b99a73))

# Changelog

## 0.1.0 - Initial Release (2025-03-16)

### Added
- Initial implementation of Dhaka MRT card reading functionality
- Support for reading transaction history from Dhaka MRT metro rail cards
- Detailed transaction parsing with timestamps, station names, and fare amounts
- Top-up transaction detection and amount calculation
- Balance retrieval from cards
- NFC availability checking
- Comprehensive documentation and usage examples
- Station mapping for Dhaka MRT Line 6 (Uttara North to Motijheel)

### Dependencies
- Uses nfc_manager v3.0.2 for NFC communication

### Notes
- Based on the work by the MRT Buddy team, adapted for Flutter/Dart
- Compatible with Android API level 19+ and iOS 13+
