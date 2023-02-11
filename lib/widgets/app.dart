import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FluMaterialApp extends StatelessWidget {
  const FluMaterialApp(
      {super.key, required this.home, this.theme, this.darkTheme});

  final Widget home;
  final ThemeData? theme;
  final ThemeData? darkTheme;

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        navigatorKey: navigatorKey,
        theme: theme,
        darkTheme: darkTheme,
        home: home,
      );
}

final navigatorKey = GlobalKey<NavigatorState>();
