import 'package:elearning_mobile/core/exceptions/validation_exception.dart';
import 'package:elearning_mobile/core/result.dart';
import 'package:elearning_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:elearning_mobile/features/auth/domain/entities/auth_session.dart';
import 'package:elearning_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_use_case.g.dart';

@riverpod
SignUpUseCase signUpUseCase(Ref ref) {
  return SignUpUseCase(ref.watch(authRepositoryProvider));
}

class SignUpUseCase {
  static const int minPasswordLength = 6;
  static const String invalidEmailError = 'Invalid email address';
  static const String invalidPasswordError =
      'Password must be at least $minPasswordLength characters';
  static const String invalidConfirmPasswordError = 'Passwords do not match';

  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  Future<Result<AuthSession>> call({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (!_isValidEmail(email)) {
      return Result.error(ValidationException([invalidEmailError]));
    }

    if (!_isValidPassword(password)) {
      return Result.error(ValidationException([invalidPasswordError]));
    }

    if (!_isValidConfirmPassword(password, confirmPassword)) {
      return Result.error(ValidationException([invalidConfirmPasswordError]));
    }

    return _authRepository.signUp(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  bool _isValidEmail(String email) {
    return email.isNotEmpty &&
        RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.isNotEmpty && password.length >= minPasswordLength;
  }

  bool _isValidConfirmPassword(String password, String confirmPassword) {
    return confirmPassword.isNotEmpty && password == confirmPassword;
  }
}
