import 'dart:ui';

import 'package:flutter/material.dart';

class FluGlass extends StatelessWidget {
  final double intensity;
  final double? height, width, radius, sigmaX, sigmaY;
  final BorderRadius? borderRadius;
  final BoxShadow? shadow;
  final EdgeInsets? margin;
  final Widget? child, background;
  final Clip clipBehavior;
  final AlignmentGeometry alignment;

  const FluGlass(
      {Key? key,
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
      this.clipBehavior = Clip.antiAlias,
      this.alignment = AlignmentDirectional.topStart})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: height,
        width: width,
        margin: margin,
        decoration: BoxDecoration(boxShadow: shadow != null ? [shadow!] : null),
        child: ClipRRect(
          clipBehavior: clipBehavior,
          borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: alignment,
            children: [
              if (background != null) background!,
              ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  child: BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: sigmaX ?? intensity,
                          sigmaY: sigmaY ?? intensity),
                      child: child ?? Container())),
            ],
          ),
        ),
      );
}
