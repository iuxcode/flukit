import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'palette.dart';

class FluTheme {
  final Brightness brightness;

  late FluColorPalette _colors, _darkColors;

  late TextStyle _bodyTextStyle;
  late TextStyle _subtitleTextStyle;
  late TextStyle _headingTextStyle;

  final Color primaryColor;
  final Color primaryTextColor;
  final Color secondaryColor;

  FluTheme({
    this.brightness = Brightness.light,
    this.primaryColor = _defaultPrimaryColor,
    this.primaryTextColor = _defaultPrimaryTextColor,
    this.secondaryColor = _defaultSecondaryColor,
    FluColorPalette? colors,
    FluColorPalette? darkColors,
    TextStyle? bodyTextStyle,
    TextStyle? subtitleTextStyle,
    TextStyle? headingTextStyle,
  }) {
    _colors = colors ?? FluColorPalette.light();
    _darkColors = darkColors ?? FluColorPalette.dark();

    _bodyTextStyle = bodyTextStyle ?? GoogleFonts.poppins();
    _subtitleTextStyle = subtitleTextStyle ?? GoogleFonts.poppins();
    _headingTextStyle = headingTextStyle ?? GoogleFonts.poppins();
  }

  /// Return [true] if theme [Brightness] is dark.
  bool get isDark => brightness == Brightness.dark;

  /// Return the [SystemUiOverlayStyle] according to the theme [Brightness] and [Color palette].
  SystemUiOverlayStyle get systemStyle => SystemUiOverlayStyle(
        statusBarIconBrightness: brightness,
        systemNavigationBarIconBrightness: brightness,
        statusBarColor: Get.isDarkMode ? _darkColors.background : _colors.background,
        systemNavigationBarColor:
            Get.isDarkMode ? _darkColors.background : _colors.background,
      );

  /// Return current theme based [FluColorPalette]
  FluColorPalette get colors => Get.isDarkMode ? _darkColors : _colors;

  /// Return current theme based [TextTheme]
  TextTheme get textTheme => (Get.isDarkMode ? darkTheme : theme).textTheme;

  /// Build and return corresponding [themeData]
  ThemeData _buildThemeData(FluColorPalette colorPalette) => ThemeData(
        primaryColor: primaryColor,
        backgroundColor: colorPalette.background,
        scaffoldBackgroundColor: colorPalette.background,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: secondaryColor),
        textTheme: TextTheme(
          headlineLarge: headingTextStyle.copyWith(
            fontWeight: Flukit.appSettings.textBold,
            fontSize: Flukit.appSettings.headlineFs,
            color: colorPalette.accentText,
          ),
          headline1: headingTextStyle.copyWith(
            fontSize: Flukit.appSettings.titleFs,
            fontWeight: Flukit.appSettings.textBold,
            color: colorPalette.accentText,
          ),
          headline2: headingTextStyle.copyWith(
            fontSize: Flukit.appSettings.titleFs,
            fontWeight: Flukit.appSettings.textSemibold,
            color: colorPalette.accentText,
          ),
          subtitle1: subtitleTextStyle.copyWith(
            fontSize: Flukit.appSettings.subtitleFs,
            fontWeight: Flukit.appSettings.textSemibold,
            color: colorPalette.accentText,
          ),
          subtitle2: subtitleTextStyle.copyWith(
            fontSize: Flukit.appSettings.subtitleFs,
            fontWeight: Flukit.appSettings.textSemibold,
            color: colorPalette.accentText,
          ),
          bodyText1: bodyTextStyle.copyWith(
            fontSize: Flukit.appSettings.bodyFs,
            fontWeight: Flukit.appSettings.textNormal,
            color: colorPalette.text,
          ),
          bodyText2: bodyTextStyle.copyWith(
            fontSize: Flukit.appSettings.bodyFs,
            fontWeight: Flukit.appSettings.textNormal,
            color: colorPalette.text,
          ),
        ),
      );
  ThemeData get theme => _buildThemeData(_colors);
  ThemeData get darkTheme => _buildThemeData(_darkColors);

  /// TextStyle to use as default for all texts
  TextStyle get bodyTextStyle => _bodyTextStyle;

  /// TextStyle to use for subtitle texts
  TextStyle get subtitleTextStyle => _subtitleTextStyle;

  /// TextStyle to use for heading texts
  TextStyle get headingTextStyle => _headingTextStyle;

  Color get backgroundColor => colors.background;
  Color get accentBackgroundColor => colors.accentBackground;
  Color get textColor => colors.text;
  Color get accentTextColor => colors.accentText;
  Color get shadowColor => colors.shadow;
  Color get lightColor => colors.light;
  Color get darkColor => colors.dark;
  Color get dangerColor => colors.danger;
  Color get warningColor => colors.warning;
  Color get successColor => colors.success;
}

const Color _defaultPrimaryColor = Color(0xff0072ff);
const Color _defaultPrimaryTextColor = Colors.white;
const Color _defaultSecondaryColor = Color(0xFFEBF4FF);
