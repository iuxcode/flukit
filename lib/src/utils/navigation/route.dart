import 'package:flukit/nav.dart';
import 'package:flukit/src/ui/screens/not_found.dart';
import 'package:flukit/src/utils/navigation/transitions_builders/defaults.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Default navigation page transition
const PageTransitions fluDefaultPageTransition = PageTransitions.noTransition;

/// Default navigation page transition curve
const Curve fluDefaultTransitionCurve = Curves.easeOutQuad;

/// Default navigation page transition duration
const Duration fluDefaultTransitionDuration = Duration(milliseconds: 300);

/// A modal route that replaces the entire screen.
class FluPageRoute<T> extends PageRoute<T> {
  // ignore: public_member_api_docs
  FluPageRoute({
    required this.page,
    super.settings,
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

  /// An parametric animation easing curve,
  /// i.e. a mapping of the unit interval to the unit interval.
  final Curve transitionCurve;

  /// The [Widget] to navigate to.
  final Widget page;

  /// navigation transition
  final PageTransitions transition;

  ///
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
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final Widget result = Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: page,
    );

    return result;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      buildPageTransitions<T>(
        this,
        context,
        animation,
        secondaryAnimation,
        child,
      );

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';

  ///
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
    // ignore: parameter_assignments
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
      case PageTransitions.cupertinoDialog:
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

/// Builds the default `404` route.
FluPageRoute<dynamic> buildUnknownRoute(
  FluPage<dynamic>? route,
  String? exceptedRouteName,
) =>
    route?.toRoute() ??
    FluPage<dynamic>(
      name: '/404',
      page: Flu404(exceptedRouteName ?? 'Unknown.'),
    ).toRoute();
