import 'package:elearning_mobile/core/result.dart';
import 'package:elearning_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vertify_otp_controller.g.dart';

@riverpod
class VertifyOtpController extends _$VertifyOtpController {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<void> vertifyOtp({
    required String email,
    required String otpCode,
  }) async {
    state = const AsyncValue.loading();

    try {
      final result = await ref
          .read(authRepositoryProvider)
          .vertifyOtp(email: email, otpCode: otpCode);
      switch (result) {
        case Ok():
          state = const AsyncValue.data(null);
        case Error(error: final e):
          state = AsyncValue.error(e, StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
