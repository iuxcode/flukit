import 'dart:ui';

import 'package:flutter/material.dart';

class FluGlass extends StatelessWidget {
  final double intensity;
  final double? height, width, radius, sigmaX, sigmaY;
  final BorderRadius? borderRadius;
  final BoxShadow? shadow;
  final EdgeInsets? margin;
  final Widget? child, background;

  const FluGlass({
    Key? key,
    this.height,
    this.width,
    this.radius,
    this.sigmaX,
    this.sigmaY,
    this.borderRadius,
    this.shadow,
    this.margin,
    this.background,
    this.child,
    this.intensity = 7.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    height: height,
    width: width,
    margin: margin,
    decoration: BoxDecoration(
      boxShadow: shadow != null ? [shadow!] : null
    ),
    child: ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0),
      child: Stack(
        children: [
          if(background != null) background!,
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: sigmaX ?? intensity,
              sigmaY: sigmaY ?? intensity
            ),
            child: child ?? Container()
          ),
        ],
      ),
    ),
  );
}