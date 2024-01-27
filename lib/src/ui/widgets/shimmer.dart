import 'package:flukit/flukit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    required this.height,
    required this.width,
    super.key,
    this.cornerRadius = 0,
    this.shimmer = false,
    this.rounded = false,
    this.color,
    this.gradient = _kDefaultShimmerGradient,
    this.shimmerDirection = ShimmerDirection.ltr,
    this.margin = EdgeInsets.zero,
  });

  factory Skeleton.square({
    required double size,
    double cornerRadius = 0,
    Color? color,
    LinearGradient gradient = _kDefaultShimmerGradient,
    bool shimmer = false,
    bool rounded = false,
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

  final Color? color;
  final double height, width, cornerRadius;
  final LinearGradient gradient;
  final EdgeInsets margin;
  final bool rounded, shimmer;
  final ShimmerDirection shimmerDirection;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('width', width))
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DiagnosticsProperty<LinearGradient>('gradient', gradient))
      ..add(DiagnosticsProperty<EdgeInsets>('margin', margin))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('shimmer', shimmer))
      ..add(
        EnumProperty<ShimmerDirection>('shimmerDirection', shimmerDirection),
      )
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('width', width))
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DiagnosticsProperty<LinearGradient>('gradient', gradient))
      ..add(DiagnosticsProperty<EdgeInsets>('margin', margin))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('shimmer', shimmer))
      ..add(
        EnumProperty<ShimmerDirection>('shimmerDirection', shimmerDirection),
      )
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('width', width))
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DiagnosticsProperty<LinearGradient>('gradient', gradient))
      ..add(DiagnosticsProperty<EdgeInsets>('margin', margin))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('shimmer', shimmer))
      ..add(
        EnumProperty<ShimmerDirection>('shimmerDirection', shimmerDirection),
      )
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('width', width))
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DiagnosticsProperty<LinearGradient>('gradient', gradient))
      ..add(DiagnosticsProperty<EdgeInsets>('margin', margin))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('shimmer', shimmer))
      ..add(
        EnumProperty<ShimmerDirection>('shimmerDirection', shimmerDirection),
      );
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(rounded ? 50 : cornerRadius);

    final child = shimmer
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
  begin: Alignment(-1, -0.3),
  end: Alignment(1, 0.3),
);
