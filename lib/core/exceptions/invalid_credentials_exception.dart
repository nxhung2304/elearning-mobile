import 'package:elearning_mobile/core/exceptions/app_exception.dart';

class InvalidCredentialsException implements AppException {
  const InvalidCredentialsException();

  @override
  String get message => 'Invalid email or password.';
}
