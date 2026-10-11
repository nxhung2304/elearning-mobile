import 'package:elearning_mobile/app/logger/app_logger.dart';
import 'package:elearning_mobile/core/exceptions/validation_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class AppProviderObserver extends ProviderObserver {
  Object? _lastLoggedError;

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    if (newValue is AsyncError) {
      _logErrorOnce(context, newValue.error, newValue.stackTrace);
    }
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    _logErrorOnce(context, error, stackTrace);
  }

  void _logErrorOnce(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    if (identical(error, _lastLoggedError)) return;
    _lastLoggedError = error;

    final providerName = context.provider.name ?? context.provider.runtimeType;
    if (error is ValidationException) {
      AppLogger.error('[$providerName] $error');
      return;
    }
    AppLogger.error('[$providerName] $error', stackTrace);
  }
}
