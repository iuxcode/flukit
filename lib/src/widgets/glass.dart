import 'dart:ui';

import 'package:flutter/material.dart';

/// Create a blured background.
class FluGlass extends StatelessWidget {
  const FluGlass({
    Key? key,
    this.borderRadius,
    this.shadow,
    this.margin,
    required this.child,
    this.intensity = 7.0,
    this.cornerRadius = 0,
  }) : super(key: key);

  final BorderRadius? borderRadius;
  final Widget child;
  final double cornerRadius;
  final double intensity;
  final EdgeInsets? margin;
  final BoxShadow? shadow;

  @override
  Widget build(BuildContext context) => Container(
        margin: margin,
        decoration: BoxDecoration(boxShadow: [
          if (shadow != null) shadow!,
        ]),
        child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: borderRadius ?? BorderRadius.circular(cornerRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: intensity,
              sigmaY: intensity,
            ),
            child: child,
          ),
        ),
      );
}
