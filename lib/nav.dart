import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

export 'src/utils/navigation/observers.dart';
export 'src/utils/navigation/page.dart';
export 'src/utils/navigation/route.dart';
export 'src/utils/navigation/transitions.dart';

extension NavExt on FluInterface {
  Exception get _unmountedKeyException => Exception(
        // ignore: lines_longer_than_80_chars, lines_longer_than_80_chars
        "'The [navigatorKey] has not been mounted. Use `FluMaterialApp` or set the key manually with `Flu.navigatorKey = yourKey`'",
      );

  bool _keyIsMounted() =>
      navigatorKey.currentState != null && navigatorKey.currentState!.mounted;

  /// **Navigator.push()** shortcut.<br>
  ///
  /// Pushes a new `page` to the stack
  ///
  /// It has the advantage of not needing context,
  /// so you can call from your business logic
  ///
  /// You can set a custom [PageTransitions], and a [transitionDuration].
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// Just like native routing in Flutter, you can push a route
  /// as a [fullscreenDialog]
  Future<T?>? to<T>(
    Widget page, {
    bool? opaque,
    PageTransitions? transition,
    Curve? transitionCurve,
    Duration? transitionDuration,
    String? routeName,
    bool fullscreenDialog = false,
    // ignore: inference_failure_on_untyped_parameter, type_annotate_public_apis
    arguments,
  }) {
    if (_keyIsMounted()) {
      // var routeName = "/${page.runtimeType}";
      routeName ??= '/${page.runtimeType}';

      return navigatorKey.currentState?.push<T>(
        FluPageRoute<T>(
          opaque: opaque ?? true,
          page: page,
          settings: RouteSettings(
            name: cleanRouteName(routeName),
            arguments: arguments,
          ),
          transition: transition ?? fluDefaultPageTransition,
          transitionCurve: transitionCurve ?? fluDefaultTransitionCurve,
          transitionDuration:
              transitionDuration ?? fluDefaultTransitionDuration,
          fullscreenDialog: fullscreenDialog,
        ),
      );
    } else {
      throw _unmountedKeyException;
    }
  }

  /// **Navigation.pushNamed()** shortcut.<br>
  ///
  /// Pushes a new named `page` to the stack.
  ///
  /// It has the advantage of not needing context, so you can call
  /// from your business logic.
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// Note: Always put a slash on the route ('/page1'), to avoid unexpected errors
  Future<T?>? toNamed<T>(
    String page, {
    // ignore: inference_failure_on_untyped_parameter, type_annotate_public_apis
    arguments,
  }) {
    if (_keyIsMounted()) {
      return navigatorKey.currentState?.pushNamed<T>(
        cleanRouteName(page),
        arguments: arguments,
      );
    } else {
      throw _unmountedKeyException;
    }
  }

  /// **Navigation.pushReplacementNamed()** shortcut.<br>
  ///
  /// Pop the current named `page` in the stack and push a new one in its place
  ///
  /// It has the advantage of not needing context, so you can call
  /// from your business logic.
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// Note: Always put a slash on the route ('/page1'), to avoid unexpected errors
  Future<T?>? offNamed<T>(
    String page, {
    // ignore: inference_failure_on_untyped_parameter, type_annotate_public_apis
    arguments,
  }) {
    if (_keyIsMounted()) {
      return navigatorKey.currentState?.pushReplacementNamed(
        cleanRouteName(page),
        arguments: arguments,
      );
    } else {
      throw _unmountedKeyException;
    }
  }

  /// **Navigation.popUntil()** shortcut.<br>
  ///
  /// Calls pop several times in the stack until [predicate] returns true
  ///
  /// [predicate] can be used like this:
  /// `Flu.until((route) => Flu.currentRoute == '/home')`so when you get to home page,
  /// Todo: Make this predicate available
  void until(RoutePredicate predicate, {int? id}) {
    if (_keyIsMounted()) {
      return navigatorKey.currentState?.popUntil(predicate);
    } else {
      throw _unmountedKeyException;
    }
  }

