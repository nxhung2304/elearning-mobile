import 'package:elearning_mobile/core/result.dart';
import 'package:elearning_mobile/features/auth/domain/entities/auth_session.dart';
import 'package:elearning_mobile/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_controller.g.dart';

@riverpod
class SignUpController extends _$SignUpController {
  @override
  AsyncValue<AuthSession?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    state = const AsyncValue.loading();

    try {
      final result = await ref
          .read(signUpUseCaseProvider)
          .call(
            email: email,
            password: password,
            confirmPassword: confirmPassword,
          );
      switch (result) {
        case Ok(value: final session):
          state = AsyncValue.data(session);
        case Error(error: final e):
          state = AsyncValue.error(e, StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
