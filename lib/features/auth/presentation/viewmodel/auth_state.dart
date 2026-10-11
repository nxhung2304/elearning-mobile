import 'package:elearning_mobile/core/network/session_expired_signal.dart';
import 'package:elearning_mobile/features/auth/domain/entities/auth_status.dart';
import 'package:elearning_mobile/features/auth/domain/usecases/check_auth_status_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state.g.dart';

@riverpod
class AuthState extends _$AuthState {
  @override
  Future<AuthStatus> build() {
    ref.watch(sessionExpiredSignalProvider);
    return ref.watch(checkAuthStatusUseCaseProvider).call();
  }
}
