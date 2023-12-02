import 'package:flukit/flukit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FluModalBottomSheet extends StatelessWidget {
  const FluModalBottomSheet({
    required this.child,
    super.key,
    this.padding = EdgeInsets.zero,
    this.cornerRadius,
    this.maxHeight,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.scrollable = true,
  });

  final Curve animationCurve;
  final Duration animationDuration;
  final Widget child;
  final double? cornerRadius;
  final double? maxHeight;
  final EdgeInsets padding;
  final bool scrollable;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Curve>('animationCurve', animationCurve))
      ..add(
        DiagnosticsProperty<Duration>('animationDuration', animationDuration),
      )
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DoubleProperty('maxHeight', maxHeight))
      ..add(DiagnosticsProperty<EdgeInsets>('padding', padding))
      ..add(DiagnosticsProperty<bool>('scrollable', scrollable))
      ..add(
        DiagnosticsProperty<Duration>('animationDuration', animationDuration),
      )
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DoubleProperty('maxHeight', maxHeight))
      ..add(DiagnosticsProperty<EdgeInsets>('padding', padding))
      ..add(DiagnosticsProperty<bool>('scrollable', scrollable))
      ..add(
        DiagnosticsProperty<Duration>('animationDuration', animationDuration),
      )
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DoubleProperty('maxHeight', maxHeight))
      ..add(DiagnosticsProperty<EdgeInsets>('padding', padding))
      ..add(DiagnosticsProperty<bool>('scrollable', scrollable))
      ..add(
        DiagnosticsProperty<Duration>('animationDuration', animationDuration),
      )
      ..add(DoubleProperty('cornerRadius', cornerRadius))
      ..add(DoubleProperty('maxHeight', maxHeight))
      ..add(DiagnosticsProperty<EdgeInsets>('padding', padding))
      ..add(DiagnosticsProperty<bool>('scrollable', scrollable));
  }

  @override
  Widget build(BuildContext context) {
    final defaultCornerRadius =
        Radius.circular(cornerRadius ?? context.width * .05);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: context.colorScheme.background,
      ),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FluLine(
              height: 3,
              width: context.width * .20,
              radius: 50,
              color: context.colorScheme.background,
              margin: const EdgeInsets.only(bottom: 8),
            ),
            Flexible(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: maxHeight ?? context.height * .85,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: defaultCornerRadius,
                    topRight: defaultCornerRadius,
                  ),
                  color: context.colorScheme.background,
                ),
                child: scrollable
                    ? SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: padding,
                        child: child,
                      )
                    : child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
