import 'package:flutter/material.dart';

class AppLogger {
  static void error(Object error, [StackTrace? stackTrace]) {
    if (stackTrace == null) {
      debugPrint(error.toString());
      return;
    }
    debugPrintStack(label: error.toString(), stackTrace: stackTrace);
  }

  static void info(String message) {
    debugPrint(message);
  }
}
