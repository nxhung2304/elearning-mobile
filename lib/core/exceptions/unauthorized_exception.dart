import 'package:elearning_mobile/core/exceptions/app_exception.dart';

class UnauthorizedException extends AppException {
  @override
  String get message => 'Session expired. Please sign in again.';
}
