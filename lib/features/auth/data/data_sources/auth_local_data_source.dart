import 'package:elearning_mobile/core/storage/app_shared_preference.dart';
import 'package:elearning_mobile/core/storage/secure_storage.dart';
import 'package:elearning_mobile/features/auth/domain/entities/auth_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_local_data_source.g.dart';

@riverpod
AuthLocalDataSource authLocalDataSource(Ref ref) {
  return AuthLocalDataSource(
    ref.watch(secureStorageProvider),
    ref.watch(appSharedPreferenceProvider),
  );
}

class AuthLocalDataSource {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _expiresInKey = 'expires_in';
  static const _hasLaunchedBeforeKey = 'has_launched_before';

  final SecureStorage _secureStorage;
  final AppSharedPreference _appSharedPreference;

  AuthLocalDataSource(this._secureStorage, this._appSharedPreference);

  Future<AuthStatus> getAuthStatus() async {
    try {
      final accessToken = await _secureStorage.read(key: _accessTokenKey);
      final refreshToken = await _secureStorage.read(key: _refreshTokenKey);

      if (accessToken == null || accessToken.isEmpty) {
        return AuthStatus.unauthenticated;
      }
      if (refreshToken == null || refreshToken.isEmpty) {
        return AuthStatus.unauthenticated;
      }

      return AuthStatus.authenticated;
    } catch (e) {
      return AuthStatus.unauthenticated;
    }
  }

  Future<void> clearTokenOnFreshInstall() async {
    final hasLaunchedBefore =
        await _appSharedPreference.getBool(_hasLaunchedBeforeKey) ?? false;
    if (hasLaunchedBefore) return;

    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
    await _appSharedPreference.setBool(key: _hasLaunchedBeforeKey, value: true);
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
  }) async {
    await saveAccessToken(accessToken);
    await saveRefreshToken(refreshToken);
    await saveExpiresIn(expiresIn);
  }

  Future<void> saveAccessToken(String accessToken) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<void> saveExpiresIn(int expiresIn) async {
    await _secureStorage.write(key: _expiresInKey, value: expiresIn.toString());
  }
}
