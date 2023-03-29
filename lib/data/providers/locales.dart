import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class LocalesNotifier extends StateNotifier<Locale> {
  LocalesNotifier() : super(const Locale('en', ''));

  void setLocale(Locale newLocale) {
    state = newLocale;
  }
}

final localesProvider = StateNotifierProvider<LocalesNotifier, Locale>((ref) {
  return LocalesNotifier();
});
