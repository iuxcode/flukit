// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flukit_icons/flukit_icons.dart';

import '../utils/flu_utils.dart';

/// Create a button
class FluButton extends StatelessWidget {
  const FluButton({
    required this.child,
    required this.onPressed,
    this.style,
    super.key,
  });

  /// Create a button with icon content
  factory FluButton.icon(FluIcons icon,
      {VoidCallback? onPressed, double iconSize = 20, FluButtonStyle? style}) {
    final iconButtonStyle = style ?? FluButtonStyle.tonal;

    return FluButton(
        onPressed: onPressed, style: iconButtonStyle, child: FluIcon(icon));
  }

  /// Create a button with text content
  /// You can also add an icon before or after the text using [prefixIcon] and [suffixIcon].
  /// Control icons sizes with [iconSize], [prefixIconSize] and [suffixIconSize].
  /// use [iconStyle] to choose your icon style. refer to [https://github.com/charles9904/flukit_icons] to learn more.
  /// [spacing] determine the space available between text and icon.
  factory FluButton.text(String text,
      {FluIcons? prefixIcon,
      FluIcons? suffixIcon,
      double iconSize = 20,
      double? prefixIconSize,
      double? suffixIconSize,
      double spacing = 6.0,
      VoidCallback? onPressed,
      FluIconStyles iconStyle = FluIconStyles.twotone,
      FluButtonStyle? style}) {
    final textButtonStyle = style ?? FluButtonStyle.tonal;

    Widget textWidget =
        Text(text, style: TextStyle(color: textButtonStyle.foregroundColor));
    Widget buildIcon(FluIcons icon, [double? size]) {
      return FluIcon(
        icon,
        style: iconStyle,
        size: size ?? iconSize,
        color: textButtonStyle.foregroundColor,
        margin: EdgeInsets.only(
            right: prefixIcon != null ? spacing : 0,
            left: suffixIcon != null ? spacing : 0),
      );
    }

    return FluButton(
        onPressed: onPressed,
        child: (prefixIcon != null || suffixIcon != null)
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefixIcon != null) buildIcon(prefixIcon, prefixIconSize),
                  textWidget,
                  if (suffixIcon != null) buildIcon(suffixIcon, suffixIconSize),
                ],
              )
            : textWidget);
  }

  final Widget child;
  final VoidCallback? onPressed;

  /// Button style
  /// Default value is [FluButtonStyle.tonal]
  final FluButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = style ?? FluButtonStyle.tonal;

    final Widget button = ButtonTheme.fromButtonThemeData(
      data: Theme.of(context).buttonTheme,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(buttonStyle.backgroundColor),
            foregroundColor:
                MaterialStatePropertyAll(buttonStyle.foregroundColor),
            padding: MaterialStatePropertyAll(buttonStyle.padding)),
        child: child,
      ),
    );

    if (buttonStyle.margin != EdgeInsets.zero) {
      return Container(
        margin: buttonStyle.margin,
        child: button,
      );
    }

    return button;
  }
}

/// Create a [FluButton] style in order to customize it easily.
@immutable
class FluButtonStyle {
  const FluButtonStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.square = false,
    this.height,
    this.width,
    this.minWidth,
  });

  static FluButtonStyle tonal = FluButtonStyle(
      backgroundColor: _colorScheme.primaryContainer,
      foregroundColor: _colorScheme.secondaryContainer);

  /// Button Height
  final double? height;

  /// Button width
  final double? width;

  /// Button minimum width
  final double? minWidth;

  /// The padding between the button's boundary and its child
  final EdgeInsets margin;

  /// Empty space to surround the button
  final EdgeInsets padding;

  /// Button background color
  final Color? backgroundColor;

  /// Button foreground color
  final Color? foregroundColor;

  /// if it's set to true, the button'll be a square.
  /// so the button height will be equal to the width.
  final bool square;

  static final ColorScheme _colorScheme = _theme.colorScheme;
  static final ThemeData _theme = Flu.theme;

  FluButtonStyle copyWith({
    EdgeInsets? margin,
    EdgeInsets? padding,
    Color? backgroundColor,
    Color? foregroundColor,
    bool? square,
  }) {
    return FluButtonStyle(
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      square: square ?? this.square,
    );
  }
}

enum FluButtonType { elevated, filled, tonal, outlined, text }
