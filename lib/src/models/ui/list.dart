import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/widgets.dart';

class FluScreenOptionModel {
  final String title;
  final String? description;
  final FluIconModel? icon;
  final Widget? suffixWidget;
  final void Function()? onPressed;
  final Color? color, backgroundColor, iconBackgroundColor, outlineColor;
  final bool hasSuffix;

  FluScreenOptionModel({
    required this.title,
    this.description,
    this.icon,
    this.suffixWidget,
    this.hasSuffix = true,
    this.onPressed,
    this.color,
    this.backgroundColor,
    this.iconBackgroundColor,
    this.outlineColor,
  });
}