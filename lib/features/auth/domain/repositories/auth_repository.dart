import 'package:elearning_mobile/core/result.dart';
import 'package:elearning_mobile/features/auth/domain/entities/auth_session.dart';
import 'package:elearning_mobile/features/auth/domain/entities/auth_status.dart';

abstract class AuthRepository {
  Future<AuthStatus> getAuthStatus();
  Future<Result<AuthSession>> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  });
}
