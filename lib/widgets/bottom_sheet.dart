import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/flu_utils.dart';

class FluModalBottomSheet extends StatelessWidget {
  const FluModalBottomSheet({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.cornerRadius,
    this.maxHeight,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  final Curve animationCurve;
  final Duration animationDuration;
  final Widget child;
  final double? cornerRadius;
  final double? maxHeight;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final Radius defaultCornerRadius =
        Radius.circular(cornerRadius ?? context.width * .05);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: context.colorScheme.background,
      ),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FluLine(
              height: 4,
              width: context.width * .22,
              radius: 5,
              color: context.colorScheme.background,
              margin: const EdgeInsets.only(bottom: 8),
            ),
            Flexible(
              child: Container(
                constraints:
                    BoxConstraints(maxHeight: maxHeight ?? double.infinity),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: defaultCornerRadius,
                    topRight: defaultCornerRadius,
                  ),
                  color: context.colorScheme.background,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: padding,
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
