import 'dart:developer' as developer;

class AppLogger {
  static void error(Object error, [StackTrace? stackTrace]) {
    developer.log(
      error.toString(),
      name: 'AppError',
      error: error,
      stackTrace: stackTrace,
      level: 1000,
    );
  }
}
