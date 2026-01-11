import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class TokenStorage {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}

// Simple In-Memory implementation for the template
// Replace this with FlutterSecureStorage or SharedPreferences in production
class InMemoryTokenStorage implements TokenStorage {
  String? _token;

  @override
  Future<void> saveToken(String token) async {
    _token = token;
  }

  @override
  Future<String?> getToken() async {
    return _token;
  }

  @override
  Future<void> clearToken() async {
    _token = null;
  }
}

final tokenStorageProvider = Provider<TokenStorage>((ref) => InMemoryTokenStorage());
