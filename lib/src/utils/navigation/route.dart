import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flukit/src/nav.dart';

import 'transitions_builders/defaults.dart';

const PageTransitions fluDefaultPageTransition = PageTransitions.rightToLeft;
const Curve fluDefaultTransitionCurve = Curves.easeOutQuad;
const Duration fluDefaultTransitionDuration = Duration(milliseconds: 300);

class FluPageRoute<T> extends PageRoute<T> {
  FluPageRoute({
    super.settings,
    required this.page,
    this.transitionDuration = fluDefaultTransitionDuration,
    this.transitionCurve = fluDefaultTransitionCurve,
    this.transition = fluDefaultPageTransition,
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
    super.fullscreenDialog,
    super.allowSnapshotting = true,
    this.alignment,
  });

  final Curve transitionCurve;
  final Widget Function() page;
  final PageTransitions transition;
  final Alignment? alignment;

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
  final Duration transitionDuration;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final Widget result = Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: page(),
    );

    return result;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      buildPageTransitions<T>(
          this, context, animation, secondaryAnimation, child);

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';

  static Widget buildPageTransitions<T>(
    PageRoute<T> rawRoute,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final route = rawRoute as FluPageRoute<T>;

    /// Apply the curve by default...
    final iosAnimation = animation;
    animation =
        CurvedAnimation(parent: animation, curve: route.transitionCurve);

    switch (route.transition) {
      case PageTransitions.leftToRight:
        return SlideLeftTransition().buildTransitions(
          context,
          route.transitionCurve,
          route.alignment,
          animation,
          secondaryAnimation,
          child,
        );

      case PageTransitions.downToUp:
        return SlideDownTransition().buildTransitions(
          context,
          route.transitionCurve,
          route.alignment,
          animation,
          secondaryAnimation,
          child,
        );

      case PageTransitions.upToDown:
        return SlideTopTransition().buildTransitions(
          context,
          route.transitionCurve,
          route.alignment,
          animation,
          secondaryAnimation,
          child,
        );

      case PageTransitions.noTransition:
        return child;

      case PageTransitions.rightToLeft:
        return SlideRightTransition().buildTransitions(
          context,
          route.transitionCurve,
          route.alignment,
          animation,
          secondaryAnimation,
          child,
        );

      case PageTransitions.zoom:
        return ZoomInTransition().buildTransitions(
          context,
          route.transitionCurve,
          route.alignment,
          animation,
          secondaryAnimation,
          child,
        );

      case PageTransitions.fadeIn:
        return FadeInTransition().buildTransitions(
          context,
          route.transitionCurve,
          route.alignment,
          animation,
          secondaryAnimation,
          child,
        );

      case PageTransitions.rightToLeftWithFade:
        return RightToLeftFadeTransition().buildTransitions(
          context,
          route.transitionCurve,
          route.alignment,
          animation,
          secondaryAnimation,
          child,
        );

      case PageTransitions.leftToRightWithFade:
        return LeftToRightFadeTransition().buildTransitions(
          context,
          route.transitionCurve,
          route.alignment,
          animation,
          secondaryAnimation,
          child,
        );

      case PageTransitions.cupertino:
        return CupertinoPageTransition(
          primaryRouteAnimation: animation,
          secondaryRouteAnimation: secondaryAnimation,
          linearTransition: true,
          child: child,
        );

      case PageTransitions.size:
        return SizeTransitions().buildTransitions(
          context,
          route.transitionCurve,
          route.alignment,
          animation,
          secondaryAnimation,
          child,
        );

      case PageTransitions.fade:
        return const FadeUpwardsPageTransitionsBuilder().buildTransitions(
          route,
          context,
          animation,
          secondaryAnimation,
          child,
        );

      case PageTransitions.topLevel:
        return const ZoomPageTransitionsBuilder().buildTransitions(
          route,
          context,
          animation,
          secondaryAnimation,
          child,
        );

      case PageTransitions.native:
        return const PageTransitionsTheme().buildTransitions(
          route,
          context,
          iosAnimation,
          secondaryAnimation,
          child,
        );

      case PageTransitions.circularReveal:
        return CircularRevealTransition().buildTransitions(
          context,
          route.transitionCurve,
          route.alignment,
          animation,
          secondaryAnimation,
          child,
        );

      default:
        return const PageTransitionsTheme().buildTransitions(
          route,
          context,
          iosAnimation,
          secondaryAnimation,
          child,
        );
    }
  }
}
