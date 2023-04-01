import 'package:flutter/material.dart';

/// Easily theme your app.
/// This will help you create [ThemeData] from primary [Color] or [ColorScheme]
/// if there is no [darkColors], the dark theme will be generated automatically
class FluTheme {
  final Color? seedColor;
  final ColorScheme? lightColors;
  final ColorScheme? darkColors;

  const FluTheme({
    this.seedColor,
    this.lightColors,
    this.darkColors,
  }) : assert(seedColor != null || lightColors != null);

  ThemeData get light => ThemeData.from(
      colorScheme: lightColors ?? ColorScheme.fromSeed(seedColor: seedColor!),
      useMaterial3: true);

  ThemeData get dark => light.copyWith(
      colorScheme: darkColors ?? ColorScheme.fromSeed(seedColor: seedColor!));
}

/* class FluTheme {
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

const Color _defaultSeedColor = Color(0xFF1651E7); */