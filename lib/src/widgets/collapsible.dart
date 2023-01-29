import 'package:flutter/material.dart';

class FluCollapsible extends StatefulWidget {
  final bool collapse;
  final Axis axis;
  final Alignment alignment;
  final Duration duration;
  final Curve curve;
  final Widget child;

  const FluCollapsible(
      {Key? key,
      required this.collapse,
      required this.axis,
      required this.child,
      this.alignment = Alignment.center,
      this.duration = const Duration(milliseconds: 300),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  FluCollapsibleState createState() => FluCollapsibleState();
}

class FluCollapsibleState extends State<FluCollapsible>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: widget.duration);
    animation = CurvedAnimation(parent: controller!, curve: widget.curve);
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (!widget.collapse) {
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
      axis: widget.axis,
      axisAlignment: widget.axis == Axis.horizontal ? -1.0 : 1.0,
      sizeFactor: animation!,
      child: Align(alignment: widget.alignment, child: widget.child));
}
