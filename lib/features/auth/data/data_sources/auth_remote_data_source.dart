import 'dart:io';

import 'package:elearning_mobile/core/exceptions/app_exception.dart';
import 'package:elearning_mobile/core/network/api_client.dart';
import 'package:elearning_mobile/core/result.dart';
import 'package:elearning_mobile/features/auth/data/models/auth_session_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_data_source.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRemoteDataSource(apiClient);
}

class AuthRemoteDataSource {
  static const String signUpEndpoint = '/auth/sign_up';
  static const String signInEndpoint = '/auth/sign_in';
  static const int signUpSuccess = 201;
  static const int signInSuccess = 200;

  final ApiClient _apiClient;

  AuthRemoteDataSource(this._apiClient);

  Future<Result<AuthSessionModel>> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await _apiClient.post(
        signUpEndpoint,
        data: {
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        },
      );

      if (response.statusCode == signUpSuccess) {
        return Result.ok(AuthSessionModel.fromJson(response.data));
      } else {
        return Result.error(HttpException('Invalid response'));
      }
    } on AppException catch (exception) {
      return Result.error(exception);
    }
  }

  Future<Result<AuthSessionModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        signInEndpoint,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == signInSuccess) {
        return Result.ok(AuthSessionModel.fromJson(response.data));
      } else {
        return Result.error(HttpException('Invalid response'));
      }
    } on AppException catch (exception) {
      return Result.error(exception);
    }
  }
}
