import 'package:flutter/material.dart';
import 'indicators.dart';

class FluRectangularIndicatorPainter extends BoxPainter {
  FluRectangularIndicatorPainter(
    this.decoration,
    VoidCallback? onChanged, {
    required this.topRightRadius,
    required this.topLeftRadius,
    required this.bottomRightRadius,
    required this.bottomLeftRadius,
    required this.color,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.paintingStyle,
    required this.strokeWidth,
  }) : super(onChanged);

  final double bottomLeftRadius;
  final double bottomRightRadius;
  final Color color;
  final FluRectangularIndicator decoration;
  final double horizontalPadding;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final double topLeftRadius;
  final double topRightRadius;
  final double verticalPadding;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(horizontalPadding >= 0);
    assert(horizontalPadding < configuration.size!.width / 2,
        "Padding must be less than half of the size of the tab");
    assert(verticalPadding < configuration.size!.height / 2 &&
        verticalPadding >= 0);
    assert(strokeWidth >= 0 &&
        strokeWidth < configuration.size!.width / 2 &&
        strokeWidth < configuration.size!.height / 2);

    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.
    Size mysize = Size(configuration.size!.width - (horizontalPadding * 2),
        configuration.size!.height - (2 * verticalPadding));

    Offset myoffset =
        Offset(offset.dx + (horizontalPadding), offset.dy + verticalPadding);
    final Rect rect = myoffset & mysize;
    final Paint paint = Paint();
    paint.color = color;
    paint.style = paintingStyle;
    paint.strokeWidth = 3;
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          rect,
          bottomRight: Radius.circular(bottomRightRadius),
          bottomLeft: Radius.circular(bottomLeftRadius),
          topLeft: Radius.circular(topLeftRadius),
          topRight: Radius.circular(topRightRadius),
        ),
        paint);
  }
}

class FluCirclePainter extends BoxPainter {
  FluCirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  final double radius;

  final Paint _paint;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Offset circleOffset = offset +
        Offset(
            configuration.size!.width / 2, configuration.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

class FluMaterialIndicatorPainter extends BoxPainter {
  FluMaterialIndicatorPainter(
    this.decoration,
    VoidCallback? onChanged, {
    required this.height,
    required this.tabPosition,
    required this.topRightRadius,
    required this.topLeftRadius,
    required this.bottomRightRadius,
    required this.bottomLeftRadius,
    required this.color,
    required this.horizontalPadding,
    required this.paintingStyle,
    required this.strokeWidth,
  }) : super(onChanged);

  final double bottomLeftRadius;
  final double bottomRightRadius;
  final Color color;
  final FluMaterialIndicator decoration;
  final double height;
  final double horizontalPadding;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final TabPosition tabPosition;
  final double topLeftRadius;
  final double topRightRadius;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(horizontalPadding >= 0);
    assert(horizontalPadding < configuration.size!.width / 2,
        "Padding must be less than half of the size of the tab");
    assert(height > 0);
    assert(strokeWidth >= 0 &&
        strokeWidth < configuration.size!.width / 2 &&
        strokeWidth < configuration.size!.height / 2);

    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.
    Size mysize =
        Size(configuration.size!.width - (horizontalPadding * 2), height);

    Offset myoffset = Offset(
      offset.dx + (horizontalPadding),
      offset.dy +
          (tabPosition == TabPosition.bottom
              ? configuration.size!.height - height
              : 0),
    );

    final Rect rect = myoffset & mysize;
    final Paint paint = Paint();
    paint.color = color;
    paint.style = paintingStyle;
    paint.strokeWidth = strokeWidth;
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          rect,
          bottomRight: Radius.circular(bottomRightRadius),
          bottomLeft: Radius.circular(bottomLeftRadius),
          topLeft: Radius.circular(topLeftRadius),
          topRight: Radius.circular(topRightRadius),
        ),
        paint);
  }
}
