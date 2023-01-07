import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FluMaterialApp extends GetMaterialApp {
  final FluAppController? controller;

  const FluMaterialApp({
    super.key,
    super.navigatorKey,
    super.scaffoldMessengerKey,
    super.home,
    super.routes = const <String, WidgetBuilder>{},
    super.initialRoute,
    super.onGenerateRoute,
    super.onGenerateInitialRoutes,
    super.onUnknownRoute,
    super.useInheritedMediaQuery = false,
    super.navigatorObservers = const <NavigatorObserver>[],
    super.builder,
    super.textDirection,
    super.onGenerateTitle,
    super.themeMode = ThemeMode.system,
    super.locale,
    super.fallbackLocale,
    super.localizationsDelegates,
    super.localeListResolutionCallback,
    super.localeResolutionCallback,
    super.supportedLocales = const <Locale>[Locale('en', 'US')],
    super.debugShowMaterialGrid = false,
    super.showPerformanceOverlay = false,
    super.checkerboardRasterCacheImages = false,
    super.checkerboardOffscreenLayers = false,
    super.showSemanticsDebugger = false,
    super.debugShowCheckedModeBanner = false,
    super.shortcuts,
    super.scrollBehavior,
    super.customTransition,
    super.translationsKeys,
    super.translations,
    super.onInit,
    super.onReady,
    super.onDispose,
    super.routingCallback,
    super.defaultTransition,
    super.getPages,
    super.opaqueRoute,
    super.enableLog,
    super.logWriterCallback,
    super.popGesture,
    super.transitionDuration,
    super.defaultGlobalState,
    super.smartManagement = SmartManagement.full,
    super.initialBinding,
    super.unknownRoute,
    super.highContrastTheme,
    super.highContrastDarkTheme,
    super.actions,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    List<GetPage<dynamic>>? pages;
    String? initRoute;

    /// Lets display default screen if there are no routes or home specified by the user
    if (home == null) {
      if (initialRoute != null && (routes != null || getPages != null)) {
        initRoute = initialRoute;
      } else {
        initRoute = '/default';
      }

      if (getPages != null) {
        pages = getPages;
      } else {
        pages = [
          GetPage(
            name: '/default',
            page: () => const FluDefaultScreen(),
          ),
        ];
      }
    }

    /// Adding some default value to page such as default transition
    pages = pages
        ?.map((p) => GetPage(
            name: p.name,
            page: p.page,
            transition: p.transition ?? Transition.rightToLeft))
        .toList();

    return GetBuilder<FluAppController>(
        init: controller ?? FluAppController(),
        dispose: (d) {
          onDispose?.call();
        },
        initState: (i) {
          Get.engine.addPostFrameCallback((timeStamp) {
            onReady?.call();
          });
          if (locale != null) Get.locale = locale;

          if (fallbackLocale != null) Get.fallbackLocale = fallbackLocale;

          if (translations != null) {
            Get.addTranslations(translations!.keys);
          } else if (translationsKeys != null) {
            Get.addTranslations(translationsKeys!);
          }

          Get.customTransition = customTransition;

          initialBinding?.dependencies();
          if (pages != null) {
            Get.addPages(pages);
          }

          //Get.setDefaultDelegate(routerDelegate);
          Get.smartManagement = smartManagement;
          onInit?.call();

          Get.config(
            enableLog: enableLog ?? Get.isLogEnable,
            logWriterCallback: logWriterCallback,
            defaultTransition: defaultTransition ?? Get.defaultTransition,
            defaultOpaqueRoute: opaqueRoute ?? Get.isOpaqueRouteDefault,
            defaultPopGesture: popGesture ?? Get.isPopGestureEnable,
            defaultDurationTransition:
                transitionDuration ?? Get.defaultTransitionDuration,
          );
        },
        builder: (_) {
          String appTitle = _.infos.name;

          ThemeData appTheme = _.theme ?? _.themeBuilder.theme;
          ThemeData appDarkTheme = _.darkTheme ?? _.themeBuilder.darkTheme;

          Color appColor = _.themeBuilder.primary;

          return routerDelegate != null
              ? MaterialApp.router(
                  routerDelegate: routerDelegate!,
                  routeInformationParser: routeInformationParser!,
                  backButtonDispatcher: backButtonDispatcher,
                  routeInformationProvider: routeInformationProvider,
                  key: _.unikey,
                  builder: defaultBuilder,
                  title: appTitle,
                  onGenerateTitle: onGenerateTitle,
                  color: appColor,
                  theme: appTheme,
                  darkTheme: appDarkTheme,
                  themeMode: _.themeMode ?? themeMode,
                  locale: Get.locale ?? locale,
                  scaffoldMessengerKey:
                      scaffoldMessengerKey ?? _.scaffoldMessengerKey,
                  localizationsDelegates: localizationsDelegates,
                  localeListResolutionCallback: localeListResolutionCallback,
                  localeResolutionCallback: localeResolutionCallback,
                  supportedLocales: supportedLocales,
                  debugShowMaterialGrid: debugShowMaterialGrid,
                  showPerformanceOverlay: showPerformanceOverlay,
                  checkerboardRasterCacheImages: checkerboardRasterCacheImages,
                  checkerboardOffscreenLayers: checkerboardOffscreenLayers,
                  showSemanticsDebugger: showSemanticsDebugger,
                  debugShowCheckedModeBanner: debugShowCheckedModeBanner,
                  shortcuts: shortcuts,
                  scrollBehavior: scrollBehavior,
                  useInheritedMediaQuery: useInheritedMediaQuery,
                )
              : MaterialApp(
                  key: _.unikey,
                  navigatorKey: (navigatorKey == null
                      ? Get.key
                      : Get.addKey(navigatorKey!)),
                  scaffoldMessengerKey:
                      scaffoldMessengerKey ?? _.scaffoldMessengerKey,
                  home: home,
                  routes: routes ?? <String, WidgetBuilder>{},
                  initialRoute: initRoute,
                  onGenerateRoute: pages != null ? generator : onGenerateRoute,
                  onGenerateInitialRoutes: (pages == null || home != null)
                      ? onGenerateInitialRoutes
                      : initialRoutesGenerate,
                  onUnknownRoute: onUnknownRoute,
                  navigatorObservers: (navigatorObservers == null
                      ? <NavigatorObserver>[
                          GetObserver(routingCallback, Get.routing)
                        ]
                      : <NavigatorObserver>[
                          GetObserver(routingCallback, Get.routing)
                        ]
                    ..addAll(navigatorObservers!)),
                  builder: defaultBuilder,
                  title: appTitle,
                  onGenerateTitle: onGenerateTitle,
                  color: appColor,
                  theme: appTheme,
                  darkTheme: appDarkTheme,
                  themeMode: _.themeMode ?? themeMode,
                  locale: Get.locale ?? locale,
                  localizationsDelegates: localizationsDelegates,
                  localeListResolutionCallback: localeListResolutionCallback,
                  localeResolutionCallback: localeResolutionCallback,
                  supportedLocales: supportedLocales,
                  debugShowMaterialGrid: debugShowMaterialGrid,
                  showPerformanceOverlay: showPerformanceOverlay,
                  checkerboardRasterCacheImages: checkerboardRasterCacheImages,
                  checkerboardOffscreenLayers: checkerboardOffscreenLayers,
                  showSemanticsDebugger: showSemanticsDebugger,
                  debugShowCheckedModeBanner: debugShowCheckedModeBanner,
                  shortcuts: shortcuts,
                  scrollBehavior: scrollBehavior,
                  useInheritedMediaQuery: useInheritedMediaQuery,
                  //   actions: actions,
                );
        });
  }
}
