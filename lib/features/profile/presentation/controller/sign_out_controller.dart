import 'package:elearning_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:elearning_mobile/features/auth/presentation/viewmodel/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_out_controller.g.dart';

@riverpod
class SignOutController extends _$SignOutController {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();

    try {
      await ref.read(authRepositoryProvider).signOut();

      if (!ref.mounted) return;

      state = AsyncValue.data(null);
      ref.invalidate(authStateProvider);
    } catch (e, st) {
      if (!ref.mounted) return;

      state = AsyncValue.error(e, st);
    }
  }
}
