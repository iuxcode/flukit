import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/flu_utils.dart';

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
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: Flu.theme.systemUiOverlayStyle.copyWith(
          statusBarColor: systemUiOverlayStyle?.statusBarColor,
          statusBarIconBrightness:
              systemUiOverlayStyle?.statusBarIconBrightness,
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
          backgroundColor: background,
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
