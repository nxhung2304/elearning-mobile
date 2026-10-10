import 'package:elearning_mobile/core/result.dart';
import 'package:elearning_mobile/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:elearning_mobile/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:elearning_mobile/features/auth/data/models/auth_session_model.dart';
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
  Future<AuthStatus> getAuthStatus() async {
    await _localDataSource.clearTokenOnFreshInstall();
    return _localDataSource.getAuthStatus();
  }

  @override
  Future<Result<AuthSessionModel>> signUp({
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
        await _localDataSource.saveTokens(
          accessToken: session.accessToken,
          refreshToken: session.refreshToken,
          expiresIn: session.expiresIn,
        );
        return Result.ok(session);
      case Error(error: final e):
        return Result.error(e);
    }
  }

  @override
  Future<Result<AuthSessionModel>> signIn({
    required String email,
    required String password,
  }) async {
    final Result<AuthSessionModel> result = await _remoteDataSource.signIn(
      email: email,
      password: password,
    );
    switch (result) {
      case Ok(value: final session):
        await _localDataSource.saveTokens(
          accessToken: session.accessToken,
          refreshToken: session.refreshToken,
          expiresIn: session.expiresIn,
        );
        return Result.ok(session);
      case Error(error: final e):
        return Result.error(e);
    }
  }

  @override
  Future<Result<void>> signOut() async {
    final refreshToken = await _localDataSource.getRefreshToken();

    try {
      if (refreshToken != null && refreshToken.isNotEmpty) {
        await _remoteDataSource.signOut(refreshToken: refreshToken);
      }
    } finally {
      await _localDataSource.clearTokens();
    }

    return Result.ok(null);
  }
}
