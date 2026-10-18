import 'package:elearning_mobile/core/exceptions/app_exception.dart';

class ValidationException implements AppException {
  final List<String> errors;
  final int? remainingAttempts;

  const ValidationException(this.errors, {this.remainingAttempts});

  @override
  String get message => errors.join('\n');

  @override
  String toString() => message;
}
