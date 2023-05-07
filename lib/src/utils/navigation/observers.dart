import 'dart:developer' as dev;

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class FluNavObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    dev.log(
        "CLOSE TO ROUTE ${previousRoute?.settings.name} with args: ${previousRoute?.settings.arguments}");
    Flu.routeArgs = previousRoute?.settings.arguments;
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    dev.log(
        "GOING TO ROUTE ${route.settings.name} with args: ${route.settings.arguments}");
    Flu.routeArgs = route.settings.arguments;
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    Flu.routeArgs = newRoute?.settings.arguments;
    dev.log(
        "GOING TO ROUTE ${newRoute?.settings.name} with args: ${newRoute?.settings.arguments}");
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    dev.log("REMOVING ROUTE ${route.settings.name}");
    super.didRemove(route, previousRoute);
  }
}
