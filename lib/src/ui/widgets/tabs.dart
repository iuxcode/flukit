// ignore_for_file: prefer_asserts_with_message

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RectangularIndicator extends Decoration {
  const RectangularIndicator({
    this.cornerRadius = 25,
    this.topRightCornerRadius,
    this.topLeftCornerRadius,
    this.bottomRightCornerRadius,
    this.bottomLeftCornerRadius,
    this.color = Colors.black,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
    this.paintingStyle = PaintingStyle.fill,
    this.strokeWidth = 2,
  });

  /// bottomLeft radius of the indicator
  final double? bottomLeftCornerRadius;

  /// bottomRight radius of the indicator.
  final double? bottomRightCornerRadius;

  /// Color of the indicator, default set to [Colors.black]
  final Color color;

  /// Corner radius, default to 25
  final double cornerRadius;

  /// Horizontal padding of the indicator, default set to 0
  final double horizontalPadding;

  /// `PagingStyle` determines if the indicator should be fill or
  /// stroke, default to fill
  final PaintingStyle paintingStyle;

  /// StrokeWidth, used for [PaintingStyle.stroke], default set to 0
  final double strokeWidth;

  /// topLeft radius of the indicator.
  final double? topLeftCornerRadius;

  /// topRight radius of the indicator.
  final double? topRightCornerRadius;

  /// Vertical padding of the indicator, default set to 0
  final double verticalPadding;

  @override
  RectangularIndicatorPainter createBoxPainter([VoidCallback? onChanged]) =>
      RectangularIndicatorPainter(
        this,
        onChanged,
        topLeftRadius: topLeftCornerRadius ?? cornerRadius,
        topRightRadius: topRightCornerRadius ?? cornerRadius,
        bottomLeftRadius: bottomLeftCornerRadius ?? cornerRadius,
        bottomRightRadius: bottomRightCornerRadius ?? cornerRadius,
        color: color,
        horizontalPadding: horizontalPadding,
        verticalPadding: verticalPadding,
        paintingStyle: paintingStyle,
        strokeWidth: strokeWidth,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('bottomLeftCornerRadius', bottomLeftCornerRadius))
      ..add(DoubleProperty('bottomRightCornerRadius', bottomRightCornerRadius))
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DoubleProperty('horizontalPadding', horizontalPadding))
      ..add(EnumProperty<PaintingStyle>('paintingStyle', paintingStyle))
      ..add(DoubleProperty('strokeWidth', strokeWidth))
      ..add(DoubleProperty('topLeftCornerRadius', topLeftCornerRadius))
      ..add(DoubleProperty('topRightCornerRadius', topRightCornerRadius))
      ..add(DoubleProperty('verticalPadding', verticalPadding))
      ..add(DoubleProperty('bottomRightCornerRadius', bottomRightCornerRadius))
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DoubleProperty('horizontalPadding', horizontalPadding))
      ..add(EnumProperty<PaintingStyle>('paintingStyle', paintingStyle))
      ..add(DoubleProperty('strokeWidth', strokeWidth))
      ..add(DoubleProperty('topLeftCornerRadius', topLeftCornerRadius))
      ..add(DoubleProperty('topRightCornerRadius', topRightCornerRadius))
      ..add(DoubleProperty('verticalPadding', verticalPadding))
      ..add(DoubleProperty('bottomRightCornerRadius', bottomRightCornerRadius))
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DoubleProperty('horizontalPadding', horizontalPadding))
      ..add(EnumProperty<PaintingStyle>('paintingStyle', paintingStyle))
      ..add(DoubleProperty('strokeWidth', strokeWidth))
      ..add(DoubleProperty('topLeftCornerRadius', topLeftCornerRadius))
      ..add(DoubleProperty('topRightCornerRadius', topRightCornerRadius))
      ..add(DoubleProperty('verticalPadding', verticalPadding))
      ..add(DoubleProperty('bottomRightCornerRadius', bottomRightCornerRadius))
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DoubleProperty('horizontalPadding', horizontalPadding))
      ..add(EnumProperty<PaintingStyle>('paintingStyle', paintingStyle))
      ..add(DoubleProperty('strokeWidth', strokeWidth))
      ..add(DoubleProperty('topLeftCornerRadius', topLeftCornerRadius))
      ..add(DoubleProperty('topRightCornerRadius', topRightCornerRadius))
      ..add(DoubleProperty('verticalPadding', verticalPadding));
  }
}

class DotTabIndicator extends Decoration {
  DotTabIndicator({
    Color? color,
    double? radius,
  }) : _painter = CirclePainter(color ?? Colors.blue, radius ?? 3);

