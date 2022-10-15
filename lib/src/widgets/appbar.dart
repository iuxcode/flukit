import 'package:flukit/src/models/appbar.dart';
import 'package:flukit/src/utils/flu_utils.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

import 'glass.dart';
import 'texts.dart';

class FluAppBar extends StatelessWidget {
  final bool floating;
  final Duration animationDuration;
  final Curve animationCurve;
  final double? blurIntensity, backgroundOpacity;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final String title;
  final Widget? leading;
  final List<AppbarAction> actions;
  final Widget? child;
  final TextStyle? textStyle;

  const FluAppBar({
    Key? key,
    this.floating = false,
    this.animationDuration = const Duration(milliseconds: 350),
    this.animationCurve = Curves.fastOutSlowIn,
    this.backgroundOpacity,
    this.blurIntensity,
    this.backgroundColor,
    this.padding,
    this.title = 'flukit',
    this.leading,
    this.actions = const [
      AppbarAction(icon: FluIcons.search),
      AppbarAction(icon: FluIcons.more),
    ],
    this.child,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FluGlass(
        intensity: blurIntensity ?? (floating ? 10.0 : 2.0),
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        child: AnimatedContainer(
          duration: animationDuration,
          curve: animationCurve,
          padding: EdgeInsets.symmetric(
            horizontal: (padding?.left ?? Flukit.appSettings.defaultPaddingSize) +
                (floating ? 8 : 0),
          ).copyWith(top: Flukit.statusBarHeight),
          decoration: BoxDecoration(
            color: (backgroundColor ?? Flukit.theme().background)
                .withOpacity(backgroundOpacity ?? .5),
          ),
          child: SizedBox(
            height: Flukit.appSettings.defaultAppBarSize,
            child: child ??
                Row(
                  children: [
                    if (leading != null) leading!,
                    AnimatedPadding(
                        padding: EdgeInsets.only(left: leading != null ? 6 : 0),
                        duration: animationDuration,
                        curve: animationCurve,
                        child: FluText(
                          text: title,
                          stylePreset: FluTextStyle.headlineBold,
                          style: textStyle,
                        )),
                    const Spacer(),
                    ...AppbarAction.build(actions),
                  ],
                ),
          ),
        ),
      );
}
