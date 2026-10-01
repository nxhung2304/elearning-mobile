import 'package:elearning_mobile/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:elearning_mobile/features/auth/domain/entities/auth_status.dart';
import 'package:elearning_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_impl.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.watch(authLocalDataSourceProvider));
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<AuthStatus> getAuthStatus() {
    return _dataSource.getAuthStatus();
  }
}
