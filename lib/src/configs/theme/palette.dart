part of './index.dart';

class FluColorPalette {
  final Color background, accentBackground, primary, primaryText, secondary, text, accentText, shadow;

  FluColorPalette({
    required this.background,
    required this.accentBackground,
    required this.primary,
    required this.primaryText,
    required this.secondary,
    required this.text,
    required this.accentText,
    required this.shadow
  });

  
  Color get light => const Color(0xffffffff);
  Color get dark => const Color(0xff000000);
  Color get danger => const Color(0xffff4757);
  Color get warning => const Color(0xFFFFBB00);
  Color get success => const Color(0xff46c93a);

  FluColorPalette copyWith({
    Color? background,
    Color? accentBackground,
    Color? primary,
    Color? primaryText,
    Color? secondary,
    Color? secondaryText,
    Color? text,
    Color? accentText,
    Color? shadow
  }) => FluColorPalette(
    background: background ?? this.background,
    accentBackground: accentBackground ?? this.accentBackground,
    primary: primary ?? this.primary,
    primaryText: primaryText ?? this.primaryText,
    secondary: secondary ?? this.secondary,
    text: text ?? this.text,
    accentText: accentText ?? this.accentText,
    shadow: shadow ?? this.shadow
  );
}

class FluLightColors extends FluColorPalette{
  FluLightColors({
    required Color primary,
    required Color primaryText,
    required Color secondary,
    Color? background,
    Color? accentBackground,
    Color? text,
    Color? accentText,
    Color? shadow,
  }): super(
    primary: primary,
    primaryText: primaryText,
    secondary: secondary,
    background: background ?? const Color(0xffffffff),
    accentBackground: accentBackground ?? const Color(0xFFF8F8F8),
    text: text ?? const Color(0xFF6980A3),
    accentText: accentText ?? const Color(0xff20334f),
    shadow:  shadow ?? const Color(0xff222222)
  );
}

class FluDarkColors extends FluColorPalette{
  FluDarkColors({
    required Color? primary,
    required Color? primaryText,
    required Color? secondary,
    Color? background,
    Color? accentBackground,
    Color? text,
    Color? accentText,
    Color? shadow,
  }): super(
    primary: primary ?? Colors.blue,
    primaryText: primaryText ?? Colors.white,
    secondary: secondary ?? Colors.blueAccent,
    background: background ?? const Color(0xff000000),
    accentBackground: accentBackground ?? const Color(0xff000000),
    text: text ?? const Color(0xffeeeeee),
    accentText: accentText ?? const Color(0xffffffff),
    shadow: shadow ?? const Color(0xff000000)
  );
}