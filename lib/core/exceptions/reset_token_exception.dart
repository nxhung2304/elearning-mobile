import 'package:elearning_mobile/core/exceptions/app_exception.dart';

class ResetTokenException implements AppException {
  static const String expired = 'reset_token_expired';
  static const String invalid = 'reset_token_invalid';

  final String code;

  ResetTokenException({required this.code});

  static const Set<String> codes = {expired, invalid};

  static bool supports({required String? code}) => codes.contains(code);

  @override
  String get message => switch (code) {
    expired => 'Token đặt lại mật khẩu đã hết hạn. Vui lòng xác thực lại OTP.',
    invalid => 'Token đặt lại mật khẩu không hợp lệ.',
    _ => 'Đã xảy ra lỗi với token đặt lại mật khẩu.',
  };
}
