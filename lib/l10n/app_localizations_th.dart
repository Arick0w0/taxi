// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class STh extends S {
  STh([String locale = 'th']) : super(locale);

  @override
  String get userListTitle => 'รายชื่อผู้ใช้';

  @override
  String get changeLanguage => 'เปลี่ยนภาษา';

  @override
  String get hello => 'สวัสดีชาวโลก';

  @override
  String get noInternet => 'ไม่มีสัญญาณอินเทอร์เน็ต';

  @override
  String get checkNetworkMessage =>
      'กรุณาตรวจสอบการตั้งค่าเครือข่ายและลองใหม่อีกครั้ง';

  @override
  String get retry => 'ลองใหม่';
}
