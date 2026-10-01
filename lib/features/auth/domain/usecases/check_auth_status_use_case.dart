import 'package:elearning_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:elearning_mobile/features/auth/domain/entities/auth_status.dart';
import 'package:elearning_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'check_auth_status_use_case.g.dart';

@riverpod
CheckAuthStatusUseCase checkAuthStatusUseCase(Ref ref) {
  return CheckAuthStatusUseCase(ref.watch(authRepositoryProvider));
}

class CheckAuthStatusUseCase {
  final AuthRepository _authRepository;

  CheckAuthStatusUseCase(this._authRepository);

  Future<AuthStatus> call() async {
    return await _authRepository.getAuthStatus();
  }
}
