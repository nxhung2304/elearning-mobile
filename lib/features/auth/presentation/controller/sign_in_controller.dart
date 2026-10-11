import 'package:elearning_mobile/core/exceptions/validation_exception.dart';
import 'package:elearning_mobile/core/result.dart';
import 'package:elearning_mobile/core/validators/email_validator.dart';
import 'package:elearning_mobile/core/validators/password_validator.dart';
import 'package:elearning_mobile/features/auth/data/models/auth_session_model.dart';
import 'package:elearning_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:elearning_mobile/features/auth/presentation/viewmodel/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_controller.g.dart';

@riverpod
class SignInController extends _$SignInController {
  @override
  AsyncValue<AuthSessionModel?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> signIn({required String email, required String password}) async {
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

    try {
      final result = await ref
          .read(authRepositoryProvider)
          .signIn(email: email, password: password);
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
