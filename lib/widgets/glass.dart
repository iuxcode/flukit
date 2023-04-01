import 'dart:ui';

import 'package:flutter/material.dart';

/// Create glass effect
class FluGlass extends StatelessWidget {
  const FluGlass({
    Key? key,
    this.borderRadius,
    this.margin = EdgeInsets.zero,
    required this.child,
    this.intensity = 5.0,
    this.cornerRadius = 0,
  }) : super(key: key);

  final BorderRadius? borderRadius;
  final Widget child;
  final double cornerRadius;
  final double intensity;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) => Container(
        margin: margin,
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
