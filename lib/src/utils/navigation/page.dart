import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FluPage<T> extends Page<T> {
  FluPage({
    required String name,
    required this.page,
    this.participatesInRootNavigator,
    this.initial = false,
    this.maintainState = true,
    this.transitionCurve = fluDefaultTransitionCurve,
    this.alignment,
    this.opaque = true,
    this.transitionDuration = fluDefaultTransitionDuration,
    this.transition = fluDefaultPageTransition,
    this.fullscreenDialog = false,
    super.arguments,
  }) : super(key: ValueKey(name), name: Flu.cleanRouteName(name));

  final Alignment? alignment;
  final bool fullscreenDialog;
  final bool maintainState;
  final bool opaque;
  final Widget Function() page;
  final bool? participatesInRootNavigator;
  final PageTransitions transition;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final bool initial;

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

  FluPage<T> copyWith({
    String? name,
    Widget Function()? page,
    PageTransitions? transition,
    Curve? transitionCurve,
    Alignment? alignment,
    bool? maintainState,
    bool? opaque,
    Duration? transitionDuration,
    bool? fullscreenDialog,
    RouteSettings? settings,
    bool? participatesInRootNavigator,
    Object? arguments,
  }) {
    return FluPage(
      participatesInRootNavigator:
          participatesInRootNavigator ?? this.participatesInRootNavigator,
      name: name ?? this.name!,
      page: page ?? this.page,
      transition: transition ?? this.transition,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      alignment: alignment ?? this.alignment,
      maintainState: maintainState ?? this.maintainState,
      opaque: opaque ?? this.opaque,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      fullscreenDialog: fullscreenDialog ?? this.fullscreenDialog,
      arguments: arguments ?? this.arguments,
    );
  }
}
