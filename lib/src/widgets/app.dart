import 'package:flutter/material.dart';

import '../../flukit.dart';

class FluMaterialApp extends MaterialApp {
  FluMaterialApp({
    required this.pages,
    required super.initialRoute,
    this.unknownRoute,
    super.key,
    super.routes,
    GlobalKey<NavigatorState>? navigatorKey,
    super.scaffoldMessengerKey,
    super.home,
    Route<dynamic>? Function(RouteSettings)? onGenerateRoute,
    List<Route<dynamic>> Function(String)? onGenerateInitialRoutes,
    super.onUnknownRoute,
    super.navigatorObservers,
    super.builder,
    super.title = '',
    super.onGenerateTitle,
    super.color,
    super.theme,
    super.darkTheme,
    super.highContrastTheme,
    super.highContrastDarkTheme,
    super.themeMode = ThemeMode.system,
    super.themeAnimationDuration = kThemeAnimationDuration,
    super.themeAnimationCurve = Curves.linear,
    super.locale,
    super.localizationsDelegates,
    super.localeListResolutionCallback,
    super.localeResolutionCallback,
    super.supportedLocales = const <Locale>[Locale('en', 'US')],
    super.debugShowMaterialGrid = false,
    super.showPerformanceOverlay = false,
    super.checkerboardRasterCacheImages = false,
    super.checkerboardOffscreenLayers = false,
    super.showSemanticsDebugger = false,
    super.debugShowCheckedModeBanner = true,
    super.shortcuts,
    super.actions,
    super.restorationScopeId,
    super.scrollBehavior,
    super.useInheritedMediaQuery = false,
  }) : super(
          navigatorKey: (() {
            Flu.navigatorKey = navigatorKey ?? GlobalKey<NavigatorState>();
            return Flu.navigatorKey;
          }).call(),
          onGenerateInitialRoutes: (pages == null || home != null)
              ? onGenerateInitialRoutes
              : (String route) =>
                  [_findPageAndReturnRoute(route, pages, unknownRoute)],
          onGenerateRoute: (pages == null)
              ? onGenerateRoute
              : (RouteSettings settings) {
                  Flu.routeArgs = settings.arguments;
                  return _findPageAndReturnRoute(
                      settings.name, pages, unknownRoute);
                },
        );

  final List<FluPage>? pages;
  final FluPage? unknownRoute;

  static FluPageRoute _findPageAndReturnRoute(
      String? name, List<FluPage> pages, FluPage? unknownRoute) {
    final index = pages.indexWhere((page) => page.name == name);

    return index > 0
        ? pages[index].toRoute()
        : _buildUnknownRoute(unknownRoute, name);
  }

  static FluPageRoute _buildUnknownRoute(
      FluPage? route, String? exceptedRouteName) {
    return route?.toRoute() ??
        FluPage(
            name: '/404',
            page: () => Flu404(exceptedRouteName ?? "Unknown.")).toRoute();
  }
}
