import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

import '../../utils/theme.dart';
import '../repositories/theme_repository.dart';

final themeProvider =
    StateNotifierProvider<ThemeNotifier, ThemeRepository>((ref) {
  return ThemeNotifier(FluDefaultThemes.blue);
});

class ThemeNotifier extends StateNotifier<ThemeRepository> {
  ThemeNotifier(FluTheme theme, {ThemeMode themeMode = ThemeMode.system})
      : super(ThemeRepository(theme: theme, themeMode: themeMode));
}
