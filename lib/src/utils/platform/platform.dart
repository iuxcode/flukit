import 'package:flukit/src/utils/platform/platform_web.dart'
    if (dart.library.io) 'platform_io.dart';

/// Determine on Which OS the app is running
class FluPlatform {
  /// Whether the app is running in a web navigator
  bool get isWeb => GeneralPlatform().isWeb;

  /// Whether the operating system is a version of macOS.
  bool get isMacOS => GeneralPlatform().isMacOS;

  /// Whether the operating system is a version of Windows.
  bool get isWindows => GeneralPlatform().isWindows;

  /// Whether the operating system is a version of Linux.
  bool get isLinux => GeneralPlatform().isLinux;

  /// Whether the operating system is a version of Android.
  bool get isAndroid => GeneralPlatform().isAndroid;

  /// Whether the operating system is a version of IOS.
  bool get isIOS => GeneralPlatform().isIOS;

  /// Whether the operating system is a version of Fuchsia.
  bool get isFuchsia => GeneralPlatform().isFuchsia;

  /// Whether the operating system is a Mobile OS.
  bool get isMobile => FluPlatform().isIOS || FluPlatform().isAndroid;

  /// Whether the operating system is a desktop OS.
  bool get isDesktop =>
      FluPlatform().isMacOS || FluPlatform().isWindows || FluPlatform().isLinux;
}
