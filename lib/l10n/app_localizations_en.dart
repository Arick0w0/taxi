// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get userListTitle => 'User List';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get hello => 'Hello World';

  @override
  String get noInternet => 'No Internet Connection';

  @override
  String get checkNetworkMessage =>
      'Please check your network settings and try again.';

  @override
  String get retry => 'Retry';
}
