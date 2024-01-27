import 'package:flukit/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Add badge to a widget
class FluBadge extends StatelessWidget {
  const FluBadge({
    required this.child,
    super.key,
    this.color,
    this.foregroundColor,
    this.offset = const Offset(2, 2),
    this.position = BadgePosition.topLeft,
    this.size = 8,
    this.count,
    this.countLimit = 99,
    this.outlined = false,
    this.outlineThickness = 1.25,
    this.outlineColor,
    this.boxShadow,
  });

  final List<BoxShadow>? boxShadow;
  final Widget child;
  final Color? color;
  final int? count;
  final int countLimit;
  final Color? foregroundColor;
  final Offset offset;
  final Color? outlineColor;
  final double outlineThickness;
  final bool outlined;
  final BadgePosition position;
  final double size;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<BoxShadow>('boxShadow', boxShadow))
      ..add(ColorProperty('color', color))
      ..add(IntProperty('count', count))
      ..add(IntProperty('countLimit', countLimit))
      ..add(ColorProperty('foregroundColor', foregroundColor))
      ..add(DiagnosticsProperty<Offset>('offset', offset))
      ..add(ColorProperty('outlineColor', outlineColor))
      ..add(DoubleProperty('outlineThickness', outlineThickness))
      ..add(DiagnosticsProperty<bool>('outlined', outlined))
      ..add(EnumProperty<BadgePosition>('position', position))
      ..add(DoubleProperty('size', size))
      ..add(ColorProperty('color', color))
      ..add(IntProperty('count', count))
      ..add(IntProperty('countLimit', countLimit))
      ..add(ColorProperty('foregroundColor', foregroundColor))
      ..add(DiagnosticsProperty<Offset>('offset', offset))
      ..add(ColorProperty('outlineColor', outlineColor))
      ..add(DoubleProperty('outlineThickness', outlineThickness))
      ..add(DiagnosticsProperty<bool>('outlined', outlined))
      ..add(EnumProperty<BadgePosition>('position', position))
      ..add(DoubleProperty('size', size))
      ..add(ColorProperty('color', color))
      ..add(IntProperty('count', count))
      ..add(IntProperty('countLimit', countLimit))
      ..add(ColorProperty('foregroundColor', foregroundColor))
      ..add(DiagnosticsProperty<Offset>('offset', offset))
      ..add(ColorProperty('outlineColor', outlineColor))
      ..add(DoubleProperty('outlineThickness', outlineThickness))
      ..add(DiagnosticsProperty<bool>('outlined', outlined))
      ..add(EnumProperty<BadgePosition>('position', position))
      ..add(DoubleProperty('size', size))
      ..add(ColorProperty('color', color))
      ..add(IntProperty('count', count))
      ..add(IntProperty('countLimit', countLimit))
      ..add(ColorProperty('foregroundColor', foregroundColor))
      ..add(DiagnosticsProperty<Offset>('offset', offset))
      ..add(ColorProperty('outlineColor', outlineColor))
      ..add(DoubleProperty('outlineThickness', outlineThickness))
      ..add(DiagnosticsProperty<bool>('outlined', outlined))
      ..add(EnumProperty<BadgePosition>('position', position))
      ..add(DoubleProperty('size', size));
  }

  @override
  Widget build(BuildContext context) {
    final isLargeBadge = count != null;
    final limitReached = (count ?? 0) > countLimit;
    double? top, left, right, bottom;

    switch (position) {
      case BadgePosition.topLeft:
        top = offset.dy;
        left = offset.dx;
        break;
      case BadgePosition.topRight:
        top = offset.dy;
        right = offset.dx;
        break;
      case BadgePosition.bottomLeft:
        bottom = offset.dy;
        left = offset.dx;
        break;
      case BadgePosition.bottomRight:
        bottom = offset.dy;
        right = offset.dx;
        break;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
          child: Container(
            height: isLargeBadge ? null : size,
            width: isLargeBadge ? null : size,
            padding: EdgeInsets.symmetric(
              vertical: isLargeBadge ? 4 : 0,
              horizontal: isLargeBadge ? 8 : 0,
            ),
            decoration: BoxDecoration(
              color: color ?? context.colorScheme.primary,
              shape: isLargeBadge ? BoxShape.rectangle : BoxShape.circle,
              borderRadius: isLargeBadge ? BorderRadius.circular(999) : null,
              border: outlined
                  ? Border.all(
                      width: outlineThickness,
                      color: outlineColor ?? context.colorScheme.background,
                    )
                  : null,
              boxShadow: boxShadow,
            ),
            child: isLargeBadge
                ? Text(
                    (count! > countLimit ? countLimit : count).toString() +
                        (limitReached ? '+' : ''),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onPrimary,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

enum BadgePosition { topLeft, topRight, bottomLeft, bottomRight }
