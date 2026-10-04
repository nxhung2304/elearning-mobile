import 'package:elearning_mobile/core/exceptions/app_exception.dart';

class ValidationException implements AppException {
  final List<String> errors;

  const ValidationException(this.errors);

  @override
  String get message => errors.join('\n');
}
