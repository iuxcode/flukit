import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalesNotifier extends StateNotifier<Locale> {
  LocalesNotifier() : super(const Locale('en', ''));

  void setLocale(Locale newLocale) {
    state = newLocale;
  }
}

final localesProvider = StateNotifierProvider<LocalesNotifier, Locale>((ref) {
  return LocalesNotifier();
});
