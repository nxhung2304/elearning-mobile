import 'package:elearning_mobile/core/storage/secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_token_storage.g.dart';

@riverpod
AuthTokenStorage authTokenStorage(Ref ref) {
  return AuthTokenStorage(ref.watch(secureStorageProvider));
}

class AuthTokenStorage {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _expiresAtKey = 'expires_at';

  final SecureStorage _secureStorage;

  AuthTokenStorage(this._secureStorage);

  Future<void> saveAccessToken(String accessToken) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<void> saveExpiresAt(int expiresIn) async {
    final expiresAt = DateTime.now().add(Duration(seconds: expiresIn));
    await _secureStorage.write(
      key: _expiresAtKey,
      value: expiresAt.millisecondsSinceEpoch.toString(),
    );
  }

  Future<DateTime?> getExpiresAt() async {
    final expiresAtString = await _secureStorage.read(key: _expiresAtKey);
    final expiresAtMilliseconds = int.tryParse(expiresAtString ?? '');
    if (expiresAtMilliseconds == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(expiresAtMilliseconds);
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  Future<bool> validExpiresIn() async {
    final expiresAt = await getExpiresAt();

    if (expiresAt == null) return false;

    return DateTime.now().isBefore(expiresAt);
  }

  Future<void> clearTokens() async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
    await _secureStorage.delete(key: _expiresAtKey);
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
  }) async {
    await saveAccessToken(accessToken);
    await saveRefreshToken(refreshToken);
    await saveExpiresAt(expiresIn);
  }

  Future<bool> isValidTokens() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();
    final isValidExpiresIn = await validExpiresIn();

    if (accessToken == null || accessToken.isEmpty) {
      return false;
    }
    if (refreshToken == null || refreshToken.isEmpty) {
      return false;
    }

    if (!isValidExpiresIn) {
      return false;
    }

    return true;
  }
}
