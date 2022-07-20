import 'package:flutter/material.dart';
import '../../flukit.dart';

class FluModalBottomSheet extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? radius;
  final double maxChildSize;
  final Duration animationDuration;
  final Curve animationCurve;
  final double defaultRadius = Flukit.screenSize.width * .085;

  FluModalBottomSheet({
    Key? key,
    required this.child,
    this.padding,
    this.radius,
    this.maxChildSize = .85,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DraggableScrollableSheet(
            expand: false,
            maxChildSize: maxChildSize,
            builder: (BuildContext context, ScrollController scrollController) {
              return Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /* Expanded(child: GestureDetector(
              onTap: () => Navigator.pop(context),
            )), */
                  AnimatedContainer(
                    height: 4,
                    width: Flukit.screenSize.width * .20,
                    margin: const EdgeInsets.only(bottom: 8),
                    duration: animationDuration,
                    curve: animationCurve,
                    decoration: BoxDecoration(
                        color: Flukit.theme.backgroundColor.withOpacity(.9),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Expanded(
                    child: AnimatedContainer(
                      width: double.infinity,
                      duration: animationDuration,
                      curve: animationCurve,
                      decoration: BoxDecoration(
                        color: Flukit.theme.backgroundColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radius ?? defaultRadius),
                            topRight: Radius.circular(radius ?? defaultRadius)),
                      ),
                      child: SingleChildScrollView(
                          controller: scrollController,
                          padding: padding ??
                              EdgeInsets.all(
                                  Flukit.appConsts.defaultPaddingSize),
                          child: child),
                    ),
                  ),
                ],
              );
            }),
      );
}
