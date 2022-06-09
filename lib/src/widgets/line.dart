import 'package:flutter/material.dart';
import '../utils/flu_utils.dart';

class FluLine extends StatelessWidget {
  final double height, width, radius;
  final Color? color;
  final EdgeInsets? margin;
  final Duration animationDuration;
  final Curve animationCurve;
  final BoxShadow? boxShadow;

  const FluLine({
    Key? key,
    this.height = 1,
    this.width = 45,
    this.radius = 0,
    this.margin = EdgeInsets.zero,
    this.color,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.linear,
    this.boxShadow
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    height: height,
    width: width,
    margin: margin,
    duration: animationDuration,
    curve: animationCurve,
    decoration: BoxDecoration(
      color: color ?? Flukit.theme.primaryColor,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [if(boxShadow != null) boxShadow!]
    )
  );
}