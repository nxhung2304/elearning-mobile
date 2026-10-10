import 'package:elearning_mobile/core/result.dart';
import 'package:elearning_mobile/features/auth/data/models/auth_session_model.dart';
import 'package:elearning_mobile/features/auth/domain/usecases/sign_in_use_case.dart';
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

    try {
      final result = await ref
          .read(signInUseCaseProvider)
          .call(email: email, password: password);
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
