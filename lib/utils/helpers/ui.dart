import 'package:flukit/utils/flu_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

extension T on FluInterface {
  /// give access to currentContext
  BuildContext get context => Get.context!;

  /// give access to current theme data
  ThemeData get theme => Theme.of(context);

  /// Get the screen size
  Size get screenSize => Get.size;

  /// Get the screen width
  double get screenWidth => screenSize.width;

  /// Get the screen height
  double get screenHeight => screenSize.height;

  /// return the status bar height
  double get statusBarHeight => MediaQuery.of(context).padding.top;

  /// Detect if the keyboard is visible or not
  bool isKeyboardHidden(BuildContext context) =>
      !(MediaQuery.of(context).viewInsets.bottom == 0);

  /// Hide the keyboard
  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  /// Show the keyboard
  void showKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }
}
