import 'package:flutter/material.dart';

/// Add badge to a widget
class FluBadge extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Color? foregroundColor;
  final Offset offset;
  final BadgePosition position;
  final double size;

  const FluBadge({
    super.key,
    required this.child,
    this.color,
    this.foregroundColor,
    this.offset = const Offset(2, 2),
    this.position = BadgePosition.topLeft,
    this.size = 8,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
      children: [
        child,
        Positioned(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              color: color ?? colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
        )
      ],
    );
  }
}

enum BadgePosition { topLeft, topRight, bottomLeft, bottomRight }
