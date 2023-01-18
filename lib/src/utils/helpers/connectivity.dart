part of '../flu_utils.dart';

extension FluConnectivity on FluInterface {
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
