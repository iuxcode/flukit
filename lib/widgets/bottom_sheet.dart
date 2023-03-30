import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/flu_utils.dart';

class FluModalBottomSheet extends StatelessWidget {
  const FluModalBottomSheet({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.cornerRadius,
    this.maxChildSize = .85,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  final Curve animationCurve;
  final Duration animationDuration;
  final Widget child;
  final double? cornerRadius;
  final double maxChildSize;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final Radius defaultCornerRadius =
        Radius.circular(cornerRadius ?? context.width * .085);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light
          .copyWith(statusBarColor: Colors.transparent),
      child: /* Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
                child: GestureDetector(onTap: () => Navigator.pop(context))),
            Container(
              height: 4,
              width: Flu.screenWidth * .15,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(99)),
            ),
            Flexible(
                flex: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: defaultCornerRadius,
                          topRight: defaultCornerRadius)),
                  child: child,
                ))
          ],
        ), */
          DraggableScrollableSheet(
        expand: false,
        initialChildSize: .0,
        minChildSize: .0,
        maxChildSize: maxChildSize,
        builder: (context, scrollController) {
          return Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: defaultCornerRadius,
                topRight: defaultCornerRadius,
              ),
            ),
            child: SingleChildScrollView(
                controller: scrollController, child: child),
          );
        },
      ),
    );
  }
}
