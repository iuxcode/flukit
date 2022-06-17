import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'tweaks.dart';

part 'palette.dart';

enum FluThemeVariants { light, dark }

class FluTheme {
  final FluThemeVariants variant;
  final FluColorPalette? colors;
  final TextStyle? bodyTextStyle;
  final TextStyle? headlineTextStyle;

  FluTheme({
    this.colors,
    this.variant = FluThemeVariants.light,
    this.bodyTextStyle,
    this.headlineTextStyle
  });

  bool get isLightTheme => variant == FluThemeVariants.light;
  Brightness get brightness => isLightTheme ? Brightness.dark : Brightness.light;

  SystemUiOverlayStyle get systemStyle => SystemUiOverlayStyle(
    statusBarIconBrightness: brightness,
    systemNavigationBarIconBrightness: brightness,
    statusBarColor: palette.background,
    systemNavigationBarColor: palette.background
  );

  FluColorPalette get palette => colors ?? FluLightColors(
    primary: const Color(0xff0072ff),
    primaryText: Colors.white,
    secondary: const Color(0xFFEBF4FF),
  );
  ThemeData get data => ThemeData(
    primaryColor: palette.primary,
    backgroundColor: palette.background,
    scaffoldBackgroundColor: palette.background,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: palette.secondary
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.poppins(
        fontWeight: Flukit.appConsts.textBold,
        fontSize: Flukit.appConsts.headlineFs,
        color: palette.accentText
      ),
      headline1:  GoogleFonts.poppins(
        fontSize: Flukit.appConsts.titleFs,
        fontWeight: Flukit.appConsts.textBold,
        color: palette.accentText
      ),
      headline2: GoogleFonts.poppins(
        fontSize: Flukit.appConsts.titleFs,
        fontWeight: Flukit.appConsts.textSemibold,
        color: palette.accentText
      ),
      subtitle1: GoogleFonts.poppins(
        fontSize: Flukit.appConsts.subtitleFs,
        fontWeight: Flukit.appConsts.textSemibold,
        color: palette.accentText
      ),
      subtitle2: GoogleFonts.poppins(
        fontSize: Flukit.appConsts.subtitleFs,
        fontWeight: Flukit.appConsts.textSemibold,
        color: palette.accentText
      ),
      bodyText1: GoogleFonts.poppins(
        fontSize: Flukit.appConsts.bodyFs,
        fontWeight: Flukit.appConsts.textNormal,
        color: palette.text
      ),
      bodyText2: GoogleFonts.poppins(
        fontSize: Flukit.appConsts.bodyFs,
        fontWeight: Flukit.appConsts.textNormal,
        color: palette.text
      ),
    )
  );

  Color get primaryColor => palette.primary;
  Color get primaryTextColor => palette.primaryText;
  Color get secondaryColor => palette.secondary;
  Color get backgroundColor => palette.background;
  Color get accentBackgroundColor => palette.accentBackground;
  Color get textColor => palette.text;
  Color get accentTextColor => palette.accentText;
  Color get shadowColor => palette.shadow;
}