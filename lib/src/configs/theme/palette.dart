import 'package:flutter/material.dart';

class FluColorPalette {
  final Color background;
  final Color accentBackground;

  final Color text;
  final Color accentText;
  final Color shadow;

  final Color light;
  final Color dark;
  final Color danger;
  final Color warning;
  final Color success;

  FluColorPalette({
    required this.background,
    required this.accentBackground,
    required this.text,
    required this.accentText,
    required this.shadow,
    this.light = _defaultLightColor,
    this.dark = _defaultDarkColor,
    this.danger = _defaultDangerColor,
    this.warning = _defaultWarningColor,
    this.success = _defaultSuccessColor,
  });

  factory FluColorPalette.light({
    Color? light,
    Color? dark,
    Color? danger,
    Color? warning,
    Color? success,
    Color? background,
    Color? accentBackground,
    Color? text,
    Color? accentText,
    Color? shadow,
    Color? tertiary,
  }) =>
      FluColorPalette(
        background: background ?? const Color(0xffffffff),
        accentBackground: accentBackground ?? const Color(0xFFF8F8F8),
        text: text ?? const Color(0xFF6980A3),
        accentText: accentText ?? const Color(0xff20334f),
        shadow: shadow ?? const Color(0xff222222),
        light: light ?? _defaultLightColor,
        dark: dark ?? _defaultDarkColor,
        danger: danger ?? _defaultDangerColor,
        warning: warning ?? _defaultWarningColor,
        success: success ?? _defaultSuccessColor,
      );

  factory FluColorPalette.dark({
    Color? light,
    Color? dark,
    Color? danger,
    Color? warning,
    Color? success,
    Color? background,
    Color? accentBackground,
    Color? text,
    Color? accentText,
    Color? shadow,
    Color? tertiary,
  }) =>
      FluColorPalette(
        background: background ?? const Color(0xff000000),
        accentBackground: accentBackground ?? const Color(0xff000000),
        text: text ?? const Color(0xffeeeeee),
        accentText: accentText ?? const Color(0xffffffff),
        shadow: shadow ?? const Color(0xff000000),
        light: light ?? _defaultLightColor,
        dark: dark ?? _defaultDarkColor,
        danger: danger ?? _defaultDangerColor,
        warning: warning ?? _defaultWarningColor,
        success: success ?? _defaultSuccessColor,
      );

  FluColorPalette copyWith({
    Color? background,
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
    Color? success,
  }) =>
      FluColorPalette(
        background: background ?? this.background,
        accentBackground: accentBackground ?? this.accentBackground,
        text: text ?? this.text,
        accentText: accentText ?? this.accentText,
        shadow: shadow ?? this.shadow,
        light: light ?? this.light,
        dark: dark ?? this.dark,
        danger: danger ?? this.danger,
        warning: warning ?? this.warning,
        success: success ?? this.success,
      );
}

const Color _defaultLightColor = Color(0xffffffff);
const Color _defaultDarkColor = Color(0xff000000);
const Color _defaultDangerColor = Color(0xffFF3D71);
const Color _defaultWarningColor = Color(0xFFFFBB00);
const Color _defaultSuccessColor = Color(0xff00E096);
