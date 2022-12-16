import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FluTheme {
  FluTheme(BuildContext context) {
    data = context.theme;
  }

  late ThemeData data;

  Color get accentText => data.colorScheme.onSurface;
  Color get background => data.colorScheme.background;
  Brightness get brightness => data.brightness;
  Color get danger => data.colorScheme.danger;
  Color get dark => data.colorScheme.dark;
  Color get divider => data.dividerColor;
  Color get divider25 => data.dividerColor.withOpacity(.25);
  Color get divider50 => data.dividerColor.withOpacity(.5);
  Color get error => data.colorScheme.error;
  bool get isLight => data.brightness == Brightness.light;
  Color get light => data.colorScheme.light;
  Color get onError => data.colorScheme.onError;
  Color get onPrimary => data.colorScheme.onPrimary;
  Color get onSecondary => data.colorScheme.onSecondary;
  Color get onTertiary => data.colorScheme.onTertiary;
  Color get primary => data.colorScheme.primary;
  Color get secondary => data.colorScheme.secondary;
  Color get shadow => data.colorScheme.shadow;
  Color get success => data.colorScheme.success;
  Color get surfaceBackground => data.colorScheme.surface;
  Color get surfaceBackground25 => surfaceBackground.withOpacity(.25);
  Color get surfaceBackground50 => surfaceBackground.withOpacity(.5);

  /// Return the [SystemUiOverlayStyle] according to the theme [Brightness] and [Color palette].
  SystemUiOverlayStyle get systemUiOverlayStyle {
    Brightness brightness = this.brightness == Brightness.light
        ? Brightness.dark
        : Brightness.light;

    return SystemUiOverlayStyle(
      statusBarIconBrightness: brightness,
      systemNavigationBarIconBrightness: brightness,
      statusBarColor: background,
      systemNavigationBarColor: background,
    );
  }

  Color get tertiary => data.colorScheme.tertiary;
  Color get text => data.colorScheme.onBackground;

  /// Return current theme based [TextTheme]
  TextTheme get textTheme => data.textTheme;

  Color get warning => data.colorScheme.warning;
}

class FluThemeBuilder {
  FluThemeBuilder({
    this.primary = _defaultprimary,
    this.onprimary = _defaultOnprimary,
    this.secondary = _defaultsecondary,
    this.onsecondary = _defaultOnsecondary,
    this.tertiaryColor,
    this.onTertiaryColor,
    FluColorPalette? colors,
    FluColorPalette? darkColors,
    TextStyle? bodyTextStyle,
    TextStyle? headingTextStyle,
    this.scrollbarThickness = 3.5,
  }) {
    this.colors = colors ?? FluColorPalette.light();
    this.darkColors = darkColors ?? FluColorPalette.dark();

    this.bodyTextStyle = bodyTextStyle ?? GoogleFonts.poppins();
    this.headingTextStyle = headingTextStyle ?? GoogleFonts.poppins();
  }

  late TextStyle bodyTextStyle;
  late FluColorPalette colors, darkColors;
  late TextStyle headingTextStyle;
  final Color? onTertiaryColor;
  final Color onprimary;
  final Color onsecondary;
  final Color primary;
  final double scrollbarThickness;
  final Color secondary;
  final Color? tertiaryColor;

  ThemeData get darkTheme {
    final ColorScheme darkColorScheme =
        _buildColorScheme(darkColors, Brightness.dark);

    return theme.copyWith(
      brightness: darkColorScheme.brightness,
      backgroundColor: darkColorScheme.background,
      scaffoldBackgroundColor: darkColorScheme.background,
      dividerColor: darkColors.divider,
      colorScheme: darkColorScheme,
      scrollbarTheme: _buildScrollBarTheme(true),
      textTheme: _buildTextTheme(darkColors),
    );
  }

  FluColorPalette get palette => Get.isDarkMode ? darkColors : colors;
  ThemeData get theme {
    final ColorScheme colorScheme = _buildColorScheme(colors, Brightness.light);

    return ThemeData(
      brightness: colorScheme.brightness,
      primaryColor: primary,
      backgroundColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      dividerColor: colors.divider,
      colorScheme: colorScheme,
      scrollbarTheme: _buildScrollBarTheme(),
      textTheme: _buildTextTheme(colors),
    );
  }

