import 'package:elearning_mobile/core/result.dart';
import 'package:elearning_mobile/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:elearning_mobile/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:elearning_mobile/features/auth/data/models/auth_session_model.dart';
import 'package:elearning_mobile/features/auth/domain/entities/auth_session.dart';
import 'package:elearning_mobile/features/auth/domain/entities/auth_status.dart';
import 'package:elearning_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_impl.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    ref.watch(authLocalDataSourceProvider),
    ref.watch(authRemoteDataSourceProvider),
  );
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<AuthStatus> getAuthStatus() {
    return _localDataSource.getAuthStatus();
  }

  @override
  Future<Result<AuthSession>> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final Result<AuthSessionModel> result = await _remoteDataSource.signUp(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    switch (result) {
      case Ok(value: final session):
        await _localDataSource.saveAccessToken(session.token);
        return Result.ok(session.toEntity());
      case Error(error: final e):
        return Result.error(e);
    }
  }
}
