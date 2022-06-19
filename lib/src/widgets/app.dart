import 'package:flukit/flukit.dart';
import 'package:flukit/src/screens/default.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FluMaterialApp extends StatefulWidget {
  final String title;
  final FluAppController? controller;
  final Bindings? initialBinding;
  final Widget? home;
  final Map<String, WidgetBuilder>? routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;
  final TransitionBuilder? builder;
  final bool showDebugBanner;
  final List<GetPage<dynamic>>? pages;

  const FluMaterialApp({
    Key? key,
    this.controller,
    this.initialBinding,
    this.title = 'Flukit',
    this.home,
    this.routes,
    this.initialRoute,
    this.onGenerateInitialRoutes,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers,
    this.builder,
    this.pages,
    this.showDebugBanner = false,
  }) : super(key: key);

  @override
  State<FluMaterialApp> createState() => _FluMaterialAppState();
}

class _FluMaterialAppState extends State<FluMaterialApp> {
  late FluAppController controller;

  @override
  void initState() {
    if(widget.controller != null) {
      controller = widget.controller!;
    } else {
      controller = FluAppController();
    }

    Get.put(controller, permanent: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GetBuilder<FluAppController>(
    init: controller,
    initState: (_) {},
    builder: (_) {
      return GetMaterialApp(
        title: widget.title,
        debugShowCheckedModeBanner: widget.showDebugBanner,
        theme: controller.theme.data,
        initialBinding: widget.initialBinding,
        home: widget.home,
        initialRoute: widget.initialRoute ?? '/splash',
        routes: widget.routes ?? <String, WidgetBuilder> {},
        getPages: widget.pages ?? [
          FluGetPage(
            name: '/splash',
            page: () => const FluDefaultScreen()
          )
        ],
      );
    }
  );
}