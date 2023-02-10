import 'dart:math';

import 'package:flutter/material.dart';

import 'dashed_circle.dart';

/// Creates a circular progress indicator.
/// Inspired by https://vuesax.com/docs/components/Loading.html#type
class FluLoader extends StatefulWidget {
  const FluLoader(
      {super.key,
      this.size = 35,
      this.animationDuration = const Duration(milliseconds: 800)});

  final double size;
  final Duration animationDuration;

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
    const layerAngle = 90;
    final layers = [
      FluArc(
        numberOfDashes: 4,
        angle: layerAngle,
        color: colorScheme.primaryContainer,
        child: SizedBox(
          height: widget.size,
          width: widget.size,
        ),
      ),
      FluArc(
        angle: layerAngle,
        strokeCap: StrokeCap.round,
        child: SizedBox(
          width: widget.size,
          height: widget.size,
        ),
      ),
    ];

    return Stack(
      alignment: Alignment.center,
      children: layers
          .map(
            (layer) => _animatedArc(
              layer,
              layers.indexOf(layer) == 1 ? Curves.ease : Curves.linear,
            ),
          )
          .toList(),
    );
  }

  Widget _animatedArc(Widget child, Curve curve) => RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animationController, curve: curve)),
        child: child,
      );
}
