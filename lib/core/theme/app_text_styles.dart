import 'package:flutter/material.dart';
import 'app_dimens.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle displayLarge = TextStyle(
    fontSize: AppDimens.fontDisplay,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: AppDimens.fontL,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: AppDimens.fontM,
    fontWeight: FontWeight.w500,
  );
}
