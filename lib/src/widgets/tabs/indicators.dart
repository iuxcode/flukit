import 'package:flutter/material.dart';

import '../../utils/flu_utils.dart';
import 'paints.dart';

class FluRectangularIndicator extends Decoration {
  const FluRectangularIndicator({
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

  /// [PagingStyle] determines if the indicator should be fill or stroke, default to fill
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
  FluRectangularIndicatorPainter createBoxPainter([VoidCallback? onChanged]) {
    return FluRectangularIndicatorPainter(
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
  }
}

class FluDotTabIndicator extends Decoration {
  FluDotTabIndicator({
    Color? color,
    double? radius,
  }) : _painter = FluCirclePainter(color ?? Flu.theme().primary, radius ?? 3);

  final BoxPainter _painter;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class FluMaterialIndicator extends Decoration {
  const FluMaterialIndicator({
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

  /// [PagingStyle] determines if the indicator should be fill or stroke, default to fill
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
  FluMaterialIndicatorPainter createBoxPainter([VoidCallback? onChanged]) {
    return FluMaterialIndicatorPainter(
      this,
      onChanged,
      color: color ?? Flu.theme().primary,
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
  }
}

enum TabPosition { top, bottom }
