import 'package:flutter/material.dart';
import '../utils/flu_utils.dart';

class FluRectangularIndicator extends Decoration {
  /// Corner radius, default to 25
  final double radius;

  /// topRight radius of the indicator.
  final double? topRightRadius;

  /// topLeft radius of the indicator.
  final double? topLeftRadius;

  /// bottomRight radius of the indicator.
  final double? bottomRightRadius;

  /// bottomLeft radius of the indicator
  final double? bottomLeftRadius;

  /// Color of the indicator, default set to [Colors.black]
  final Color color;

  /// Horizontal padding of the indicator, default set to 0
  final double horizontalPadding;

  /// Vertical padding of the indicator, default set to 0
  final double verticalPadding;

  /// [PagingStyle] determines if the indicator should be fill or stroke, default to fill
  final PaintingStyle paintingStyle;

  /// StrokeWidth, used for [PaintingStyle.stroke], default set to 0
  final double strokeWidth;

  FluRectangularIndicator({
    this.radius = 25,
    this.topRightRadius,
    this.topLeftRadius,
    this.bottomRightRadius,
    this.bottomLeftRadius,
    this.color = Colors.black,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
    this.paintingStyle = PaintingStyle.fill,
    this.strokeWidth = 2,
  });
  @override
  _FluRectangularIndicator createBoxPainter([VoidCallback? onChanged]) {
    return new _FluRectangularIndicator(
      this,
      onChanged,
      topLeftRadius: topLeftRadius ?? radius,
      topRightRadius: topRightRadius ?? radius,
      bottomLeftRadius: bottomLeftRadius ?? radius,
      bottomRightRadius: bottomRightRadius ?? radius,
      color: color,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      paintingStyle: paintingStyle,
      strokeWidth: strokeWidth,
    );
  }
}

class _FluRectangularIndicator extends BoxPainter {
  final FluRectangularIndicator decoration;
  final double topRightRadius;
  final double topLeftRadius;
  final double bottomRightRadius;
  final double bottomLeftRadius;
  final Color color;
  final double horizontalPadding;
  final double verticalPadding;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  _FluRectangularIndicator(
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

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(horizontalPadding >= 0);
    assert(horizontalPadding < configuration.size!.width / 2,
        "Padding must be less than half of the size of the tab");
    assert(verticalPadding < configuration.size!.height / 2 && verticalPadding >= 0);
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

class FluDotTabIndicator extends Decoration {
  final BoxPainter _painter;

  FluDotTabIndicator({
    Color? color,
    double? radius,
  }) : _painter = _FluCirclePainter(color ?? Flukit.theme.primaryColor, radius ?? 3);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _FluCirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _FluCirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

class FluMaterialIndicator extends Decoration {
  /// Height of the indicator. Defaults to 4
  final double height;

  /// Determines to location of the tab, [TabPosition.bottom] set to default.
  final TabPosition tabPosition;

  /// topRight radius of the indicator, default to 5.
  final double topRightRadius;

  /// topLeft radius of the indicator, default to 5.
  final double topLeftRadius;

  /// bottomRight radius of the indicator, default to 0.
  final double bottomRightRadius;

  /// bottomLeft radius of the indicator, default to 0
  final double bottomLeftRadius;

  /// Color of the indicator, default set to [Colors.black]
  final Color color;

  /// Horizontal padding of the indicator, default set 0
  final double horizontalPadding;

  /// [PagingStyle] determines if the indicator should be fill or stroke, default to fill
  final PaintingStyle paintingStyle;

  /// StrokeWidth, used for [PaintingStyle.stroke], default set to 2
  final double strokeWidth;

  FluMaterialIndicator({
    this.height = 4,
    this.tabPosition = TabPosition.bottom,
    this.topRightRadius = 5,
    this.topLeftRadius = 5,
    this.bottomRightRadius = 0,
    this.bottomLeftRadius = 0,
    this.color = Colors.black,
    this.horizontalPadding = 0,
    this.paintingStyle = PaintingStyle.fill,
    this.strokeWidth = 2,
  });
  @override
  _FluMaterialIndicatorPainter createBoxPainter([VoidCallback? onChanged]) {
    return new _FluMaterialIndicatorPainter(
      this,
      onChanged,
      bottomLeftRadius: bottomLeftRadius,
      bottomRightRadius: bottomRightRadius,
      color: color,
      height: height,
      horizontalPadding: horizontalPadding,
      tabPosition: tabPosition,
      topLeftRadius: topLeftRadius,
      topRightRadius: topRightRadius,
      paintingStyle: paintingStyle,
      strokeWidth: strokeWidth,
    );
  }
}

class _FluMaterialIndicatorPainter extends BoxPainter {
  final FluMaterialIndicator decoration;
  final double height;
  final TabPosition tabPosition;
  final double topRightRadius;
  final double topLeftRadius;
  final double bottomRightRadius;
  final double bottomLeftRadius;
  final Color color;
  final double horizontalPadding;
  final double strokeWidth;
  final PaintingStyle paintingStyle;

  _FluMaterialIndicatorPainter(
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
    Size mysize = Size(configuration.size!.width - (horizontalPadding * 2), height);

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

enum TabPosition { top, bottom }
