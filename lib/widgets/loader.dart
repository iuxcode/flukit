import 'package:flutter/material.dart';
import 'dashed_circle.dart';

/// Creates a circular progress indicator.
/// Inspired by https://vuesax.com/docs/components/Loading.html#type
class FluLoader extends StatefulWidget {
  const FluLoader({
    super.key,
    this.size = 30,
    this.strokeWidth = 3,
    this.animationDuration = const Duration(milliseconds: 800),
    this.margin = EdgeInsets.zero,
    this.color,
  });

  /// loader size
  final double size;

  /// loader thickness
  final double strokeWidth;

  /// loader animation duration
  /// time to take to make one rotation
  final Duration animationDuration;

  /// Empty space to surround the avatar and [child].
  final EdgeInsets margin;

  /// loader color
  final Color? color;

  @override
  State<FluLoader> createState() => _FluLoaderState();
}

class _FluLoaderState extends State<FluLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.repeat();
        }
      })
      ..forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = widget.color ?? colorScheme.primary;
    const layerAngle = 80;
    final layers = [
      FluArc(
        numberOfDashes: 4,
        angle: layerAngle,
        color: color.withOpacity(.35),
        size: widget.size,
        strokeWidth: widget.strokeWidth,
      ),
      FluArc(
        angle: layerAngle,
        strokeCap: StrokeCap.round,
        size: widget.size,
        strokeWidth: widget.strokeWidth,
        color: color,
      ),
    ];

    final Widget loader = Stack(
      alignment: Alignment.center,
      children: layers
          .map(
            (layer) => _animatedArc(layer,
                layers.indexOf(layer) == 1 ? Curves.ease : Curves.linear),
          )
          .toList(),
    );

    if (widget.margin != EdgeInsets.zero) {
      return Padding(
        padding: widget.margin,
        child: loader,
      );
    }

    return loader;
  }

  Widget _animatedArc(Widget child, Curve curve) => RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animationController, curve: curve)),
        child: child,
      );
}
