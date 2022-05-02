import 'dart:ui';

import 'package:flukit_icons/flukit_icons.dart';

class FluScreenOptionModel {
  final String title;
  final String? description;
  final FluIconModel? icon, suffixIcon;
  final void Function()? onPressed;
  final Color? color, backgroundColor, iconBackgroundColor, outlineColor;

  FluScreenOptionModel({
    required this.title,
    this.description,
    this.icon,
    this.suffixIcon,
    this.onPressed,
    this.color,
    this.backgroundColor,
    this.iconBackgroundColor,
    this.outlineColor,
  });
}