  FluThemeBuilder copyWith({
    Color? primary,
    Color? onprimary,
    Color? secondary,
    Color? onsecondary,
    Color? tertiaryColor,
    Color? onTertiaryColor,
    FluColorPalette? colors,
    FluColorPalette? darkColors,
    double? scrollbarThickness,
  }) =>
      FluThemeBuilder(
        primary: primary ?? this.primary,
        onprimary: onprimary ?? this.onprimary,
        secondary: secondary ?? this.secondary,
        onsecondary: onsecondary ?? this.onsecondary,
        tertiaryColor: tertiaryColor ?? this.tertiaryColor,
        onTertiaryColor: onTertiaryColor ?? this.onTertiaryColor,
        colors: colors ?? this.colors,
        darkColors: darkColors ?? this.darkColors,
        scrollbarThickness: scrollbarThickness ?? this.scrollbarThickness,
        bodyTextStyle: bodyTextStyle,
        headingTextStyle: headingTextStyle,
      );

  ColorScheme _buildColorScheme(FluColorPalette colors, Brightness brightness) {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onprimary,
      secondary: secondary,
      onSecondary: onsecondary,
      tertiary: tertiaryColor,
      onTertiary: onTertiaryColor,
      error: colors.danger,
      onError: colors.onDanger,
      background: colors.background,
      onBackground: colors.text,
      surface: colors.surfaceBackground,
      onSurface: colors.accentText,
      shadow: colors.shadow,
    );
  }

  ScrollbarThemeData _buildScrollBarTheme([bool forDarkTheme = false]) =>
      ScrollbarThemeData(
        thumbColor: MaterialStatePropertyAll<Color>(
            (forDarkTheme ? darkColors.text : colors.text).withOpacity(.45)),
        thickness: const MaterialStatePropertyAll<double>(2.5),
        radius: const Radius.circular(999),
        crossAxisMargin: 3,
      );

  TextTheme _buildTextTheme(FluColorPalette colors) {
    return TextTheme(
      headlineLarge: headingTextStyle.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: Flu.appSettings.headlineFs,
        color: colors.accentText,
      ),
      headline1: headingTextStyle.copyWith(
        fontSize: Flu.appSettings.titleFs,
        fontWeight: FontWeight.bold,
        color: colors.accentText,
      ),
      headline2: headingTextStyle.copyWith(
        fontSize: Flu.appSettings.titleFs,
        fontWeight: FontWeight.w600,
        color: colors.accentText,
      ),
      subtitle1: bodyTextStyle.copyWith(
        fontSize: Flu.appSettings.subtitleFs,
        fontWeight: FontWeight.w600,
        color: colors.accentText,
      ),
      subtitle2: bodyTextStyle.copyWith(
        fontSize: Flu.appSettings.subtitleFs,
        fontWeight: FontWeight.w600,
        color: colors.accentText,
      ),
      bodyText1: bodyTextStyle.copyWith(
        fontSize: Flu.appSettings.bodyFs,
        fontWeight: FontWeight.normal,
        color: colors.text,
      ),
      bodyText2: bodyTextStyle.copyWith(
        fontSize: Flu.appSettings.bodyFs,
        fontWeight: FontWeight.normal,
        color: colors.text,
      ),
    );
  }
}

extension FluColorScheme on ColorScheme {
  Color get light => Flu.appController.themeBuilder.palette.light;
  Color get dark => Flu.appController.themeBuilder.palette.dark;
  Color get danger => Flu.appController.themeBuilder.palette.danger;
  Color get warning => Flu.appController.themeBuilder.palette.warning;
  Color get success => Flu.appController.themeBuilder.palette.success;
}

const Color _defaultprimary = Color(0xff0072ff);
const Color _defaultOnprimary = Colors.white;
const Color _defaultsecondary = Colors.orange;
const Color _defaultOnsecondary = Colors.white;
