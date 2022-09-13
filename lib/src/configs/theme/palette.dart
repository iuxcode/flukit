part of './index.dart';

class FluColorPalette {
  final Color background,
      accentBackground,
      primary,
      primaryText,
      secondary,
      text,
      accentText,
      shadow;
  final Color? tertiary;
  Color light, dark, danger, warning, success;

  FluColorPalette(
      {required this.background,
      required this.accentBackground,
      required this.primary,
      required this.primaryText,
      required this.secondary,
      required this.text,
      required this.accentText,
      required this.shadow,
      this.tertiary,
      this.light = const Color(0xffffffff),
      this.dark = const Color(0xff000000),
      this.danger = const Color(0xffff4757),
      this.warning = const Color(0xFFFFBB00),
      this.success = const Color(0xff46c93a)});

  FluColorPalette copyWith(
          {Color? background,
          Color? accentBackground,
          Color? primary,
          Color? primaryText,
          Color? secondary,
          Color? secondaryText,
          Color? text,
          Color? accentText,
          Color? shadow,
          Color? tertiary,
          Color? light,
          Color? dark,
          Color? danger,
          Color? warning,
          Color? success}) =>
      FluColorPalette(
        background: background ?? this.background,
        accentBackground: accentBackground ?? this.accentBackground,
        primary: primary ?? this.primary,
        primaryText: primaryText ?? this.primaryText,
        secondary: secondary ?? this.secondary,
        text: text ?? this.text,
        accentText: accentText ?? this.accentText,
        shadow: shadow ?? this.shadow,
        tertiary: tertiary ?? this.tertiary,
        light: light ?? this.light,
        dark: dark ?? this.dark,
        danger: danger ?? this.danger,
        warning: warning ?? this.warning,
        success: success ?? this.success,
      );
}

class FluLightColors extends FluColorPalette {
  FluLightColors({
    required Color primary,
    required Color primaryText,
    required Color secondary,
    Color? background,
    Color? accentBackground,
    Color? text,
    Color? accentText,
    Color? shadow,
    Color? tertiary,
    super.light,
    super.dark,
    super.danger,
    super.warning,
    super.success,
  }) : super(
            primary: primary,
            primaryText: primaryText,
            secondary: secondary,
            tertiary: tertiary ?? secondary,
            background: background ?? const Color(0xffffffff),
            accentBackground: accentBackground ?? const Color(0xFFF8F8F8),
            text: text ?? const Color(0xFF6980A3),
            accentText: accentText ?? const Color(0xff20334f),
            shadow: shadow ?? const Color(0xff222222));
}

class FluDarkColors extends FluColorPalette {
  FluDarkColors({
    required Color? primary,
    required Color? primaryText,
    required Color? secondary,
    Color? background,
    Color? accentBackground,
    Color? text,
    Color? accentText,
    Color? shadow,
    Color? tertiary,
    super.light,
    super.dark,
    super.danger,
    super.warning,
    super.success,
  }) : super(
            primary: primary ?? Colors.blue,
            primaryText: primaryText ?? Colors.white,
            secondary: secondary ?? Colors.blueAccent,
            tertiary: tertiary ?? secondary,
            background: background ?? const Color(0xff000000),
            accentBackground: accentBackground ?? const Color(0xff000000),
            text: text ?? const Color(0xffeeeeee),
            accentText: accentText ?? const Color(0xffffffff),
            shadow: shadow ?? const Color(0xff000000));
}
