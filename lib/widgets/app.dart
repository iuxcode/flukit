import 'package:flutter/material.dart';

import '../flukit.dart';

class FluMaterialApp extends MaterialApp {
  FluMaterialApp({
    required this.pages,
    required String initialRoute,
    this.unknownRoute,
    super.key,
    GlobalKey<NavigatorState>? navigatorKey,
    super.scaffoldMessengerKey,
    super.home,
    Route<dynamic>? Function(RouteSettings)? onGenerateRoute,
    super.onGenerateInitialRoutes,
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
            navigatorKey: navigatorKey ?? Flu.navigatorKey,
            initialRoute: _initialRoute(initialRoute),
            routes: _buildRoutesFrom(pages),
            onGenerateRoute: onGenerateRoute ??
                (settings) => _onGenerateRoute(settings, unknownRoute));

  final List<FluPage> pages;
  final FluPage<dynamic>? unknownRoute;

  static String _initialRoute(String route) => FluPage.generatePath(route);

  static Map<String, Widget Function(BuildContext)> _buildRoutesFrom(
          List<FluPage> pages) =>
      {
        for (var page in pages) page.path: (BuildContext context) => page.page()
      };

  static Route<dynamic>? _onGenerateRoute(
      RouteSettings settings, FluPage<dynamic>? unknownRoute) {
    final page =
        PageRedirect(settings: settings, unknownRoute: unknownRoute).page();
    return page;
  }
}
