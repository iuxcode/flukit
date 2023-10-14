library flukit;

import 'dart:developer' as dev;

import 'package:flutter/material.dart';

export 'nav.dart';
export 'package:flukit_icons/flukit_icons.dart';
export 'package:geolocator/geolocator.dart' show Position, LocationPermission;
export 'screens.dart';
export 'services.dart';
export 'utils.dart';
export 'widgets.dart';
export 'src/data/models/chip.model.dart';

typedef LogWriterCallback = void Function(String text, {bool isError});

/// FluInterface allows any auxiliary package to be merged into the "Flu"
/// class through extensions
abstract class FluInterface {
  late GlobalKey<NavigatorState> navigatorKey;
  dynamic routeArgs;

  /// default logger from GetX
  void defaultLogWriterCallback(String value, {bool isError = false}) {
    if (isError) dev.log(value, name: 'Flukit');
  }

  /// change default config of Flukit
  config() {}
}

class _FluImpl extends FluInterface {}

// ignore: non_constant_identifier_names
final FluInterface Flu = _FluImpl();
