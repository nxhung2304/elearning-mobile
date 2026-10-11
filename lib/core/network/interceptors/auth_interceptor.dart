import 'package:dio/dio.dart';
import 'package:elearning_mobile/core/storage/auth_token_storage.dart';

class AuthInterceptor extends QueuedInterceptor {
  static const String refreshPath = '/auth/refresh';
  static const String authorizationHeader = 'Authorization';
  static const int unauthorizedStatus = 401;

  AuthInterceptor(
    this._plainDio,
    this._authTokenStorage,
    this._onSessionExpired,
  );

  final Dio _plainDio;
  final AuthTokenStorage _authTokenStorage;
  final void Function() _onSessionExpired;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _authTokenStorage.getAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers[authorizationHeader] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != unauthorizedStatus) {
      return handler.next(err);
    }

    try {
      final accessToken = await _resolveAccessToken(err.requestOptions);

      if (accessToken == null) {
        await _authTokenStorage.clearTokens();
        _onSessionExpired();
        return handler.next(err);
      }

      final retryOptions = err.requestOptions
        ..headers[authorizationHeader] = 'Bearer $accessToken';
      final response = await _plainDio.fetch(retryOptions);
      return handler.resolve(response);
    } on DioException catch (retryError) {
      return handler.next(retryError);
    }
  }

  Future<String?> _resolveAccessToken(RequestOptions failedRequest) async {
    final storedAccessToken = await _authTokenStorage.getAccessToken();
    final isRefreshedByEarlierRequest =
        storedAccessToken != null &&
        storedAccessToken.isNotEmpty &&
        failedRequest.headers[authorizationHeader] !=
            'Bearer $storedAccessToken';

    if (isRefreshedByEarlierRequest) return storedAccessToken;

    return _refreshAccessToken();
  }

  Future<String?> _refreshAccessToken() async {
    final refreshToken = await _authTokenStorage.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return null;

    try {
      final response = await _plainDio.post(
        refreshPath,
        data: {'refresh_token': refreshToken},
      );
      final data = response.data as Map<String, dynamic>;
      final accessToken = data['access_token'] as String;

      await _authTokenStorage.saveTokens(
        accessToken: accessToken,
        refreshToken: data['refresh_token'] as String,
        expiresIn: (data['expires_in'] as num).toInt(),
      );

      return accessToken;
    } on DioException catch (refreshError) {
      if (refreshError.response?.statusCode == unauthorizedStatus) return null;
      rethrow;
    }
  }
}
