import 'dart:math' show max, sqrt;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// providing circular reveal clip for route transition.
class CircularRevealClipper extends CustomClipper<Path> {
  // ignore: public_member_api_docs
  CircularRevealClipper({
    required this.fraction,
    this.centerAlignment,
    this.centerOffset,
    this.minRadius,
    this.maxRadius,
  });

  final Alignment? centerAlignment;
  final Offset? centerOffset;
  final double fraction;
  final double? maxRadius;
  final double? minRadius;

  @override
  Path getClip(Size size) {
    final center = centerAlignment?.alongSize(size) ??
        centerOffset ??
        Offset(size.width / 2, size.height / 2);
    final minRadius = this.minRadius ?? 0;
    final maxRadius = this.maxRadius ?? calcMaxRadius(size, center);

    return Path()
      ..addOval(
        Rect.fromCircle(
          center: center,
          radius: lerpDouble(minRadius, maxRadius, fraction)!,
        ),
      );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

  static double calcMaxRadius(Size size, Offset center) {
    final w = max(center.dx, size.width - center.dx);
    final h = max(center.dy, size.height - center.dy);
    return sqrt(w * w + h * h);
  }
}
