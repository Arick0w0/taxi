import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../error/exceptions.dart';
import '../auth/auth_provider.dart';
import '../auth/token_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = AppConstants.baseUrl;
  dio.options.connectTimeout = Duration(
    milliseconds: AppConstants.connectTimeout,
  );
  dio.options.receiveTimeout = Duration(
    milliseconds: AppConstants.receiveTimeout,
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        try {
          // Get token from storage
          final tokenStorage = ref.read(tokenStorageProvider);
          final token = await tokenStorage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        } catch (e) {
          // Ignore error reading token
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          // Handle Unauthorized - Auto Logout
          ref.read(authStateProvider.notifier).logout();
        }
        return handler.next(e);
      },
    ),
  );

  return dio;
});

class DioClient {
  final Dio _dio;

  DioClient(this._dio);

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(uri, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> put(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> delete(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException("Connection timed out");
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          return UnauthorizedException("Unauthorized access");
        } else if (statusCode != null && statusCode >= 500) {
          return ServerException("Server error", statusCode);
        }
        return ServerException(
          "Received invalid status code: $statusCode",
          statusCode,
        );
      case DioExceptionType.cancel:
        return NetworkException("Request cancelled");
      default:
        return NetworkException("Network error occurred");
    }
  }
}

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(ref.watch(dioProvider));
});
