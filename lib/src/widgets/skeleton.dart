import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FluSkeleton extends StatelessWidget {
  final double? height;
  final double? width;
  final double radius;
  final BorderRadius? borderRadius;
  final Color? color;
  final LinearGradient? gradient;

  const FluSkeleton({
    Key? key,
    this.height,
    this.width,
    this.borderRadius,
    this.color,
    this.gradient,
    this.radius = 10
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer(
    gradient: gradient ?? const LinearGradient(
      colors: [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
      stops: [0.1, 0.3, 0.4],
      begin: Alignment(-1.0, -0.3),
      end: Alignment(1.0, 0.3),
      tileMode: TileMode.clamp,
    ),
    child: Container(
      height: height, width: width,
      decoration: BoxDecoration(
        color: color ?? const Color(0xFFEBEBF4),
        borderRadius: borderRadius ?? BorderRadius.circular(radius)
      )
    ),
  );
}