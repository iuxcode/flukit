import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FluPage<T> extends Page<T> {
  FluPage({
    required super.name,
    required this.page,
    this.participatesInRootNavigator,
    this.maintainState = true,
    this.transitionCurve = fluDefaultTransitionCurve,
    this.alignment,
    this.opaque = true,
    this.transitionDuration = fluDefaultTransitionDuration,
    this.transition = fluDefaultPageTransition,
    this.fullscreenDialog = false,
    super.arguments,
  })  : assert(name!.startsWith('/'),
            'It is necessary to start route name [$name] with a slash: /$name'),
        super(key: ValueKey(name));

  final Alignment? alignment;
  final bool fullscreenDialog;
  final bool maintainState;
  final bool opaque;
  final Widget Function() page;
  final bool? participatesInRootNavigator;
  final PageTransitions transition;
  final Duration transitionDuration;
  final Curve transitionCurve;

  @override
  Route<T> createRoute(BuildContext context) => toRoute();

  FluPageRoute<T> toRoute() => FluPageRoute<T>(
        page: page,
        alignment: alignment,
        maintainState: maintainState,
        settings: RouteSettings(
          name: name,
          arguments: arguments,
        ),
        opaque: opaque,
        transitionDuration: transitionDuration,
        transition: transition,
        transitionCurve: transitionCurve,
        fullscreenDialog: fullscreenDialog,
      );
}
