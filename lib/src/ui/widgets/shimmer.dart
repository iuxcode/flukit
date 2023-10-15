import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    super.key,
    required this.height,
    required this.width,
    this.cornerRadius = 0,
    this.shimmer = false,
    this.rounded = false,
    this.color,
    this.gradient = _kDefaultShimmerGradient,
    this.shimmerDirection = ShimmerDirection.ltr,
    this.margin = EdgeInsets.zero,
  });

  final double height, width, cornerRadius;
  final Color? color;
  final LinearGradient gradient;
  final bool rounded, shimmer;
  final ShimmerDirection shimmerDirection;
  final EdgeInsets margin;

  factory Skeleton.square({
    required double size,
    double cornerRadius = 0,
    Color? color,
    LinearGradient gradient = _kDefaultShimmerGradient,
    bool shimmer = false,
    bool rounded = false,
    ShimmerDirection shimmerDirection = ShimmerDirection.ltr,
    EdgeInsets margin = EdgeInsets.zero,
  }) =>
      Skeleton(
        height: size,
        width: size,
        rounded: rounded,
        cornerRadius: cornerRadius,
        color: color,
        gradient: gradient,
        shimmer: shimmer,
        margin: margin,
      );

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius =
        BorderRadius.circular(rounded ? 50 : cornerRadius);

    final Widget child = shimmer
        ? Shimmer(
            gradient: gradient,
            direction: shimmerDirection,
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: color ?? context.colorScheme.surface,
                borderRadius: borderRadius,
              ),
            ),
          )
        : Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: color,
              gradient: gradient,
              borderRadius: borderRadius,
            ),
          );

    return (margin != EdgeInsets.zero)
        ? Padding(
            padding: margin,
            child: child,
          )
        : child;
  }
}

const _kDefaultShimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);
