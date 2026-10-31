import 'package:elearning_mobile/core/result.dart';
import 'package:elearning_mobile/features/auth/data/models/auth_session_model.dart';
import 'package:elearning_mobile/features/auth/data/models/reset_password_model.dart';
import 'package:elearning_mobile/features/auth/domain/entities/auth_status.dart';

abstract class AuthRepository {
  Future<AuthStatus> getAuthStatus();
  Future<Result<AuthSessionModel>> signUp({
    required String email,
    required String password,
    required String passwordConfirmation,
  });
  Future<Result<AuthSessionModel>> signIn({
    required String email,
    required String password,
  });
  Future<Result<void>> signOut();
  Future<Result<void>> forgotPassword({required String email});
  Future<Result<ResetPasswordModel>> vertifyOtp({
    required String email,
    required String otpCode,
  });
  Future<Result<void>> resetPassword({
    required String resetPasswordToken,
    required String password,
    required String passwordConfirmation,
  });
}
