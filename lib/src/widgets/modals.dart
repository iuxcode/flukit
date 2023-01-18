import 'package:flukit/src/utils/flu_utils.dart';
import 'package:flutter/material.dart';

class FluModalBottomSheet extends StatelessWidget {
  FluModalBottomSheet({
    Key? key,
    required this.child,
    this.padding,
    this.radius,
    this.maxChildSize = .85,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  }) : super(key: key);

  final Curve animationCurve;
  final Duration animationDuration;
  final Widget child;
  final double defaultRadius = Flu.screenSize.width * .085;
  final double maxChildSize;
  final EdgeInsets? padding;
  final double? radius;

  @override
  Widget build(BuildContext context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DraggableScrollableSheet(
            expand: false,
            maxChildSize: maxChildSize,
            builder: (BuildContext context, ScrollController scrollController) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /* Flexible(
                      child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                  )), */
                  AnimatedContainer(
                    height: 4,
                    width: Flu.screenSize.width * .20,
                    margin: const EdgeInsets.only(bottom: 8),
                    duration: animationDuration,
                    curve: animationCurve,
                    decoration: BoxDecoration(
                        color: Flu.theme.background.withOpacity(.9),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: AnimatedContainer(
                      width: double.infinity,
                      duration: animationDuration,
                      curve: animationCurve,
                      decoration: BoxDecoration(
                        color: Flu.theme.background,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radius ?? defaultRadius),
                            topRight: Radius.circular(radius ?? defaultRadius)),
                      ),
                      child: SingleChildScrollView(
                          controller: scrollController,
                          padding: padding ??
                              EdgeInsets.all(
                                  Flu.appSettings.defaultPaddingSize),
                          child: child),
                    ),
                  ),
                ],
              );
            }),
      );
}
