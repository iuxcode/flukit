// TODO: resolve platform/desktop by JS browser agent.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flukit/utils.dart';

html.Navigator _navigator = html.window.navigator;

/// Determine on Which OS the web navigator is running
class GeneralPlatform {
  /// Whether the app is running in a web navigator
  bool get isWeb => true;

  /// Whether the operating system is a version of macOS.
  bool get isMacOS => _navigator.appVersion.contains('Mac OS') && !isIOS;

  /// Whether the operating system is a version of Windows.
  bool get isWindows => _navigator.appVersion.contains('Win');

  /// Whether the operating system is a version of Linux.
  bool get isLinux =>
      (_navigator.appVersion.contains('Linux') ||
          _navigator.appVersion.contains('x11')) &&
      !isAndroid;

  /// Whether the operating system is a version of Android.
  // Check https://developer.chrome.com/multidevice/user-agent
  bool get isAndroid => _navigator.appVersion.contains('Android ');

  /// Whether the operating system is a version of IOS.
  // maxTouchPoints is needed to separate iPad iOS13 vs new MacOS
  bool get isIOS =>
      FluUtils.hasMatch(_navigator.platform!, '/iPad|iPhone|iPod/') ||
      (_navigator.platform == 'MacIntel' && _navigator.maxTouchPoints! > 1);

  /// Whether the operating system is a version of Fuchsia.
  bool get isFuchsia => false;

  /// Whether the operating system is a desktop OS.
  bool get isDesktop => isMacOS || isWindows || isLinux;
}
