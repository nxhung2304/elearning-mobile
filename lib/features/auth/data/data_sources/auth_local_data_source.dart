import 'package:elearning_mobile/core/storage/app_shared_preference.dart';
import 'package:elearning_mobile/core/storage/auth_token_storage.dart';
import 'package:elearning_mobile/features/auth/domain/entities/auth_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_local_data_source.g.dart';

@riverpod
AuthLocalDataSource authLocalDataSource(Ref ref) {
  return AuthLocalDataSource(
    ref.watch(authTokenStorageProvider),
    ref.watch(appSharedPreferenceProvider),
  );
}

class AuthLocalDataSource {
  static const _hasLaunchedBeforeKey = 'has_launched_before';

  final AuthTokenStorage _authTokenStorage;
  final AppSharedPreference _appSharedPreference;

  AuthLocalDataSource(this._authTokenStorage, this._appSharedPreference);

  Future<AuthStatus> getAuthStatus() async {
    try {
      final validTokens = await _authTokenStorage.isValidTokens();

      if (!validTokens) return AuthStatus.unauthenticated;

      return AuthStatus.authenticated;
    } catch (e) {
      return AuthStatus.unauthenticated;
    }
  }

  Future<void> clearTokenOnFreshInstall() async {
    final hasLaunchedBefore =
        await _appSharedPreference.getBool(_hasLaunchedBeforeKey) ?? false;
    if (hasLaunchedBefore) return;

    await _authTokenStorage.clearTokens();
    await _appSharedPreference.setBool(key: _hasLaunchedBeforeKey, value: true);
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
  }) => _authTokenStorage.saveTokens(
    accessToken: accessToken,
    refreshToken: refreshToken,
    expiresIn: expiresIn,
  );

  Future<String?> getRefreshToken() => _authTokenStorage.getRefreshToken();

  Future<void> clearTokens() => _authTokenStorage.clearTokens();
}
