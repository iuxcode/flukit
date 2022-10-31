import 'package:flukit/src/utils/flu_utils.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

class FluBottomNavBarStyle {
  FluBottomNavBarStyle({
    this.background,
    this.color,
    this.activeColor,
    this.indicatorColor,
    this.height = 85.0,
    this.radius = 25.0,
    this.indicatorHeight = 8,
    this.notchMargin = 8.0,
    this.gapWidth = 45,
    this.margin = const EdgeInsets.symmetric(horizontal: 15),
    this.showItemLabelOnSelected = false,
    this.indicatorStyle = FluBottomNavBarIndicatorStyle.normal,
    this.indicatorPosition = FluBottomNavBarIndicatorPosition.bottom,
    this.animationDuration = const Duration(milliseconds: 350),
    this.animationCurve = Curves.fastOutSlowIn,
    this.notchSmoothness = NotchSmoothness.smoothEdge,
    this.gapLocation = GapLocation.center,
    this.floating = true,
    this.type = FluBottomNavBarType.normal,
    this.borderRadius,
    this.iconStyle = FluIconStyles.twotone,
    this.activeIconStyle,
    this.iconSize = 24,
    this.glass = false,
    this.alwayShowItemLabel = false,
    this.itemLabelStyle,
  });

  static FluBottomNavBarStyle defaultt = FluBottomNavBarStyle(
    background: Flukit.theme().dark,
    color: Flukit.theme().text,
    activeColor: Flukit.theme().primary,
  );

  static FluBottomNavBarStyle secondary = FluBottomNavBarStyle(
    background: Flukit.theme().secondary,
    color: Flukit.theme().text,
    activeColor: Flukit.theme().primary,
  );

  final FluIconStyles? activeIconStyle;
  final bool glass, alwayShowItemLabel;
  final Curve animationCurve;
  final Duration animationDuration;
  final BorderRadius? borderRadius;
  final bool showItemLabelOnSelected, floating;
  final GapLocation gapLocation;
  final double gapWidth;
  final double iconSize;
  final FluIconStyles iconStyle;
  final Color? background, color, activeColor, indicatorColor;
  final double height, indicatorHeight;
  final FluBottomNavBarIndicatorPosition indicatorPosition;
  final FluBottomNavBarIndicatorStyle indicatorStyle;
  final TextStyle? itemLabelStyle;
  final EdgeInsets margin;
  final double notchMargin;
  final NotchSmoothness notchSmoothness;
  final double radius;
  final FluBottomNavBarType type;

  FluBottomNavBarStyle merge(FluBottomNavBarStyle? newStyle) =>
      FluBottomNavBarStyle(
        height: newStyle?.height ?? height,
        radius: newStyle?.radius ?? radius,
        notchMargin: newStyle?.notchMargin ?? notchMargin,
        gapWidth: newStyle?.gapWidth ?? gapWidth,
        background: newStyle?.background ?? background,
        color: newStyle?.color ?? color,
        activeColor: newStyle?.activeColor ?? activeColor,
        indicatorColor: newStyle?.indicatorColor ?? indicatorColor,
        showItemLabelOnSelected:
            newStyle?.showItemLabelOnSelected ?? showItemLabelOnSelected,
        indicatorStyle: newStyle?.indicatorStyle ?? indicatorStyle,
        indicatorPosition: newStyle?.indicatorPosition ?? indicatorPosition,
        animationDuration: newStyle?.animationDuration ?? animationDuration,
        animationCurve: newStyle?.animationCurve ?? animationCurve,
        notchSmoothness: newStyle?.notchSmoothness ?? notchSmoothness,
        gapLocation: newStyle?.gapLocation ?? gapLocation,
        floating: newStyle?.floating ?? floating,
        type: newStyle?.type ?? type,
        borderRadius: newStyle?.borderRadius ?? borderRadius,
        indicatorHeight: newStyle?.indicatorHeight ?? indicatorHeight,
        iconStyle: newStyle?.iconStyle ?? iconStyle,
        activeIconStyle: newStyle?.activeIconStyle ?? activeIconStyle,
        iconSize: newStyle?.iconSize ?? iconSize,
        glass: newStyle?.glass ?? glass,
        alwayShowItemLabel: newStyle?.alwayShowItemLabel ?? alwayShowItemLabel,
        itemLabelStyle: newStyle?.itemLabelStyle ?? itemLabelStyle,
      );
}

enum FluBottomNavBarType { normal, curved }

enum FluBottomNavBarIndicatorPosition { top, bottom }

enum FluBottomNavBarIndicatorStyle { normal, drop }

enum GapLocation { none, center, end }

enum NotchSmoothness {
  sharpEdge,
  defaultEdge,
  softEdge,
  smoothEdge,
  verySmoothEdge
}
