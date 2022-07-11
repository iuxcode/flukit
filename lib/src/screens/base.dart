import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/flu_utils.dart';

class FluScreen extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final bool extendBody;
  final Widget? floatingActionButton, bottomNavigationBar;
  final Color? backgroundColor;
  final FloatingActionButtonLocation floatingActionButtonLocation;

  const FluScreen(
      {Key? key,
      required this.body,
      this.appBar,
      this.systemUiOverlayStyle,
      this.bottomNavigationBar,
      this.floatingActionButton,
      this.extendBody = false,
      this.backgroundColor,
      this.floatingActionButtonLocation =
          FloatingActionButtonLocation.centerDocked})
      : super(key: key);

  SystemUiOverlayStyle get defaultSystemStyle => Flukit.systemOverlayStyle;

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
      value: defaultSystemStyle.copyWith(
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
        backgroundColor: backgroundColor ?? Flukit.theme.backgroundColor,
        extendBody: extendBody,
        appBar: appBar,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButton: floatingActionButton,
      ));
}
