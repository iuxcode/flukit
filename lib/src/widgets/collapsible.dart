import 'package:flutter/material.dart';

enum FluCollapsibleAxis {
  horizontal,
  vertical
}

class FluCollapsible extends StatefulWidget {
  final bool collapse;
  final FluCollapsibleAxis axis;
  final Alignment alignment;
  final Duration animDuration;
  final Curve animCurve;
  final Widget child;

  const FluCollapsible({
    Key? key,
    required this.collapse,
    required this.axis,
    required this.child,
    this.alignment = Alignment.center,
    this.animDuration = const Duration(milliseconds: 300),
    this.animCurve = Curves.linear
  }): super(key: key);

  @override
  _FluCollapsibleState createState() => _FluCollapsibleState();
}

class _FluCollapsibleState extends State<FluCollapsible> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;

  bool get _horizontal => widget.axis == FluCollapsibleAxis.horizontal;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  void prepareAnimations() {
    controller = AnimationController(vsync: this, duration: widget.animDuration);
    animation = CurvedAnimation(parent: controller!, curve: widget.animCurve);
  }

  void _runExpandCheck() {
    if(!widget.collapse) {
      controller!.forward();
    } else {
      controller!.reverse();
    }
  }

  @override
  void didUpdateWidget(FluCollapsible oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizeTransition(
    axis: _horizontal ? Axis.horizontal : Axis.vertical,
    axisAlignment: _horizontal ? -1.0 : 1.0,
    sizeFactor: animation!,
    child: Align(
      alignment: widget.alignment,
      child: widget.child
    )
  );
}