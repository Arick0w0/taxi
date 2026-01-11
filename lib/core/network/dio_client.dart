import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../error/exceptions.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = 'https://jsonplaceholder.typicode.com';
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 3);

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add auth headers if needed
        // options.headers['Authorization'] = 'Bearer ...';
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        if (e.response?.statusCode == 401) {
          // Handle Unauthorized
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

  // Add post, put, delete methods as needed

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
