import 'package:dio/dio.dart';
import 'package:elearning_mobile/app/logger/app_logger.dart';
import 'package:elearning_mobile/core/config/api_config.dart';
import 'package:elearning_mobile/core/exceptions/app_exception.dart';
import 'package:elearning_mobile/core/exceptions/network_exception.dart';
import 'package:elearning_mobile/core/exceptions/unauthorized_exception.dart';
import 'package:elearning_mobile/core/exceptions/validation_exception.dart';
import 'package:elearning_mobile/core/network/interceptors/auth_interceptor.dart';
import 'package:elearning_mobile/core/storage/auth_token_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client.g.dart';

@riverpod
ApiClient apiClient(Ref ref) {
  return ApiClient(authTokenStorage: ref.watch(authTokenStorageProvider));
}

class ApiClient {
  final Dio _dio;

  ApiClient({required AuthTokenStorage authTokenStorage, Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: ApiConfig.baseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            ),
          ) {
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: false,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          logPrint: (object) => AppLogger.info(object.toString()),
        ),
      );
    }

    _dio.interceptors.add(AuthInterceptor(authTokenStorage));
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get<T>(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        queryParameters: queryParameters,
        data: data,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.patch<T>(
        path,
        queryParameters: queryParameters,
        data: data,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        queryParameters: queryParameters,
        data: data,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  AppException _mapDioException(DioException e) {
    AppLogger.error(e, e.stackTrace);

    final statusCode = e.response?.statusCode;

    if (statusCode == 401) {
      return UnauthorizedException();
    }

    if (statusCode == 422) {
      return ValidationException(_extractErrors(e.response?.data));
    }

    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return NetworkException();
    }

    return NetworkException();
  }

  List<String> _extractErrors(dynamic data) {
    if (data is Map<String, dynamic>) {
      final errors = data['errors'];

      if (errors is List) {
        return errors.map((e) => e.toString()).toList();
      }
    }

    return ['Request failed'];
  }
}
