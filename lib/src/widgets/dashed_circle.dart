import 'dart:math';
import 'package:flukit/src/utils/flu_utils.dart';
import 'package:flutter/widgets.dart';

const int _defaultDashes = 20;
const double _defaultGapSize = 3.0;
const double _defaultStrokeWidth = 1.5;

class FluDashedCircle extends StatelessWidget {
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

  final Widget? child;
  final Color? color;
  final int dashes;
  final double gapSize;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double strokewidth;

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
  FluDashedCirclePainter({
    this.dashes = _defaultDashes,
    this.color,
    this.gapSize = _defaultGapSize,
    this.strokewidth = _defaultStrokeWidth,
  });

  final Color? color;
  final int dashes;
  final double gapSize;
  final double strokewidth;

  @override
  void paint(Canvas canvas, Size size) {
    final double gap = pi / 180 * gapSize;
    final double singleAngle = (pi * 2) / dashes;

    for (int i = 0; i < dashes; i++) {
      final Paint paint = Paint()
        ..color = color ?? Flu.theme().primary
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
