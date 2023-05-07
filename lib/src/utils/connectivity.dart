import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flukit/flukit.dart';

extension CT on FluInterface {
  Future<bool> deviceIsOnline() async {
    ConnectivityResult connectivityResult = await getDeviceConnectivity();
    bool status;

    switch (connectivityResult) {
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
      case ConnectivityResult.vpn:
        status = true;
        break;
      case ConnectivityResult.none:
      case ConnectivityResult.other:
        status = false;
        break;
    }

    return status;
  }

  Future<ConnectivityResult> getDeviceConnectivity() async =>
      await Connectivity().checkConnectivity();

  StreamSubscription<ConnectivityResult> listenToDeviceConnectivityChange(
    void Function(ConnectivityResult)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      Connectivity().onConnectivityChanged.listen(onData,
          onDone: onDone, onError: onError, cancelOnError: cancelOnError);
}
