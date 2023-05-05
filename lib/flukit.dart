library flukit;

import 'package:flutter/widgets.dart';

import 'flu_utils.dart';

export 'package:geolocator/geolocator.dart' show Position, LocationPermission;
export 'package:flukit_icons/flukit_icons.dart';
export 'flu_utils.dart';
export 'flu_widgets.dart';
export 'screens/flu_screens.dart';
export 'services/flu_services.dart';

GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

extension MainExt on FluInterface {
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}
