import 'package:flutter/material.dart';

import '../../utils/theme_utils.dart';

class ThemeRepository {
  ThemeRepository(
      {FluTheme theme = FluDefaultThemes.blue,
      ThemeMode themeMode = ThemeMode.system}) {
    _theme = theme;
    _themeMode = themeMode;
  }

  late FluTheme _theme;
  late ThemeMode _themeMode;

  FluTheme get currentTheme => _theme;
  ThemeMode get themeMode => _themeMode;

  void toggleDarkMode() =>
      _themeMode == ThemeMode.system || _themeMode == ThemeMode.light
          ? _themeMode == ThemeMode.dark
          : _themeMode == ThemeMode.light;

  void resetSystemThemeMode() => _themeMode = ThemeMode.system;

  void setTheme(FluTheme newTheme) => _theme = newTheme;
}

class FluDefaultThemes {
  static const FluTheme blue = FluTheme(seedColor: Color(0xFF1651E7));
}
