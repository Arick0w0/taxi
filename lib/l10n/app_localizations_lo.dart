// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lao (`lo`).
class SLo extends S {
  SLo([String locale = 'lo']) : super(locale);

  @override
  String get userListTitle => 'ລາຍຊື່ຜູ້ໃຊ້';

  @override
  String get changeLanguage => 'ປ່ຽນພາສາ';

  @override
  String get hello => 'ສະບາຍດີໂລກ';

  @override
  String get noInternet => 'ບໍ່ມີການເຊື່ອມຕໍ່ອິນເຕີເນັດ';

  @override
  String get checkNetworkMessage =>
      'ກະລຸນາກວດສອບການຕັ້ງຄ່າເຄືອຂ່າຍຂອງທ່ານ ແລະ ລອງໃໝ່ອີກຄັ້ງ';

  @override
  String get retry => 'ລອງໃໝ່';
}
