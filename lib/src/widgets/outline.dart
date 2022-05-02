import 'package:flutter/material.dart';

import '../utils/flu_utils.dart';

class FluOutline extends StatelessWidget {
  final double? strokeWidth, radius, spacing;
  final BorderRadius? strokeBorderRadius;
  final Color? strokeColor;
  final BoxShadow? boxShadow;
  final EdgeInsets? margin;
  final Widget child;

  const FluOutline({
    Key? key,
    this.strokeWidth,
    this.radius,
    this.spacing,
    this.strokeColor,
    this.strokeBorderRadius,
    this.boxShadow,
    this.margin,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(spacing ?? 2),
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: strokeBorderRadius ?? BorderRadius.circular(radius ?? 18),
        border: Border.all(
          color: strokeColor ?? Flukit.theme.data.backgroundColor,
          width: strokeWidth ?? 1.5
        ),
        boxShadow: [boxShadow ?? Flukit.boxShadow()]
      ),
      child: child
    );
  }
}