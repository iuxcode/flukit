import 'package:flukit/src/utils/flu_utils.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

class FluBottomNavBarStyle {
  final double height, indicatorHeight;
  final double radius;
  final double notchMargin;
  final double gapWidth;
  final EdgeInsets margin;
  final Color? background, color, activeColor, indicatorColor;
  final bool showItemLabelOnSelected, floating;
  final Duration animationDuration;
  final Curve animationCurve;
  final FluBottomNavBarIndicatorStyle indicatorStyle;
  final FluBottomNavBarIndicatorPosition indicatorPosition;
  final NotchSmoothness notchSmoothness;
  final GapLocation gapLocation;
  final FluBottomNavBarType type;
  final BorderRadius? borderRadius;
  final FluIconStyles iconStyle;
  final FluIconStyles? activeIconStyle;
  final double iconSize;
  final bool glass;

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
  });

  FluBottomNavBarStyle merge(FluBottomNavBarStyle? newStyle) => FluBottomNavBarStyle(
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
      );

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
}

enum FluBottomNavBarType { normal, curved }

enum FluBottomNavBarIndicatorPosition { top, bottom }

enum FluBottomNavBarIndicatorStyle { normal, drop }

enum GapLocation { none, center, end }

enum NotchSmoothness { sharpEdge, defaultEdge, softEdge, smoothEdge, verySmoothEdge }
