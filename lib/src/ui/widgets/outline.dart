import 'package:flukit/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

/// Create a border around the `child`.
class FluOutline extends StatelessWidget {
  const FluOutline({
    required this.child,
    super.key,
    this.thickness = 1.5,
    this.cornerRadius = 18,
    this.gap = 2,
    this.colors = const [],
    this.borderRadius,
    this.boxShadow,
    this.margin = EdgeInsets.zero,
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
    this.circle = false,
  });

  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Widget child;
  final bool circle;
  final List<Color> colors;
  final double cornerRadius;
  final double gap;
  final Alignment gradientBegin;
  final Alignment gradientEnd;
  final EdgeInsets margin;
  final double thickness;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<BorderRadius?>('borderRadius', borderRadius))
      ..add(IterableProperty<BoxShadow>('boxShadow', boxShadow))
      ..add(IterableProperty<Color>('colors', colors))
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DoubleProperty('gap', gap))
      ..add(DiagnosticsProperty<Alignment>('gradientBegin', gradientBegin))
      ..add(DiagnosticsProperty<Alignment>('gradientEnd', gradientEnd))
      ..add(DiagnosticsProperty<EdgeInsets>('margin', margin))
      ..add(DoubleProperty('thickness', thickness))
      ..add(DiagnosticsProperty<bool>('circle', circle))
      ..add(IterableProperty<BoxShadow>('boxShadow', boxShadow))
      ..add(IterableProperty<Color>('colors', colors))
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DoubleProperty('gap', gap))
      ..add(DiagnosticsProperty<Alignment>('gradientBegin', gradientBegin))
      ..add(DiagnosticsProperty<Alignment>('gradientEnd', gradientEnd))
      ..add(DiagnosticsProperty<EdgeInsets>('margin', margin))
      ..add(DoubleProperty('thickness', thickness))
      ..add(DiagnosticsProperty<bool>('circle', circle))
      ..add(IterableProperty<BoxShadow>('boxShadow', boxShadow))
      ..add(IterableProperty<Color>('colors', colors))
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DoubleProperty('gap', gap))
      ..add(DiagnosticsProperty<Alignment>('gradientBegin', gradientBegin))
      ..add(DiagnosticsProperty<Alignment>('gradientEnd', gradientEnd))
      ..add(DiagnosticsProperty<EdgeInsets>('margin', margin))
      ..add(DoubleProperty('thickness', thickness))
      ..add(DiagnosticsProperty<bool>('circle', circle))
      ..add(IterableProperty<BoxShadow>('boxShadow', boxShadow))
      ..add(IterableProperty<Color>('colors', colors))
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DoubleProperty('gap', gap))
      ..add(DiagnosticsProperty<Alignment>('gradientBegin', gradientBegin))
      ..add(DiagnosticsProperty<Alignment>('gradientEnd', gradientEnd))
      ..add(DiagnosticsProperty<EdgeInsets>('margin', margin))
      ..add(DoubleProperty('thickness', thickness))
      ..add(DiagnosticsProperty<bool>('circle', circle));
  }

  @override
  Widget build(BuildContext context) {
    BoxBorder border;

    if (colors.length <= 1) {
      border = Border.all(
        color:
            colors.isEmpty ? context.colorScheme.surfaceVariant : colors.first,
        width: thickness,
      );
    } else {
      border = GradientBoxBorder(
        gradient: LinearGradient(
          colors: colors,
          begin: gradientBegin,
          end: gradientEnd,
        ),
        width: thickness,
      );
    }

    return Container(
      padding: EdgeInsets.all(gap),
      margin: margin,
      decoration: BoxDecoration(
        shape: circle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: !circle
            ? (borderRadius ?? BorderRadius.circular(cornerRadius))
            : null,
        border: border,
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
