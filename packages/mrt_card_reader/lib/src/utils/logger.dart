import 'package:flutter/foundation.dart';

/// Logger interface for MRT card reader operations.
abstract class MrtLogger {
  /// Logs a debug message.
  void debug(String message);

  /// Logs an informational message.
  void info(String message);

  /// Logs a warning message.
  void warning(String message);

  /// Logs an error message with optional error and stack trace.
  void error(String message, [Object? error, StackTrace? stackTrace]);
}

/// No-op logger that discards all log messages.
class NoOpLogger implements MrtLogger {
  /// Creates a new no-op logger instance.
  const NoOpLogger();

  @override
  void debug(String message) {}

  @override
  void info(String message) {}

  @override
  void warning(String message) {}

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {}
}

/// Default logger that outputs to console using debug print.
class ConsoleLogger implements MrtLogger {
  /// Default logger that outputs to console using debug print.
  const ConsoleLogger();

  @override
  void debug(String message) {
    if (kDebugMode) {
      debugPrint('[DEBUG] $message');
    }
  }

  @override
  void info(String message) {
    if (kDebugMode) {
      debugPrint('[INFO] $message');
    }
  }

  @override
  void warning(String message) {
    if (kDebugMode) {
      debugPrint('[WARNING] $message');
    }
  }

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('[ERROR] $message');
      if (error != null) {
        debugPrint('Error: $error');
      }
      if (stackTrace != null) {
        debugPrint('Stack trace: $stackTrace');
      }
    }
  }
}
