import 'package:flutter/material.dart';

import '../../flukit.dart';
import '../utils/navigation/observers.dart';

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
    List<NavigatorObserver> navigatorObservers = const [],
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
          navigatorKey: () {
            Flu.navigatorKey = navigatorKey ?? GlobalKey<NavigatorState>();
            return Flu.navigatorKey;
          }(),
          onGenerateInitialRoutes: (pages == null || home != null)
              ? onGenerateInitialRoutes
              : (String route) => [
                    _findPageAndReturnRoute(
                        RouteSettings(name: route), pages, unknownRoute)
                  ],
          onGenerateRoute: (pages == null)
              ? onGenerateRoute
              : (RouteSettings settings) =>
                  _findPageAndReturnRoute(settings, pages, unknownRoute),
          navigatorObservers: [FluNavObserver(), ...navigatorObservers],
        );

  final List<FluPage>? pages;
  final FluPage? unknownRoute;

  static FluPageRoute _findPageAndReturnRoute(
      RouteSettings settings, List<FluPage> pages, FluPage? unknownRoute) {
    final index = pages.indexWhere((page) => page.name == settings.name);

    return index > -1
        ? pages[index].copyWith(arguments: settings.arguments).toRoute()
        : buildUnknownRoute(unknownRoute, settings.name);
  }
}
