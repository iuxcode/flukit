import 'dart:developer' as dev;

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

/// An interface for observing the behavior of a [Navigator].
class FluNavObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    dev.log(
      // ignore: lines_longer_than_80_chars
      'CLOSE TO ROUTE ${previousRoute?.settings.name} with args: ${previousRoute?.settings.arguments}',
    );
    Flu.routeArgs = previousRoute?.settings.arguments;
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    dev.log(
      // ignore: lines_longer_than_80_chars
      'GOING TO ROUTE ${route.settings.name} with args: ${route.settings.arguments}',
    );
    Flu.routeArgs = route.settings.arguments;
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    Flu.routeArgs = newRoute?.settings.arguments;
    dev.log(
      // ignore: lines_longer_than_80_chars
      'GOING TO ROUTE ${newRoute?.settings.name} with args: ${newRoute?.settings.arguments}',
    );
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    dev.log('REMOVING ROUTE ${route.settings.name}');
    super.didRemove(route, previousRoute);
  }
}
