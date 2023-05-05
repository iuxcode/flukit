import 'package:flukit/flu_nav.dart';
import 'package:flukit/utils/navigation/transition_mixin.dart';
import 'package:flutter/material.dart';

import 'transitions/custom_transition.dart';

/// Creates a page route for use in an iOS designed app.
///
/// The [builder], [maintainState], and [fullscreenDialog] arguments must not
/// be null.
class FluPageRoute<T> extends PageRoute<T> with FluPageRouteTransitionMixin<T> {
  FluPageRoute({
    RouteSettings? settings,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.parameter,
    this.gestureWidth,
    this.curve,
    this.alignment,
    this.transition,
    this.popGesture,
    this.customTransition,
    this.barrierDismissible = false,
    this.barrierColor,
    this.routeName,
    required this.page,
    this.title,
    this.showCupertinoParallax = true,
    this.barrierLabel,
    this.maintainState = true,
    bool fullscreenDialog = false,
  }) : super(settings: settings, fullscreenDialog: fullscreenDialog);

  final Alignment? alignment;
  final Curve? curve;
  final FluPageBuilder page;
  final Map<String, String>? parameter;
  final bool? popGesture;
  final String? routeName;
  final Transition? transition;

  //final String reference;
  final CustomTransition? customTransition;

  @override
  final Color? barrierColor;

  @override
  final bool barrierDismissible;

  @override
  final String? barrierLabel;

  @override
  final bool maintainState;

  @override
  final bool opaque;

  @override
  final bool showCupertinoParallax;

  @override
  final String? title;

  @override
  final Duration transitionDuration;

  @override
  final double Function(BuildContext context)? gestureWidth;

  @override
  Widget buildContent(BuildContext context) {
    return page();
  }

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';
}
