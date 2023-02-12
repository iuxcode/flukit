import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/flu_utils.dart';

/// Create a layout with styled system overlay
class FluScreen extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final bool extendBody;
  final Widget? floatingActionButton, bottomNavigationBar;
  final Color? background, drawerScrimColor;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Widget? drawer, endDrawer;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const FluScreen({
    Key? key,
    required this.body,
    this.appBar,
    this.systemUiOverlayStyle,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.extendBody = false,
    this.background,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerDocked,
    this.drawer,
    this.endDrawer,
    this.scaffoldKey,
    this.drawerScrimColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Flu.getColorSchemeOf(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
              statusBarColor: colorScheme.background,
              statusBarIconBrightness:
                  Get.isDarkMode ? Brightness.light : Brightness.dark,
              systemNavigationBarColor: colorScheme.background,
              systemNavigationBarIconBrightness:
                  Get.isDarkMode ? Brightness.light : Brightness.dark)
          .copyWith(
        statusBarColor: systemUiOverlayStyle?.statusBarColor,
        statusBarIconBrightness: systemUiOverlayStyle?.statusBarIconBrightness,
        statusBarBrightness: systemUiOverlayStyle?.statusBarBrightness,
        systemNavigationBarColor:
            systemUiOverlayStyle?.systemNavigationBarColor,
        systemNavigationBarDividerColor:
            systemUiOverlayStyle?.systemNavigationBarDividerColor,
        systemNavigationBarIconBrightness:
            systemUiOverlayStyle?.systemNavigationBarIconBrightness,
        systemStatusBarContrastEnforced:
            systemUiOverlayStyle?.systemStatusBarContrastEnforced,
        systemNavigationBarContrastEnforced:
            systemUiOverlayStyle?.systemNavigationBarContrastEnforced,
      ),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: background ?? colorScheme.background,
        extendBody: extendBody,
        appBar: appBar,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButton: floatingActionButton,
        drawer: drawer,
        endDrawer: endDrawer,
        drawerScrimColor: drawerScrimColor,
      ),
    );
  }
}
