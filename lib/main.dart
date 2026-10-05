import 'dart:ui';

import 'package:elearning_mobile/app.dart';
import 'package:elearning_mobile/app/logger/app_logger.dart';
import 'package:elearning_mobile/core/config/api_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  FlutterError.onError = (details) {
    AppLogger.error(details.exception, details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    AppLogger.error(error, stack);
    return true;
  };

  ApiConfig.validate();

  runApp(const ProviderScope(child: App()));
}
