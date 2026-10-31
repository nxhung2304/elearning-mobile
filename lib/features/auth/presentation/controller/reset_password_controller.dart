import 'package:elearning_mobile/core/exceptions/validation_exception.dart';
import 'package:elearning_mobile/core/result.dart';
import 'package:elearning_mobile/core/validators/password_validator.dart';
import 'package:elearning_mobile/features/auth/data/models/auth_session_model.dart';
import 'package:elearning_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reset_password_controller.g.dart';

@riverpod
class ResetPasswordController extends _$ResetPasswordController {
  @override
  AsyncValue<AuthSessionModel?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> resetPassword({
    required String resetPasswordToken,
    required String password,
    required String passwordConfirmation,
  }) async {
    state = const AsyncValue.loading();

    if (!PasswordValidator.isValid(password)) {
      state = AsyncValue.error(
        ValidationException([
          'Password must be at least ${PasswordValidator.minLength} characters',
        ]),
        StackTrace.current,
      );
      return;
    }

    if (password != passwordConfirmation) {
      state = AsyncValue.error(
        ValidationException(['Passwords do not match']),
        StackTrace.current,
      );
      return;
    }

    try {
      final result = await ref
          .read(authRepositoryProvider)
          .resetPassword(
            resetPasswordToken: resetPasswordToken,
            password: password,
            passwordConfirmation: passwordConfirmation,
          );
      switch (result) {
        case Ok():
          state = AsyncValue.data(null);
        case Error(error: final e):
          state = AsyncValue.error(e, StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