  /// **Navigation.pushAndRemoveUntil()** shortcut.<br>
  ///
  /// Push the given `page`, and then pop several pages in the stack until
  /// [predicate] returns true
  ///
  /// Obs: unlike other [Flu] methods, this one you need to send a function
  /// that returns the widget to the page argument, like this:
  /// Flu.offUntil(FluPageRoute(page: () => HomePage()), predicate)
  ///
  /// [predicate] can be used like this:
  /// `Flu.offUntil(page, (route) => (route as FluPageRoute).routeName == '/home')`
  /// to pop routes in stack until home.
  Future<T?>? offUntil<T>(Route<T> page, RoutePredicate predicate, {int? id}) {
    if (_keyIsMounted()) {
      return navigatorKey.currentState?.pushAndRemoveUntil<T>(page, predicate);
    } else {
      throw _unmountedKeyException;
    }
  }

  /// **Navigation.pushNamedAndRemoveUntil()** shortcut.<br><br>
  ///
  /// Push the given named `page`, and then pop several pages in the stack
  /// until [predicate] returns true
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// [predicate] can be used like this:
  /// `Flu.offNamedUntil(page, ModalRoute.withName('/home'))`
  /// to pop routes in stack until home.
  /// Note: Always put a slash on the route name ('/page1'), to avoid unexpected errors
  Future<T?>? offNamedUntil<T>(
    String page,
    RoutePredicate predicate, {
    // ignore: inference_failure_on_untyped_parameter, type_annotate_public_apis
    arguments,
  }) {
    if (_keyIsMounted()) {
      return navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
        cleanRouteName(page),
        predicate,
        arguments: arguments,
      );
    } else {
      throw _unmountedKeyException;
    }
  }

  /// **Navigation.popAndPushNamed()** shortcut.<br><br>
  ///
  /// Pop the current named page and pushes a new `page` to the stack
  /// in its place
  ///
  /// You can send any type of value to the other route in the [arguments].
  /// It is very similar to `offNamed()` but use a different approach
  ///
  /// The `offNamed()` pop a page, and goes to the next. The
  /// `offAndToNamed()` goes to the next page, and removes the previous one.
  /// The route transition animation is different.
  Future<T?>? offAndToNamed<T>(
    String page, {
    // ignore: inference_failure_on_untyped_parameter, type_annotate_public_apis
    arguments,
    // ignore: inference_failure_on_untyped_parameter, type_annotate_public_apis
    result,
  }) {
    if (_keyIsMounted()) {
      return navigatorKey.currentState?.popAndPushNamed(
        cleanRouteName(page),
        arguments: arguments,
        result: result,
      );
    } else {
      throw _unmountedKeyException;
    }
  }

  /// **Navigation.removeRoute()** shortcut.<br>
  ///
  /// Remove a specific [route] from the stack
  void removeRoute(Route<dynamic> route, {int? id}) {
    if (_keyIsMounted()) {
      return navigatorKey.currentState?.removeRoute(route);
    } else {
      throw _unmountedKeyException;
    }
  }

  /// **Navigation.pushNamedAndRemoveUntil()** shortcut.<br><br>
  ///
  /// Push a named `page` and pop several pages in the stack
  /// until [predicate] returns true. [predicate] is optional
  ///
  /// It has the advantage of not needing context, so you can
  /// call from your business logic.
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// [predicate] can be used like this:
  /// `Flu.until((route) => Flu.currentRoute == '/home')`so when you get to home page
  ///
  /// Note: Always put a slash on the route ('/page1'), to avoid unexpected errors
  Future<T?>? offAllNamed<T>(
    String newRouteName, {
    RoutePredicate? predicate,
    // ignore: inference_failure_on_untyped_parameter, type_annotate_public_apis
    arguments,
  }) {
    if (_keyIsMounted()) {
      return navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
        cleanRouteName(newRouteName),
        predicate ?? (_) => false,
        arguments: arguments,
      );
    } else {
      throw _unmountedKeyException;
    }
  }

  /// **Navigation.popUntil()** shortcut.<br>
  ///
  /// Pop the current page, snackbar, dialog or bottomsheet in the stack
  ///
  /// It has the advantage of not needing context, so you can call
  /// from your business logic.
  void back<T>({
    T? result,
    bool canPop = true,
  }) {
    if (_keyIsMounted()) {
      if (canPop) {
        if (navigatorKey.currentState != null &&
            navigatorKey.currentState!.canPop()) {
          navigatorKey.currentState?.pop<T>(result);
        }
      } else {
        navigatorKey.currentState?.pop<T>(result);
      }
    } else {
      throw _unmountedKeyException;
    }
  }

  /// **Navigation.popUntil()** (with predicate) shortcut .<br>
  ///
  /// Close as many routes as defined by [times]
  void close(int times, [int? id]) {
    if (_keyIsMounted()) {
      if (times < 1) {
        // ignore: parameter_assignments
        times = 1;
      }
      var count = 0;
      final back =
          navigatorKey.currentState?.popUntil((route) => count++ == times);

      return back;
    } else {
      throw _unmountedKeyException;
    }
  }

  /// **Navigation.pushReplacement()** shortcut .<br>
  ///
  /// Pop the current page and pushes a new `page` to the stack
  ///
  /// It has the advantage of not needing context,
  /// so you can call from your business logic
  ///
  /// You can set a custom [PageTransitions], define a Tween [transitionCurve],
  /// and a [transitionDuration].
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// Just like native routing in Flutter, you can push a route
  /// as a [fullscreenDialog]
  Future<T?>? off<T>(
    Widget page, {
    bool opaque = false,
    PageTransitions? transition,
    Curve? transitionCurve,
    String? routeName,
    // ignore: inference_failure_on_untyped_parameter, type_annotate_public_apis
    arguments,
    bool fullscreenDialog = false,
    Duration? transitionDuration,
  }) {
    if (_keyIsMounted()) {
      routeName ??= '/${page.runtimeType}';

      return navigatorKey.currentState?.pushReplacement(
        FluPageRoute(
          opaque: opaque,
          page: page,
          settings: RouteSettings(
            arguments: arguments,
            name: cleanRouteName(routeName),
          ),
          fullscreenDialog: fullscreenDialog,
          transition: transition ?? fluDefaultPageTransition,
          transitionCurve: transitionCurve ?? fluDefaultTransitionCurve,
          transitionDuration:
              transitionDuration ?? fluDefaultTransitionDuration,
        ),
      );
    } else {
      throw _unmountedKeyException;
    }
  }

  ///
  /// Push a `page` and pop several pages in the stack
  /// until [predicate] returns true. [predicate] is optional
  ///
  /// It has the advantage of not needing context,
  /// so you can call from your business logic
  ///
  /// You can set a custom [PageTransitions],
  /// a [transitionCurve] and a [transitionDuration].
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// Just like native routing in Flutter, you can push a route
  /// as a [fullscreenDialog],
  ///
  /// [predicate] can be used like this:
  /// `Flu.until((route) => Flu.currentRoute == '/home')`so when you get to home page.
  Future<T?>? offAll<T>(
    Widget page, {
    RoutePredicate? predicate,
    bool opaque = false,
    String? routeName,
    // ignore: inference_failure_on_untyped_parameter, type_annotate_public_apis
    arguments,
    bool fullscreenDialog = false,
    PageTransitions? transition,
    Curve? transitionCurve,
    Duration? transitionDuration,
  }) {
    if (_keyIsMounted()) {
      routeName ??= '/${page.runtimeType}';

      return navigatorKey.currentState?.pushAndRemoveUntil<T>(
        FluPageRoute<T>(
          opaque: opaque,
          page: page,
          settings: RouteSettings(
            name: cleanRouteName(routeName),
            arguments: arguments,
          ),
          fullscreenDialog: fullscreenDialog,
          transition: transition ?? fluDefaultPageTransition,
          transitionCurve: transitionCurve ?? fluDefaultTransitionCurve,
          transitionDuration:
              transitionDuration ?? fluDefaultTransitionDuration,
        ),
        predicate ?? (route) => false,
      );
    } else {
      throw _unmountedKeyException;
    }
  }

  /// Takes a route [name] String generated by [to], [off], [offAll]
  /// (and similar context navigation methods), cleans the extra chars and
  /// accommodates the format.
  /// TODO: check for a more "appealing" URL naming convention.
  /// `() => MyHomeScreenView` becomes `/my-home-screen-view`.
  String cleanRouteName(String name) {
    // ignore: parameter_assignments
    name = name.replaceAll('() => ', '');

    /// uncommonest for URL styling.
    // name = name.paramCase!;
    if (!name.startsWith('/')) {
      // ignore: parameter_assignments
      name = '/$name';
    }
    return Uri.tryParse(name)?.toString() ?? name;
  }

  /// give access to FocusScope.of(context)
  FocusNode? get focusScope => FocusManager.instance.primaryFocus;
}
