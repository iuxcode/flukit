import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FluMaterialApp extends StatelessWidget {
  const FluMaterialApp({super.key, required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        navigatorKey: navigatorKey,
        home: home,
      );
}

final navigatorKey = GlobalKey<NavigatorState>();
