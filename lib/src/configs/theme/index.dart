import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FluTheme {
  late ThemeData data;

  FluTheme(BuildContext context) {
    data = context.theme;
  }

  Brightness get brightness => data.brightness;

  bool get isLight => data.brightness == Brightness.light;

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

  /// Return current theme based [TextTheme]
  TextTheme get textTheme => data.textTheme;

  Color get primary => data.colorScheme.primary;
  Color get onPrimary => data.colorScheme.onPrimary;
  Color get secondary => data.colorScheme.secondary;
  Color get onSecondary => data.colorScheme.onSecondary;
  Color get tertiary => data.colorScheme.tertiary;
  Color get onTertiary => data.colorScheme.onTertiary;
  Color get background => data.colorScheme.background;
  Color get surfaceBackground => data.colorScheme.surface;
  Color get surfaceBackground50 => surfaceBackground.withOpacity(.5);
  Color get surfaceBackground25 => surfaceBackground.withOpacity(.25);
  Color get text => data.colorScheme.onBackground;
  Color get accentText => data.colorScheme.onSurface;
  Color get divider => data.dividerColor;
  Color get divider50 => data.dividerColor.withOpacity(.5);
  Color get divider25 => data.dividerColor.withOpacity(.25);
  Color get shadow => data.colorScheme.shadow;
  Color get light => data.colorScheme.light;
  Color get dark => data.colorScheme.dark;
  Color get error => data.colorScheme.error;
  Color get onError => data.colorScheme.onError;
  Color get danger => data.colorScheme.danger;
  Color get warning => data.colorScheme.warning;
  Color get success => data.colorScheme.success;
}

class FluThemeBuilder {
  final Color primary;
  final Color onprimary;
  final Color secondary;
  final Color onsecondary;
  final Color? tertiaryColor;
  final Color? onTertiaryColor;

  final double scrollbarThickness;

  late FluColorPalette colors, darkColors;

  late TextStyle bodyTextStyle;
  late TextStyle subtitleTextStyle;
  late TextStyle headingTextStyle;

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
    TextStyle? subtitleTextStyle,
    TextStyle? headingTextStyle,
    this.scrollbarThickness = 3.5,
  }) {
    this.colors = colors ?? FluColorPalette.light();
    this.darkColors = darkColors ?? FluColorPalette.dark();

    this.bodyTextStyle = bodyTextStyle ?? GoogleFonts.poppins();
    this.subtitleTextStyle = subtitleTextStyle ?? GoogleFonts.poppins();
    this.headingTextStyle = headingTextStyle ?? GoogleFonts.poppins();
  }

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
        fontWeight: Flu.appSettings.textBold,
        fontSize: Flu.appSettings.headlineFs,
        color: colors.accentText,
      ),
      headline1: headingTextStyle.copyWith(
        fontSize: Flu.appSettings.titleFs,
        fontWeight: Flu.appSettings.textBold,
        color: colors.accentText,
      ),
      headline2: headingTextStyle.copyWith(
        fontSize: Flu.appSettings.titleFs,
        fontWeight: Flu.appSettings.textSemibold,
        color: colors.accentText,
      ),
      subtitle1: subtitleTextStyle.copyWith(
        fontSize: Flu.appSettings.subtitleFs,
        fontWeight: Flu.appSettings.textSemibold,
        color: colors.accentText,
      ),
      subtitle2: subtitleTextStyle.copyWith(
        fontSize: Flu.appSettings.subtitleFs,
        fontWeight: Flu.appSettings.textSemibold,
        color: colors.accentText,
      ),
      bodyText1: bodyTextStyle.copyWith(
        fontSize: Flu.appSettings.bodyFs,
        fontWeight: Flu.appSettings.textNormal,
        color: colors.text,
      ),
      bodyText2: bodyTextStyle.copyWith(
        fontSize: Flu.appSettings.bodyFs,
        fontWeight: Flu.appSettings.textNormal,
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
