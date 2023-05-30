import 'dart:async';

import 'package:flukit/flukit.dart';

extension CT on FluInterface {
  Future<bool> deviceIsOnline() async => throw UnimplementedError();

  Future<void> getDeviceConnectivity() async => throw UnimplementedError();

  StreamSubscription<void> listenToDeviceConnectivityChange() =>
      throw UnimplementedError();
}
