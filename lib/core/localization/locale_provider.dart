import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    // Default to English. In a real app, you might save this in SharedPreferences.
    return const Locale('en');
  }

  void setLocale(Locale locale) {
    if (!['en', 'th', 'lo'].contains(locale.languageCode)) return;
    state = locale;
  }

  void toggleLocale() {
    if (state.languageCode == 'en') {
      state = const Locale('th');
    } else if (state.languageCode == 'th') {
      state = const Locale('lo');
    } else {
      state = const Locale('en');
    }
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(() {
  return LocaleNotifier();
});
