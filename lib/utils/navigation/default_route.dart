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

  @override
  final Duration transitionDuration;
  final FluPageBuilder page;
  final String? routeName;
  //final String reference;
  final CustomTransition? customTransition;
  final Map<String, String>? parameter;

  @override
  final bool showCupertinoParallax;

  @override
  final bool opaque;
  final bool? popGesture;

  @override
  final bool barrierDismissible;
  final Transition? transition;
  final Curve? curve;
  final Alignment? alignment;

  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildContent(BuildContext context) {
    return page();
  }

  @override
  final String? title;

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';

  @override
  final double Function(BuildContext context)? gestureWidth;
}
