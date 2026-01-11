import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Flutter MVVM Template';
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';

  // Network
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static int get connectTimeout =>
      int.parse(dotenv.env['CONNECT_TIMEOUT'] ?? '30000');
  static int get receiveTimeout =>
      int.parse(dotenv.env['RECEIVE_TIMEOUT'] ?? '30000');

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String themeKey = 'app_theme';
  static const String localeKey = 'app_locale';
}
