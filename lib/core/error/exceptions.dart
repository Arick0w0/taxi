class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class ServerException implements Exception {
  final String message;
  final int? statusCode;
  ServerException(this.message, [this.statusCode]);
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
}

class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}
