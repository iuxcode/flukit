import 'package:flutter/material.dart';

import '../utils/flu_utils.dart';

/// Todo add dashes and dots
class FluLine extends StatelessWidget {
  final double height, width, radius;
  final Color? color;
  final EdgeInsets? margin;
  final Duration animationDuration;
  final Curve animationCurve;
  final BoxShadow? boxShadow;

  const FluLine({
    super.key,
    this.height = 1,
    this.width = 45,
    this.radius = 0,
    this.margin = EdgeInsets.zero,
    this.color,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.linear,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        height: height,
        width: width,
        margin: margin,
        duration: animationDuration,
        curve: animationCurve,
        decoration: BoxDecoration(
          color: color ?? Flu.getColorSchemeOf(context).surfaceVariant,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [if (boxShadow != null) boxShadow!],
        ),
      );
}

class _DashedLineVerticalPainter extends CustomPainter {
  final Color color;
  final double strokeWidth, dashHeight, dashSpace;
  final bool rounded;

  _DashedLineVerticalPainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.dashHeight = 5,
    this.dashSpace = 3,
    this.rounded = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double startY = 0, startX = size.width / 2;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = rounded ? StrokeCap.round : StrokeCap.square;

    while (startY < size.height) {
      canvas.drawLine(
          Offset(startX, startY), Offset(startX, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
