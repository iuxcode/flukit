import 'dart:io';

/// Determine on Which OS the app is running
class GeneralPlatform {
  /// Whether the app is running in a web navigator
  bool get isWeb => false;

  /// Whether the operating system is a version of macOS.
  bool get isMacOS => Platform.isMacOS;

  /// Whether the operating system is a version of Windows.
  bool get isWindows => Platform.isWindows;

  /// Whether the operating system is a version of Linux.
  bool get isLinux => Platform.isLinux;

  /// Whether the operating system is a version of Android.
  bool get isAndroid => Platform.isAndroid;

  /// Whether the operating system is a version of IOS.
  bool get isIOS => Platform.isIOS;

  /// Whether the operating system is a version of Fuchsia.
  bool get isFuchsia => Platform.isFuchsia;

  /// Whether the operating system is a desktop OS.
  bool get isDesktop =>
      Platform.isMacOS || Platform.isWindows || Platform.isLinux;
}
