import 'package:flutter/material.dart';

class FluTheme {
  FluTheme({
    this.colorSchemeSeed,
    this.lightColorScheme,
    this.darkColorScheme,
  });

  final Color? colorSchemeSeed;
  final ColorScheme? darkColorScheme;
  final ColorScheme? lightColorScheme;

  ThemeData get light => _buildTheme(lightColorScheme ??
      ColorScheme.fromSeed(
        seedColor: colorSchemeSeed ?? _defaultSeedColor,
        brightness: Brightness.light,
      ));
  ThemeData get dark => _buildTheme(darkColorScheme ??
      ColorScheme.fromSeed(
        seedColor: colorSchemeSeed ?? _defaultSeedColor,
        brightness: Brightness.dark,
      ));

  ThemeData _buildTheme(ColorScheme colorScheme) => ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
      );
}

const Color _defaultSeedColor = Color(0xFF1651E7);
