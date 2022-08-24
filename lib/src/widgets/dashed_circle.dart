import 'dart:math';
import 'package:flutter/widgets.dart';

const int _defaultDashes = 20;
const Color _defaultColor = Color(0xff000000);
const double _defaultGapSize = 3.0;
const double _defaultStrokeWidth = 1.5;

class FluDashedCircle extends StatelessWidget {
  final int dashes;
  final Color color;
  final double gapSize;
  final double strokewidth;
  final Widget? child;

  const FluDashedCircle(
      {Key? key,
      this.child,
      this.dashes = _defaultDashes,
      this.color = _defaultColor,
      this.gapSize = _defaultGapSize,
      this.strokewidth = _defaultStrokeWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: FluDashedCirclePainter(
          dashes: dashes, color: color, gapSize: gapSize, strokewidth: strokewidth),
      child: child,
    );
  }
}

class FluDashedCirclePainter extends CustomPainter {
  final int dashes;
  final Color color;
  final double gapSize;
  final double strokewidth;

  FluDashedCirclePainter(
      {this.dashes = _defaultDashes,
      this.color = _defaultColor,
      this.gapSize = _defaultGapSize,
      this.strokewidth = _defaultStrokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final double gap = pi / 180 * gapSize;
    final double singleAngle = (pi * 2) / dashes;

    for (int i = 0; i < dashes; i++) {
      final Paint paint = Paint()
        ..color = color
        ..strokeWidth = _defaultStrokeWidth
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
