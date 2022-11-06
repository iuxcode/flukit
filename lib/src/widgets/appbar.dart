import 'package:flukit/src/models/appbar.dart';
import 'package:flukit/src/utils/flu_utils.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

import 'glass.dart';
import 'texts.dart';

class FluAppbar extends StatelessWidget {
  const FluAppbar({
    Key? key,
    this.floating = false,
    this.animationDuration = const Duration(milliseconds: 350),
    this.animationCurve = Curves.fastOutSlowIn,
    this.backgroundOpacity,
    this.blurIntensity,
    this.backgroundColor,
    this.padding,
    this.title = 'Flukit',
    this.titleTextEntities,
    this.leading,
    this.actions = const [
      FluAppbarAction(icon: FluIcons.search),
      FluAppbarAction(icon: FluIcons.more),
    ],
    this.child,
    this.titleStyle,
    this.shrinkOnFloating = true,
  }) : super(key: key);

  final List<FluAppbarAction> actions;
  final Curve animationCurve;
  final Duration animationDuration;
  final Color? backgroundColor;
  final double? blurIntensity, backgroundOpacity;
  final Widget? child;
  final bool floating;
  final Widget? leading;
  final EdgeInsets? padding;
  final bool shrinkOnFloating;
  final String title;
  final TextStyle? titleStyle;
  final List<TextSpan>? titleTextEntities;

  @override
  Widget build(BuildContext context) => FluGlass(
        intensity: blurIntensity ?? (floating ? 10.0 : 2.0),
        child: AnimatedContainer(
          duration: animationDuration,
          curve: animationCurve,
          padding: EdgeInsets.symmetric(
                  horizontal:
                      (padding?.left ?? Flu.appSettings.defaultPaddingSize) +
                          (floating && shrinkOnFloating ? 8 : 0))
              .copyWith(top: Flu.statusBarHeight),
          decoration: BoxDecoration(
              color: (backgroundColor ?? Flu.theme().background)
                  .withOpacity(backgroundOpacity ?? .5)),
          child: SizedBox(
            height: Flu.appSettings.defaultAppBarSize,
            child: child ??
                Row(
                  children: [
                    if (leading != null) leading!,
                    AnimatedPadding(
                        padding: EdgeInsets.only(left: leading != null ? 6 : 0),
                        duration: animationDuration,
                        curve: animationCurve,
                        child: FluText(
                          text: titleTextEntities == null ? title : null,
                          entities: titleTextEntities,
                          stylePreset: FluTextStyle.headlineBold,
                          style: titleStyle,
                        )),
                    const Spacer(),
                    ...FluAppbarAction.build(
                      actions,
                      spaceBetween: 15,
                    ),
                  ],
                ),
          ),
        ),
      );
}
