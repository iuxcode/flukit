import 'package:flutter/material.dart';

export 'package:flukit_icons/flukit_icons.dart';
// export 'package:geolocator/geolocator.dart' show LocationPermission, Position;

export 'nav.dart';
export 'screens.dart';
export 'services.dart';
export 'src/data/models/chip.model.dart';
export 'utils.dart';
export 'widgets.dart';

/// FluInterface allows any auxiliary package to be merged into the "Flu"
/// class through extensions
abstract class FluInterface {
  /// Unique global navigator key to perform context less operation
  late GlobalKey<NavigatorState> navigatorKey;

  /// Arguments passed to a [Route] when navigating.
  dynamic routeArgs;

  /// change default config of Flukit
  // config() {}
}

class _FluImpl extends FluInterface {}

/// Flukit interface.
// ignore: non_constant_identifier_names
final FluInterface Flu = _FluImpl();
