import 'package:flutter/material.dart';
import '../../flukit.dart';

class FluModalBottomSheet extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? radius;
  final Duration animationDuration;
  final Curve  animationCurve;
  final double defaultRadius =  Flukit.screenSize.width * .085;

  FluModalBottomSheet({
    Key? key,
    required this.child,
    this.padding,
    this.radius,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    child: DraggableScrollableSheet(
      expand: false,
      maxChildSize: .9,
      builder: (BuildContext context, ScrollController scrollController) {
        return Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: GestureDetector(
              onTap: () => Navigator.pop(context),
            )),
            AnimatedContainer(
              height: 4,
              width: Flukit.screenSize.width * .20,
              margin: const EdgeInsets.only(bottom: 8),
              duration: animationDuration,
              curve: animationCurve,
              decoration: BoxDecoration(
                color: Flukit.theme.backgroundColor.withOpacity(.9),
                borderRadius: BorderRadius.circular(10)
              ),
            ),
            AnimatedContainer(
              width: double.infinity,
              duration: animationDuration,
              curve: animationCurve,
              decoration: BoxDecoration(
                color: Flukit.theme.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radius ?? defaultRadius),
                  topRight: Radius.circular(radius ?? defaultRadius)
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                padding: padding ?? EdgeInsets.all(FluConsts.defaultPaddingSize),
                child: child
              ),
            ),
          ],
        );
      }
    ),
  );
}