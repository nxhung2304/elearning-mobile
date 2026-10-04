import 'package:elearning_mobile/core/exceptions/app_exception.dart';

class HttpException implements AppException {
  const HttpException();

  @override
  String get message => 'Something went wrong. Please try again.';
}
