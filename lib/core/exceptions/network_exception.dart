import 'package:elearning_mobile/core/exceptions/app_exception.dart';

class NetworkException implements AppException {
  @override
  String get message => 'No internet connection.';
}
