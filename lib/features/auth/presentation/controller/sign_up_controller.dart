import 'package:elearning_mobile/core/exceptions/validation_exception.dart';
import 'package:elearning_mobile/core/result.dart';
import 'package:elearning_mobile/core/validators/email_validator.dart';
import 'package:elearning_mobile/core/validators/password_validator.dart';
import 'package:elearning_mobile/features/auth/data/models/auth_session_model.dart';
import 'package:elearning_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:elearning_mobile/features/auth/presentation/viewmodel/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_controller.g.dart';

@riverpod
class SignUpController extends _$SignUpController {
  @override
  AsyncValue<AuthSessionModel?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    state = const AsyncValue.loading();

    if (!EmailValidator.isValid(email)) {
      state = AsyncValue.error(
        ValidationException(['Invalid email address']),
        StackTrace.current,
      );
      return;
    }

    if (!PasswordValidator.isValid(password)) {
      state = AsyncValue.error(
        ValidationException([
          'Password must be at least ${PasswordValidator.minLength} characters',
        ]),
        StackTrace.current,
      );
      return;
    }

    if (password != confirmPassword) {
      state = AsyncValue.error(
        ValidationException(['Passwords do not match']),
        StackTrace.current,
      );
      return;
    }

    try {
      final result = await ref
          .read(authRepositoryProvider)
          .signUp(
            email: email,
            password: password,
            confirmPassword: confirmPassword,
          );
      switch (result) {
        case Ok(value: final session):
          state = AsyncValue.data(session);
          ref.invalidate(authStateProvider);
        case Error(error: final e):
          state = AsyncValue.error(e, StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
