import 'package:elearning_mobile/core/exceptions/validation_exception.dart';
import 'package:elearning_mobile/core/validators/email_validator.dart';
import 'package:elearning_mobile/features/auth/data/models/auth_session_model.dart';
import 'package:elearning_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:elearning_mobile/features/auth/presentation/viewmodel/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forgot_password_controller.g.dart';

@riverpod
class ForgotPasswordController extends _$ForgotPasswordController {
  @override
  AsyncValue<AuthSessionModel?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> forgotPassword({required String email}) async {
    state = const AsyncValue.loading();

    if (!EmailValidator.isValid(email)) {
      state = AsyncValue.error(
        ValidationException(['Invalid email address']),
        StackTrace.current,
      );
      return;
    }

    try {
      await ref.read(authRepositoryProvider).forgotPassword(email: email);
      state = AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
