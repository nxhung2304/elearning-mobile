import 'package:elearning_mobile/core/exceptions/validation_exception.dart';
import 'package:elearning_mobile/core/result.dart';
import 'package:elearning_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:elearning_mobile/features/auth/data/models/auth_session_model.dart';
import 'package:elearning_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_use_case.g.dart';

@riverpod
SignInUseCase signInUseCase(Ref ref) {
  return SignInUseCase(ref.watch(authRepositoryProvider));
}

class SignInUseCase {
  static const int minPasswordLength = 6;
  static const String invalidEmailError = 'Invalid email address';
  static const String invalidPasswordError =
      'Password must be at least $minPasswordLength characters';

  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  Future<Result<AuthSessionModel>> call({
    required String email,
    required String password,
  }) async {
    if (!_isValidEmail(email)) {
      return Result.error(ValidationException([invalidEmailError]));
    }

    if (!_isValidPassword(password)) {
      return Result.error(ValidationException([invalidPasswordError]));
    }

    return _authRepository.signIn(email: email, password: password);
  }

  bool _isValidEmail(String email) {
    return email.isNotEmpty &&
        RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.isNotEmpty && password.length >= minPasswordLength;
  }
}
