import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'token_storage.dart';

class AuthNotifier extends Notifier<bool> {
  late final TokenStorage _tokenStorage;

  @override
  bool build() {
    _tokenStorage = ref.read(tokenStorageProvider);
    // Check if token exists on startup (mock logic)
    return true;
  }

  Future<void> login(String token) async {
    await _tokenStorage.saveToken(token);
    state = true;
  }

  Future<void> logout() async {
    await _tokenStorage.clearToken();
    state = false;
  }
}

final authStateProvider = NotifierProvider<AuthNotifier, bool>(
  AuthNotifier.new,
);
