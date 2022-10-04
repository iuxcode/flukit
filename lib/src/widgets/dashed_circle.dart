import 'dart:math';
import 'package:flutter/widgets.dart';

import '../../flukit.dart';

const int _defaultDashes = 20;
const double _defaultGapSize = 3.0;
const double _defaultStrokeWidth = 1.5;

class FluDashedCircle extends StatelessWidget {
  final int dashes;
  final Color? color;
  final double gapSize;
  final double strokewidth;
  final Widget? child;
  final EdgeInsets margin;
  final EdgeInsets padding;

  const FluDashedCircle({
    Key? key,
    this.child,
    this.dashes = _defaultDashes,
    this.color,
    this.gapSize = _defaultGapSize,
    this.strokewidth = _defaultStrokeWidth,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(3),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: margin,
      child: CustomPaint(
        painter: FluDashedCirclePainter(
          dashes: dashes,
          color: color,
          gapSize: gapSize,
          strokewidth: strokewidth,
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

class FluDashedCirclePainter extends CustomPainter {
  final int dashes;
  final Color? color;
  final double gapSize;
  final double strokewidth;

  FluDashedCirclePainter({
    this.dashes = _defaultDashes,
    this.color,
    this.gapSize = _defaultGapSize,
    this.strokewidth = _defaultStrokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double gap = pi / 180 * gapSize;
    final double singleAngle = (pi * 2) / dashes;

    for (int i = 0; i < dashes; i++) {
      final Paint paint = Paint()
        ..color = color ?? Flukit.theme.primary
        ..strokeWidth = strokewidth
        ..style = PaintingStyle.stroke;

      canvas.drawArc(Offset.zero & size, gap + singleAngle * i,
          singleAngle - gap * 2, false, paint);
    }
  }

  @override
  bool shouldRepaint(FluDashedCirclePainter oldDelegate) {
    return dashes != oldDelegate.dashes || color != oldDelegate.color;
  }
}
