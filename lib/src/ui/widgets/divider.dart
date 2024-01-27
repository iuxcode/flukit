import 'package:flukit/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Todo add dashes and dots
class FluLine extends StatelessWidget {
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

  final Curve animationCurve;
  final Duration animationDuration;
  final BoxShadow? boxShadow;
  final Color? color;
  final EdgeInsets? margin;
  final double height, width, radius;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Curve>('animationCurve', animationCurve))
      ..add(
        DiagnosticsProperty<Duration>('animationDuration', animationDuration),
      )
      ..add(DiagnosticsProperty<BoxShadow?>('boxShadow', boxShadow))
      ..add(ColorProperty('color', color))
      ..add(DiagnosticsProperty<EdgeInsets?>('margin', margin))
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('width', width))
      ..add(DoubleProperty('radius', radius))
      ..add(
        DiagnosticsProperty<Duration>('animationDuration', animationDuration),
      )
      ..add(DiagnosticsProperty<BoxShadow?>('boxShadow', boxShadow))
      ..add(ColorProperty('color', color))
      ..add(DiagnosticsProperty<EdgeInsets?>('margin', margin))
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('width', width))
      ..add(DoubleProperty('radius', radius))
      ..add(
        DiagnosticsProperty<Duration>('animationDuration', animationDuration),
      )
      ..add(DiagnosticsProperty<BoxShadow?>('boxShadow', boxShadow))
      ..add(ColorProperty('color', color))
      ..add(DiagnosticsProperty<EdgeInsets?>('margin', margin))
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('width', width))
      ..add(DoubleProperty('radius', radius))
      ..add(
        DiagnosticsProperty<Duration>('animationDuration', animationDuration),
      )
      ..add(DiagnosticsProperty<BoxShadow?>('boxShadow', boxShadow))
      ..add(ColorProperty('color', color))
      ..add(DiagnosticsProperty<EdgeInsets?>('margin', margin))
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('width', width))
      ..add(DoubleProperty('radius', radius));
  }

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        height: height,
        width: width,
        margin: margin,
        duration: animationDuration,
        curve: animationCurve,
        decoration: BoxDecoration(
          color: color ?? context.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [if (boxShadow != null) boxShadow!],
        ),
      );
}

/* class _DashedLineVerticalPainter extends CustomPainter {
  _DashedLineVerticalPainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.dashHeight = 5,
    this.dashSpace = 3,
    this.rounded = false,
  });

  final Color color;
  final double strokeWidth, dashHeight, dashSpace;
  final bool rounded;

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
 */
