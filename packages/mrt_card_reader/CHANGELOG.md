## 0.2.0

> Note: This release has breaking changes.

 - **FEAT**(transaction): add copyWith method and comprehensive docs. ([fc7be9b2](https://github.com/yourusername/mrt_buddy_flutter/commit/fc7be9b2aa2bf2b38cf4571a20f7695c545fb61a))
 - **DOCS**: update README with new features and usage examples. ([1a89c3f9](https://github.com/yourusername/mrt_buddy_flutter/commit/1a89c3f9cefd1f8995ad35423f873cf41961b03a))
 - **BREAKING** **FEAT**: add instance-based API with session management. ([36d4bb71](https://github.com/yourusername/mrt_buddy_flutter/commit/36d4bb71c7fcc7818791ab2670d2b4c0eb080882))
 - **BREAKING** **FEAT**: add infrastructure for production-ready package. ([48293b00](https://github.com/yourusername/mrt_buddy_flutter/commit/48293b003c805aa1b467cf02ad5d99ed2da222e0))

## 0.1.2

 - **FEAT**: flutter dependencies. ([5d382037](https://github.com/yourusername/mrt_buddy_flutter/commit/5d3820376b2b88f351b5faf102d9212f20460b8e))

## 0.1.1+2

 - **DOCS**: updated image. ([5b5cda9e](https://github.com/yourusername/mrt_buddy_flutter/commit/5b5cda9eb966e4360551121b4e6c4643b3df6c08))

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
