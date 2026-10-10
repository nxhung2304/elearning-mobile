import 'package:dio/dio.dart';
import 'package:elearning_mobile/core/storage/auth_token_storage.dart';

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor(this._authTokenStorage);

  final AuthTokenStorage _authTokenStorage;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _authTokenStorage.getAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }
}
