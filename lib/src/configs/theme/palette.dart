import 'package:flutter/material.dart';

class FluColorPalette {
  final Color background;
  final Color surfaceBackground;

  final Color text;
  final Color accentText;
  final Color shadow;
  final Color divider;

  final Color light;
  final Color dark;
  final Color danger;
  final Color onDanger;
  final Color warning;
  final Color success;

  FluColorPalette({
    required this.background,
    required this.surfaceBackground,
    required this.text,
    required this.accentText,
    required this.shadow,
    required this.divider,
    this.light = _defaultLightColor,
    this.dark = _defaultDarkColor,
    this.danger = _defaultDangerColor,
    this.onDanger = _defaultOnDangerColor,
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
    Color? surfaceBackground,
    Color? text,
    Color? accentText,
    Color? shadow,
    Color? divider,
  }) =>
      FluColorPalette(
        background: background ?? const Color(0xffffffff),
        surfaceBackground: surfaceBackground ?? const Color(0xFFF8F8F8),
        text: text ?? const Color(0xFF627694),
        accentText: accentText ?? const Color(0xff20334f),
        shadow: shadow ?? const Color(0xff222222),
        divider: divider ?? const Color(0xFF627694).withOpacity(.15),
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
    Color? surfaceBackground,
    Color? text,
    Color? accentText,
    Color? shadow,
    Color? divider,
  }) =>
      FluColorPalette(
        background: background ?? const Color(0xff000000),
        surfaceBackground: surfaceBackground ?? const Color(0xff000000),
        text: text ?? const Color(0xffeeeeee),
        accentText: accentText ?? const Color(0xffffffff),
        divider: divider ?? const Color(0xffeeeeee).withOpacity(.15),
        shadow: shadow ?? const Color(0xff000000),
        light: light ?? _defaultLightColor,
        dark: dark ?? _defaultDarkColor,
        danger: danger ?? _defaultDangerColor,
        warning: warning ?? _defaultWarningColor,
        success: success ?? _defaultSuccessColor,
      );

  FluColorPalette copyWith({
    Color? background,
    Color? surfaceBackground,
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
    Color? divider,
  }) =>
      FluColorPalette(
        background: background ?? this.background,
        surfaceBackground: surfaceBackground ?? this.surfaceBackground,
        text: text ?? this.text,
        accentText: accentText ?? this.accentText,
        shadow: shadow ?? this.shadow,
        light: light ?? this.light,
        dark: dark ?? this.dark,
        danger: danger ?? this.danger,
        warning: warning ?? this.warning,
        success: success ?? this.success,
        divider: divider ?? this.divider,
      );
}

const Color _defaultLightColor = Color(0xffffffff);
const Color _defaultDarkColor = Color(0xff000000);
const Color _defaultDangerColor = Color(0xffFF3D71);
const Color _defaultOnDangerColor = Colors.white;
const Color _defaultWarningColor = Color(0xFFFFBB00);
const Color _defaultSuccessColor = Color(0xff00E096);
