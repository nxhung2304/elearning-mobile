import 'package:elearning_mobile/features/auth/domain/entities/user.dart';

class AuthSession {
  final String token;
  final User user;

  const AuthSession({required this.token, required this.user});
}
