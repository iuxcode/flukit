import 'dart:async';

import 'package:flukit/flukit.dart';

extension ConnectivityExt on FluInterface {
  /// Check is the device has internet
  Future<bool> deviceIsOnline() async => throw UnimplementedError();

  /// Get the device connectivity state
  Future<void> getDeviceConnectivity() async => throw UnimplementedError();

  /// Listen to device connectivity changes
  StreamSubscription<void> listenToDeviceConnectivityChange() =>
      throw UnimplementedError();
}
