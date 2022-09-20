import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'tweaks.dart';

part 'palette.dart';

enum FluThemeVariants {
  light,
  dark,
}

class FluTheme {
  late FluColorPalette _colorPalette;
  late TextStyle _bodyTextStyle;
  late TextStyle _subtitleTextStyle;
  late TextStyle _headingTextStyle;

  final FluThemeVariants variant;

  FluTheme({
    /// Theme variant
    this.variant = FluThemeVariants.light,

    /// Colors palette to use for this theme
    FluColorPalette? colors,

    /// Colors palette to use when dark theme is activated for this theme.
    /// If [variant] is set to dark, this will be used as default.
    FluColorPalette? darkColors,

    /// TextStyle to use as default for all texts
    TextStyle? bodyTextStyle,

    /// TextStyle to use for subtitle texts
    TextStyle? subtitleTextStyle,

    /// TextStyle to use for heading texts
    TextStyle? headingTextStyle,
  }) {
    _colorPalette = (isLightTheme ? colors : darkColors) ??
        (isLightTheme ? FluColorPalette.light() : FluColorPalette.dark());

    _bodyTextStyle = bodyTextStyle ?? GoogleFonts.poppins();
    _subtitleTextStyle = subtitleTextStyle ?? GoogleFonts.poppins();
    _headingTextStyle = headingTextStyle ?? GoogleFonts.poppins();
  }

  /// Get the [FluColorPalette] of this theme;
  FluColorPalette get palette => _colorPalette;

  /// Return [true] if theme [variant] is light.
  bool get isLightTheme => variant == FluThemeVariants.light;

  /// Based on the theme [variant], it'll return the corresponding [Brightness]
  Brightness get brightness => isLightTheme ? Brightness.dark : Brightness.light;

  /// Return the [SystemUiOverlayStyle] according to the theme [Brightness] and [Color palette].
  SystemUiOverlayStyle get systemStyle => SystemUiOverlayStyle(
        statusBarIconBrightness: brightness,
        systemNavigationBarIconBrightness: brightness,
        statusBarColor: palette.background,
        systemNavigationBarColor: palette.background,
      );

  /// TextStyle to use as default for all texts
  TextStyle get bodyTextStyle => _bodyTextStyle;

  /// TextStyle to use for subtitle texts
  TextStyle get subtitleTextStyle => _subtitleTextStyle;

  /// TextStyle to use for heading texts
  TextStyle get headingTextStyle => _headingTextStyle;

  /// Build and return corresponding [themeData]
  ThemeData get data => ThemeData(
        primaryColor: palette.primary,
        backgroundColor: palette.background,
        scaffoldBackgroundColor: palette.background,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: palette.secondary),
        textTheme: TextTheme(
          headlineLarge: headingTextStyle.copyWith(
            fontWeight: FluConsts.textBold,
            fontSize: FluConsts.headlineFs,
            color: palette.accentText,
          ),
          headline1: headingTextStyle.copyWith(
            fontSize: FluConsts.titleFs,
            fontWeight: FluConsts.textBold,
            color: palette.accentText,
          ),
          headline2: headingTextStyle.copyWith(
            fontSize: FluConsts.titleFs,
            fontWeight: FluConsts.textSemibold,
            color: palette.accentText,
          ),
          subtitle1: subtitleTextStyle.copyWith(
            fontSize: FluConsts.subtitleFs,
            fontWeight: FluConsts.textSemibold,
            color: palette.accentText,
          ),
          subtitle2: subtitleTextStyle.copyWith(
            fontSize: FluConsts.subtitleFs,
            fontWeight: FluConsts.textSemibold,
            color: palette.accentText,
          ),
          bodyText1: bodyTextStyle.copyWith(
            fontSize: FluConsts.bodyFs,
            fontWeight: FluConsts.textNormal,
            color: palette.text,
          ),
          bodyText2: bodyTextStyle.copyWith(
            fontSize: FluConsts.bodyFs,
            fontWeight: FluConsts.textNormal,
            color: palette.text,
          ),
        ),
      );

  Color get primaryColor => palette.primary;
  Color get primaryTextColor => palette.primaryText;
  Color get secondaryColor => palette.secondary;
  Color get tertiaryColor => palette.tertiary ?? secondaryColor;
  Color get backgroundColor => palette.background;
  Color get accentBackgroundColor => palette.accentBackground;
  Color get textColor => palette.text;
  Color get accentTextColor => palette.accentText;
  Color get shadowColor => palette.shadow;
  Color get dangerColor => palette.danger;
  Color get successColor => palette.success;
  Color get warningColor => palette.warning;
  Color get darkColor => palette.dark;
  Color get lightColor => palette.light;

  TextTheme get textTheme => data.textTheme;
}
