/// Base exception class for all MRT card reading related errors.
abstract class MrtException implements Exception {
  /// Creates a new MrtException with an optional error message.
  const MrtException(this.message);

  /// Human-readable error message describing the failure.
  final String message;

  @override
  String toString() => message;
}

/// Thrown when NFC is not available or not enabled on the device.
class NfcNotAvailableException extends MrtException {
  /// Creates a new [NfcNotAvailableException].
  const NfcNotAvailableException([
    super.message = 'NFC is not available on this device',
  ]);
}

/// Thrown when an invalid or unsupported card is detected.
class InvalidCardException extends MrtException {
  /// Creates a new [InvalidCardException].
  const InvalidCardException([super.message = 'Invalid or unsupported card']);
}

/// Thrown when card data is corrupted or cannot be parsed.
class DataCorruptionException extends MrtException {
  /// Creates a new [DataCorruptionException].
  const DataCorruptionException([
    super.message = 'Card data is corrupted or unreadable',
  ]);
}

/// Thrown when NFC reading operation times out.
class NfcTimeoutException extends MrtException {
  /// Creates a new [NfcTimeoutException].
  ///
  /// [timeout] is the duration that was exceeded.
  const NfcTimeoutException(
    this.timeout, [
    super.message = 'NFC read operation timed out',
  ]);

  /// Returns the timeout duration that was exceeded.
  final Duration timeout;

  @override
  String toString() {
    return '$message (timeout: ${timeout.inSeconds}s)';
  }
}

/// Thrown when attempting to start a new session while one is already active.
class SessionAlreadyActiveException extends MrtException {
  /// Creates a new [SessionAlreadyActiveException].
  const SessionAlreadyActiveException([
    super.message = 'A session is already active',
  ]);
}
