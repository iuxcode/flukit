import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'default_route.dart';
import '../../flu_nav.dart';
import 'transitions/custom_transition.dart';

const Duration _defaultTransitionDuration = Duration(milliseconds: 300);
const Curve _defaultTransitionCurve = Curves.easeOutQuad;

class FluPage<T> extends Page<T> {
  final FluPageBuilder page;
  final bool? popGesture;
  final Map<String, String>? parameters;
  final String? title;
  final Transition? transition;
  final Curve curve;
  final bool? participatesInRootNavigator;
  final Alignment? alignment;
  final bool maintainState;
  final bool opaque;
  final double Function(BuildContext context)? gestureWidth;
  final CustomTransition? customTransition;
  final Duration? transitionDuration;
  final bool fullscreenDialog;
  final bool preventDuplicates;

  final List<FluPage> children;
  final PathDecoded path;
  final FluPage? unknownRoute;
  final bool showCupertinoParallax;

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
  })  : path = nameToRegex(name!),
        assert(name.startsWith('/'),
            'It is necessary to start route name [$name] with a slash: /$name'),
        super(key: ValueKey(name));
  // settings = RouteSettings(name: name, arguments: Get.arguments);

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

  @override
  Route<T> createRoute(BuildContext context) {
    // return FluPageRoute<T>(settings: this, page: page);
    return FluPageRoute<T>(
      page: page,
      parameter: parameters,
      settings: this,
      curve: curve,
      opaque: opaque,
      showCupertinoParallax: showCupertinoParallax,
      gestureWidth: gestureWidth,
      customTransition: customTransition,
      transitionDuration: transitionDuration ?? _defaultTransitionDuration,
      transition: transition,
      popGesture: popGesture,
      fullscreenDialog: fullscreenDialog,
    );
  }

  static PathDecoded nameToRegex(String path) {
    var keys = <String?>[];

    String replace(Match pattern) {
      var buffer = StringBuffer('(?:');

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
  final RegExp regex;
  final List<String?> keys;
  const PathDecoded(this.regex, this.keys);

  @override
  int get hashCode => regex.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PathDecoded &&
        other.regex == regex; // && listEquals(other.keys, keys);
  }
}
