import 'package:flutter/material.dart';
import '../utils/flu_utils.dart';

class FluLine extends StatelessWidget {
  final double height, width, radius;
  final Color? color;
  final EdgeInsets? margin;

  const FluLine({
    Key? key,
    this.height = 1,
    this.width = 45,
    this.radius = 0,
    this.margin = EdgeInsets.zero,
    this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    height: height,
    width: width,
    margin: margin,
    decoration: BoxDecoration(
      color: color ?? Flukit.theme.primaryColor,
      borderRadius: BorderRadius.circular(radius)
    )
  );
}