import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FluCollapsible extends StatefulWidget {
  const FluCollapsible({
    required this.collapse,
    required this.axis,
    required this.child,
    super.key,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.linear,
  });

  final Alignment alignment;
  final Axis axis;
  final Widget child;
  final bool collapse;
  final Curve curve;
  final Duration duration;

  @override
  FluCollapsibleState createState() => FluCollapsibleState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Alignment>('alignment', alignment))
      ..add(EnumProperty<Axis>('axis', axis))
      ..add(DiagnosticsProperty<bool>('collapse', collapse))
      ..add(DiagnosticsProperty<Curve>('curve', curve))
      ..add(DiagnosticsProperty<Duration>('duration', duration))
      ..add(EnumProperty<Axis>('axis', axis))
      ..add(DiagnosticsProperty<bool>('collapse', collapse))
      ..add(DiagnosticsProperty<Curve>('curve', curve))
      ..add(DiagnosticsProperty<Duration>('duration', duration))
      ..add(EnumProperty<Axis>('axis', axis))
      ..add(DiagnosticsProperty<bool>('collapse', collapse))
      ..add(DiagnosticsProperty<Curve>('curve', curve))
      ..add(DiagnosticsProperty<Duration>('duration', duration))
      ..add(EnumProperty<Axis>('axis', axis))
      ..add(DiagnosticsProperty<bool>('collapse', collapse))
      ..add(DiagnosticsProperty<Curve>('curve', curve))
      ..add(DiagnosticsProperty<Duration>('duration', duration));
  }
}

class FluCollapsibleState extends State<FluCollapsible>
    with SingleTickerProviderStateMixin {
  late final Animation<double> animation;
  late final AnimationController controller;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Animation<double>>('animation', animation))
      ..add(DiagnosticsProperty<AnimationController>('controller', controller))
      ..add(DiagnosticsProperty<AnimationController>('controller', controller))
      ..add(DiagnosticsProperty<AnimationController>('controller', controller))
      ..add(DiagnosticsProperty<AnimationController>('controller', controller));
  }

  @override
  void didUpdateWidget(FluCollapsible oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: widget.duration);
    animation = CurvedAnimation(parent: controller, curve: widget.curve);
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (!widget.collapse) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) => SizeTransition(
        axis: widget.axis,
        axisAlignment: widget.axis == Axis.horizontal ? -1.0 : 1.0,
        sizeFactor: animation,
        child: Align(alignment: widget.alignment, child: widget.child),
      );
}
