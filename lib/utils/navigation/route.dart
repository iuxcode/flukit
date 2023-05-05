import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'transitions/custom_transition.dart';

class FluPage<T> extends Page<T> {
  FluPage({
    required super.name,
    required this.page,
    this.title,
    this.participatesInRootNavigator,
    this.gestureWidth,
    // RouteSettings settings,
    this.maintainState = true,
    this.curve = Curves.linear,
    this.alignment,
    this.parameters,
    this.opaque = true,
    this.transitionDuration,
    this.popGesture,
    this.transition,
    this.customTransition,
    this.fullscreenDialog = false,
    this.children = const <FluPage>[],
    this.unknownRoute,
    super.arguments,
    this.showCupertinoParallax = true,
    this.preventDuplicates = true,
  })  : path = generatePath(name!),
        pathDecoded = nameToRegex(name),
        assert(name.startsWith('/'),
            'It is necessary to start route name [$name] with a slash: /$name'),
        super(key: ValueKey(name));

  final double Function(BuildContext context)? gestureWidth;
  final Alignment? alignment;
  final List<FluPage> children;
  final Curve curve;
  final CustomTransition? customTransition;
  final bool fullscreenDialog;
  final bool maintainState;
  final bool opaque;
  final FluPageBuilder page;
  final Map<String, String>? parameters;
  final bool? participatesInRootNavigator;
  final PathDecoded pathDecoded;
  final String path;
  final bool? popGesture;
  final bool preventDuplicates;
  final bool showCupertinoParallax;
  final String? title;
  final Transition? transition;
  final Duration? transitionDuration;
  final FluPage? unknownRoute;

  @override
  Route<T> createRoute(BuildContext context) {
    /// return FluPageRoute<T>(settings: this, page: page);
    return PageRedirect(
      route: this,
      settings: this,
      unknownRoute: unknownRoute,
    ).fluPageToRoute<T>(this, unknownRoute);
  }

  /// settings = RouteSettings(name: name, arguments: Get.arguments);
  FluPage<T> copy({
    String? name,
    FluPageBuilder? page,
    bool? popGesture,
    Map<String, String>? parameters,
    String? title,
    Transition? transition,
    Curve? curve,
    Alignment? alignment,
    bool? maintainState,
    bool? opaque,
    CustomTransition? customTransition,
    Duration? transitionDuration,
    bool? fullscreenDialog,
    RouteSettings? settings,
    List<FluPage>? children,
    FluPage? unknownRoute,
    bool? preventDuplicates,
    final double Function(BuildContext context)? gestureWidth,
    bool? participatesInRootNavigator,
    Object? arguments,
    bool? showCupertinoParallax,
  }) {
    return FluPage(
      participatesInRootNavigator:
          participatesInRootNavigator ?? this.participatesInRootNavigator,
      preventDuplicates: preventDuplicates ?? this.preventDuplicates,
      name: name ?? this.name,
      page: page ?? this.page,
      popGesture: popGesture ?? this.popGesture,
      parameters: parameters ?? this.parameters,
      title: title ?? this.title,
      transition: transition ?? this.transition,
      curve: curve ?? this.curve,
      alignment: alignment ?? this.alignment,
      maintainState: maintainState ?? this.maintainState,
      opaque: opaque ?? this.opaque,
      customTransition: customTransition ?? this.customTransition,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      fullscreenDialog: fullscreenDialog ?? this.fullscreenDialog,
      children: children ?? this.children,
      unknownRoute: unknownRoute ?? this.unknownRoute,
      gestureWidth: gestureWidth ?? this.gestureWidth,
      arguments: arguments ?? this.arguments,
      showCupertinoParallax:
          showCupertinoParallax ?? this.showCupertinoParallax,
    );
  }

  static String generatePath(String path) => nameToRegex(path).regex.pattern;

  static PathDecoded nameToRegex(String path) {
    var keys = <String?>[];

    String replace(Match pattern) {
      var buffer = StringBuffer('(?:');

      // ignore: unnecessary_string_escapes
      if (pattern[1] != null) buffer.write('\.');
      buffer.write('([\\w%+-._~!\$&\'()*,;=:@]+))');
      if (pattern[3] != null) buffer.write('?');

      keys.add(pattern[2]);
      return "$buffer";
    }

    var stringPath = '$path/?'
        .replaceAllMapped(RegExp(r'(\.)?:(\w+)(\?)?'), replace)
        .replaceAll('//', '/');

    return PathDecoded(RegExp('^$stringPath\$'), keys);
  }
}

@immutable
class PathDecoded {
  const PathDecoded(this.regex, this.keys);

  final List<String?> keys;
  final RegExp regex;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PathDecoded &&
        other.regex == regex; // && listEquals(other.keys, keys);
  }

  @override
  int get hashCode => regex.hashCode;
}

class PageRedirect {
  FluPage? route;
  FluPage? unknownRoute;
  RouteSettings? settings;
  bool isUnknown;

  PageRedirect({
    this.route,
    this.unknownRoute,
    this.isUnknown = false,
    this.settings,
  });

  /// redirect all pages that needs redirecting
  FluPageRoute<T> page<T>() {
    final r = (isUnknown ? unknownRoute : route)!;
    return FluPageRoute<T>(
      page: r.page,
      parameter: r.parameters,
      settings: isUnknown
          ? RouteSettings(
              name: r.name,
              arguments: settings!.arguments,
            )
          : settings,
      curve: r.curve,
      opaque: r.opaque,
      showCupertinoParallax: r.showCupertinoParallax,
      gestureWidth: r.gestureWidth,
      customTransition: r.customTransition,
      transitionDuration: r.transitionDuration ?? Flu.defaultTransitionDuration,
      transition: r.transition,
      popGesture: r.popGesture,
      fullscreenDialog: r.fullscreenDialog,
    );
  }

  FluPageRoute<T> fluPageToRoute<T>(FluPage rou, FluPage? unk) {
    final r = (isUnknown ? unk : rou)!;

    return FluPageRoute<T>(
      page: r.page,
      parameter: r.parameters,
      alignment: r.alignment,
      title: r.title,
      maintainState: r.maintainState,
      routeName: r.name,
      settings: r,
      curve: r.curve,
      showCupertinoParallax: r.showCupertinoParallax,
      gestureWidth: r.gestureWidth,
      opaque: r.opaque,
      customTransition: r.customTransition,
      transitionDuration: r.transitionDuration ?? Flu.defaultTransitionDuration,
      transition: r.transition,
      popGesture: r.popGesture,
      fullscreenDialog: r.fullscreenDialog,
    );
  }
}
