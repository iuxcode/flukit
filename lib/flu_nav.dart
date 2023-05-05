import 'package:flutter/widgets.dart';

export 'utils/navigation/route.dart';
export 'utils/navigation/default_route.dart';

enum Transition {
  fade,
  fadeIn,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  rightToLeftWithFade,
  leftToRightWithFade,
  zoom,
  topLevel,
  noTransition,
  cupertino,
  cupertinoDialog,
  size,
  circularReveal,
  native,
}

typedef FluPageBuilder = Widget Function();