  final BoxPainter _painter;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class MaterialIndicator extends Decoration {
  const MaterialIndicator({
    this.height = 4,
    this.tabPosition = TabPosition.bottom,
    this.topRightRadius = 5,
    this.topLeftRadius = 5,
    this.bottomRightRadius = 0,
    this.bottomLeftRadius = 0,
    this.color,
    this.horizontalPadding = 0,
    this.paintingStyle = PaintingStyle.fill,
    this.strokeWidth = 2,
  });

  /// bottomLeft radius of the indicator, default to 0
  final double bottomLeftRadius;

  /// bottomRight radius of the indicator, default to 0.
  final double bottomRightRadius;

  /// Color of the indicator, default set to [Colors.black]
  final Color? color;

  /// Height of the indicator. Defaults to 4
  final double height;

  /// Horizontal padding of the indicator, default set 0
  final double horizontalPadding;

  /// `PagingStyle` determines if the indicator should be fill
  /// or stroke, default to fill
  final PaintingStyle paintingStyle;

  /// StrokeWidth, used for [PaintingStyle.stroke], default set to 2
  final double strokeWidth;

  /// Determines to location of the tab, [TabPosition.bottom] set to default.
  final TabPosition tabPosition;

  /// topLeft radius of the indicator, default to 5.
  final double topLeftRadius;

  /// topRight radius of the indicator, default to 5.
  final double topRightRadius;

  @override
  MaterialIndicatorPainter createBoxPainter([VoidCallback? onChanged]) =>
      MaterialIndicatorPainter(
        this,
        onChanged,
        color: color ?? Colors.blue,
        height: height,
        horizontalPadding: horizontalPadding,
        tabPosition: tabPosition,
        bottomLeftRadius: bottomLeftRadius,
        bottomRightRadius: bottomRightRadius,
        topLeftRadius: topLeftRadius,
        topRightRadius: topRightRadius,
        paintingStyle: paintingStyle,
        strokeWidth: strokeWidth,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('bottomLeftRadius', bottomLeftRadius))
      ..add(DoubleProperty('bottomRightRadius', bottomRightRadius))
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('horizontalPadding', horizontalPadding))
      ..add(EnumProperty<PaintingStyle>('paintingStyle', paintingStyle))
      ..add(DoubleProperty('strokeWidth', strokeWidth))
      ..add(EnumProperty<TabPosition>('tabPosition', tabPosition))
      ..add(DoubleProperty('topLeftRadius', topLeftRadius))
      ..add(DoubleProperty('topRightRadius', topRightRadius))
      ..add(DoubleProperty('bottomRightRadius', bottomRightRadius))
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('horizontalPadding', horizontalPadding))
      ..add(EnumProperty<PaintingStyle>('paintingStyle', paintingStyle))
      ..add(DoubleProperty('strokeWidth', strokeWidth))
      ..add(EnumProperty<TabPosition>('tabPosition', tabPosition))
      ..add(DoubleProperty('topLeftRadius', topLeftRadius))
      ..add(DoubleProperty('topRightRadius', topRightRadius))
      ..add(DoubleProperty('bottomRightRadius', bottomRightRadius))
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('horizontalPadding', horizontalPadding))
      ..add(EnumProperty<PaintingStyle>('paintingStyle', paintingStyle))
      ..add(DoubleProperty('strokeWidth', strokeWidth))
      ..add(EnumProperty<TabPosition>('tabPosition', tabPosition))
      ..add(DoubleProperty('topLeftRadius', topLeftRadius))
      ..add(DoubleProperty('topRightRadius', topRightRadius))
      ..add(DoubleProperty('bottomRightRadius', bottomRightRadius))
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('horizontalPadding', horizontalPadding))
      ..add(EnumProperty<PaintingStyle>('paintingStyle', paintingStyle))
      ..add(DoubleProperty('strokeWidth', strokeWidth))
      ..add(EnumProperty<TabPosition>('tabPosition', tabPosition))
      ..add(DoubleProperty('topLeftRadius', topLeftRadius))
      ..add(DoubleProperty('topRightRadius', topRightRadius));
  }
}

class RectangularIndicatorPainter extends BoxPainter {
  RectangularIndicatorPainter(
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
  final RectangularIndicator decoration;
  final double horizontalPadding;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final double topLeftRadius;
  final double topRightRadius;
  final double verticalPadding;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(horizontalPadding >= 0);
    assert(
      horizontalPadding < configuration.size!.width / 2,
      'Padding must be less than half of the size of the tab',
    );
    assert(
      verticalPadding < configuration.size!.height / 2 && verticalPadding >= 0,
    );
    assert(
      strokeWidth >= 0 &&
          strokeWidth < configuration.size!.width / 2 &&
          strokeWidth < configuration.size!.height / 2,
    );

    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.
    final rectSize = Size(
      configuration.size!.width - (horizontalPadding * 2),
      configuration.size!.height - (2 * verticalPadding),
    );
    final rectOffset =
        Offset(offset.dx + horizontalPadding, offset.dy + verticalPadding);

    final rect = rectOffset & rectSize;
    final paint = Paint()
      ..color = color
      ..style = paintingStyle
      ..strokeWidth = strokeWidth;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        bottomRight: Radius.circular(bottomRightRadius),
        bottomLeft: Radius.circular(bottomLeftRadius),
        topLeft: Radius.circular(topLeftRadius),
        topRight: Radius.circular(topRightRadius),
      ),
      paint,
    );
  }
}

class CirclePainter extends BoxPainter {
  CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  final double radius;

  final Paint _paint;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final circleOffset = offset +
        Offset(
          configuration.size!.width / 2,
          configuration.size!.height - radius,
        );
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

class MaterialIndicatorPainter extends BoxPainter {
  MaterialIndicatorPainter(
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
  final MaterialIndicator decoration;
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
    assert(
      horizontalPadding < configuration.size!.width / 2,
      'Padding must be less than half of the size of the tab',
    );
    assert(height > 0);
    assert(
      strokeWidth >= 0 &&
          strokeWidth < configuration.size!.width / 2 &&
          strokeWidth < configuration.size!.height / 2,
    );

    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.
    final rectSize =
        Size(configuration.size!.width - (horizontalPadding * 2), height);

    final rectOffset = Offset(
      offset.dx + horizontalPadding,
      offset.dy +
          (tabPosition == TabPosition.bottom
              ? configuration.size!.height - height
              : 0),
    );

    final rect = rectOffset & rectSize;
    final paint = Paint()
      ..color = color
      ..style = paintingStyle
      ..strokeWidth = strokeWidth;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        bottomRight: Radius.circular(bottomRightRadius),
        bottomLeft: Radius.circular(bottomLeftRadius),
        topLeft: Radius.circular(topLeftRadius),
        topRight: Radius.circular(topRightRadius),
      ),
      paint,
    );
  }
}

enum TabPosition { top, bottom }
