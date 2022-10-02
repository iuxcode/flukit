import 'package:flutter/material.dart';
import '../../utils/flu_utils.dart';
import 'paints.dart';

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

  const FluRectangularIndicator({
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
  FluRectangularIndicatorPainter createBoxPainter([VoidCallback? onChanged]) {
    return FluRectangularIndicatorPainter(
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

class FluDotTabIndicator extends Decoration {
  final BoxPainter _painter;

  FluDotTabIndicator({
    Color? color,
    double? radius,
  }) : _painter = FluCirclePainter(color ?? Flukit.theme.primaryColor, radius ?? 3);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
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

  const FluMaterialIndicator({
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
  FluMaterialIndicatorPainter createBoxPainter([VoidCallback? onChanged]) {
    return FluMaterialIndicatorPainter(
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

enum TabPosition { top, bottom }
