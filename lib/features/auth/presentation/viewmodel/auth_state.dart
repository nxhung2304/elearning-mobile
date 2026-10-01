import 'package:elearning_mobile/features/auth/domain/entities/auth_status.dart';
import 'package:elearning_mobile/features/auth/domain/usecases/check_auth_status_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state.g.dart';

@riverpod
class AuthState extends _$AuthState {
  @override
  Future<AuthStatus> build() {
    return ref.watch(checkAuthStatusUseCaseProvider).call();
  }
}
