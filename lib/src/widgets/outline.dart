import 'package:flutter/material.dart';

import '../utils/flu_utils.dart';

class FluOutline extends StatelessWidget {
  final double? thickness, radius, spacing;
  final BorderRadius? borderRadius;
  final Color? color;
  final BoxShadow? boxShadow;
  final EdgeInsets? margin;
  final Widget child;

  const FluOutline({
    Key? key,
    this.thickness,
    this.radius,
    this.spacing,
    this.color,
    this.borderRadius,
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
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 18),
        border: Border.all(
          color: color ?? Flukit.theme.data.backgroundColor,
          width: thickness ?? 1.5
        ),
        boxShadow: [boxShadow ?? Flukit.boxShadow()]
      ),
      child: child
    );
  }
}