import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Flutter MVVM Template';
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';

  // Network
  // Helper for testing allows injecting mock values
  static Map<String, String>? _mockEnv;
  static void setMockEnv(Map<String, String> env) => _mockEnv = env;

  static String get baseUrl =>
      _mockEnv?['BASE_URL'] ?? dotenv.env['BASE_URL'] ?? '';
  static int get connectTimeout => int.parse(
    _mockEnv?['CONNECT_TIMEOUT'] ?? dotenv.env['CONNECT_TIMEOUT'] ?? '30000',
  );
  static int get receiveTimeout => int.parse(
    _mockEnv?['RECEIVE_TIMEOUT'] ?? dotenv.env['RECEIVE_TIMEOUT'] ?? '30000',
  );

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String themeKey = 'app_theme';
  static const String localeKey = 'app_locale';
}
