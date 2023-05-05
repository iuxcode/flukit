import 'package:flukit/utils/navigation/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../flukit.dart';

class FluMaterialApp extends MaterialApp {
  FluMaterialApp({
    required this.pages,
    required String initialRoute,
    super.key,
    super.navigatorKey,
    super.scaffoldMessengerKey,
    super.home,
    super.onGenerateRoute,
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
          initialRoute: _initialRoute(initialRoute),
          routes: _buildRoutesFrom(pages),
        );

  final List<FluPage> pages;

  static String _getRoutePath(PathDecoded path) => path.regex.pattern;

  static String _initialRoute(String route) =>
      _getRoutePath(FluPage.nameToRegex(route));

  static Map<String, Widget Function(BuildContext)> _buildRoutesFrom(
          List<FluPage> pages) =>
      {
        for (var page in pages)
          _getRoutePath(page.path): (BuildContext context) => page.page()
      };

  static Route<dynamic>? _onGenerateRoute(RouteSettings settings) {}
}
