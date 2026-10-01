import 'package:elearning_mobile/core/storage/secure_storage.dart';
import 'package:elearning_mobile/features/auth/domain/entities/auth_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_local_data_source.g.dart';

@riverpod
AuthLocalDataSource authLocalDataSource(Ref ref) {
  return AuthLocalDataSource(ref.watch(secureStorageProvider));
}

class AuthLocalDataSource {
  static const _accessTokenKey = 'access_token';

  final SecureStorage _secureStorage;

  AuthLocalDataSource(this._secureStorage);

  Future<AuthStatus> getAuthStatus() async {
    try {
      final token = await _secureStorage.read(key: _accessTokenKey);

      if (token == null || token.isEmpty) return AuthStatus.unauthenticated;

      return AuthStatus.authenticated;
    } catch (e) {
      return AuthStatus.unauthenticated;
    }
  }
}
