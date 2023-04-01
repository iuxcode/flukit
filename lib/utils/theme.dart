import 'package:flutter/material.dart';

/// Material design 3 recommended font sizes.
/// https://m3.material.io/styles/typography/type-scale-tokens#40fc37f8-3269-4aa3-9f28-c6113079ac5d
class M3FontSizes {
  static const double displaySmall = 36;
  static const double displayMedium = 45;
  static const double displayLarge = 57;

  static const double headlineSmall = 24;
  static const double headlineMedium = 28;
  static const double headlineLarge = 32;

  static const double titleSmall = 14;
  static const double titleMedium = 16;
  static const double titleLarge = 22;

  static const double bodySmall = 12;
  static const double bodyMedium = 14;
  static const double bodyLarge = 16;

  static const double labelSmall = 11;
  static const double labelMedium = 12;
  static const double labelLarge = 14;
}

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