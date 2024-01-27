import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Create glass effect
class FluGlass extends StatelessWidget {
  const FluGlass({
    required this.child,
    super.key,
    this.borderRadius,
    this.margin = EdgeInsets.zero,
    this.intensity = 5.0,
    this.cornerRadius = 0,
  });

  final BorderRadius? borderRadius;
  final Widget child;
  final double cornerRadius;
  final double intensity;
  final EdgeInsets margin;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<BorderRadius?>('borderRadius', borderRadius))
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DoubleProperty('intensity', intensity))
      ..add(DiagnosticsProperty<EdgeInsets>('margin', margin))
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DoubleProperty('intensity', intensity))
      ..add(DiagnosticsProperty<EdgeInsets>('margin', margin))
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DoubleProperty('intensity', intensity))
      ..add(DiagnosticsProperty<EdgeInsets>('margin', margin))
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DoubleProperty('intensity', intensity))
      ..add(DiagnosticsProperty<EdgeInsets>('margin', margin));
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: margin,
        child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: borderRadius ?? BorderRadius.circular(cornerRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: intensity,
              sigmaY: intensity,
            ),
            child: child,
          ),
        ),
      );
}
