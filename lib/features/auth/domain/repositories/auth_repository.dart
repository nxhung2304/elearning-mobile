import 'package:elearning_mobile/core/result.dart';
import 'package:elearning_mobile/features/auth/data/models/auth_session_model.dart';
import 'package:elearning_mobile/features/auth/domain/entities/auth_status.dart';

abstract class AuthRepository {
  Future<AuthStatus> getAuthStatus();
  Future<Result<AuthSessionModel>> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  });
  Future<Result<AuthSessionModel>> signIn({
    required String email,
    required String password,
  });
  Future<Result<void>> signOut();
}
