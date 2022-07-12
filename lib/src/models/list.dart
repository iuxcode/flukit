import 'package:flukit/src/widgets/image.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/widgets.dart';

class FluOption {
  final String title;
  final String? description, image;
  final FluImageSource? imageType;
  final FluIconModel? icon;
  final Widget? suffixWidget;
  final void Function()? onPressed;
  final Color? color, backgroundColor, iconBackgroundColor, outlineColor;
  final bool hasSuffix;
  final String? label;

  FluOption(
      {required this.title,
      this.description,
      this.icon,
      this.image,
      this.imageType = FluImageSource.asset,
      this.suffixWidget,
      this.hasSuffix = true,
      this.onPressed,
      this.color,
      this.backgroundColor,
      this.iconBackgroundColor,
      this.outlineColor,
      this.label});
}
