import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/theme.dart';
import '../screens/default.dart';

class FluMaterialApp extends StatelessWidget {
  const FluMaterialApp({
    super.key,
    this.navigatorKey,
    this.scaffoldMessengerKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.useInheritedMediaQuery = false,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.textDirection,
    this.onGenerateTitle,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.fallbackLocale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = false,
    this.shortcuts,
    this.scrollBehavior,
    this.customTransition,
    this.translationsKeys,
    this.translations,
    this.onInit,
    this.onReady,
    this.onDispose,
    this.routingCallback,
    this.defaultTransition,
    this.getPages,
    this.opaqueRoute,
    this.enableLog,
    this.logWriterCallback,
    this.popGesture,
    this.transitionDuration,
    this.defaultGlobalState,
    this.smartManagement = SmartManagement.full,
    this.initialBinding,
    this.unknownRoute,
    this.actions,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.theme,
    this.darkTheme,
    this.color,
    this.title = '',
    this.useSystemColorScheme = false,
  });

  final Map<Type, Action<Intent>>? actions;
  final TransitionBuilder? builder;
  final bool checkerboardOffscreenLayers;
  final bool checkerboardRasterCacheImages;
  final Color? color;
  final CustomTransition? customTransition;
  final ThemeData? darkTheme;
  final bool debugShowCheckedModeBanner;
  final bool debugShowMaterialGrid;
  final bool? defaultGlobalState;
  final Transition? defaultTransition;
  final bool? enableLog;
  final Locale? fallbackLocale;
  final List<GetPage>? getPages;
  final ThemeData? highContrastDarkTheme;
  final ThemeData? highContrastTheme;
  final Widget? home;
  final Bindings? initialBinding;
  final String? initialRoute;
  final Locale? locale;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LogWriterCallback? logWriterCallback;
  final GlobalKey<NavigatorState>? navigatorKey;
  final List<NavigatorObserver>? navigatorObservers;
  final VoidCallback? onDispose;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onGenerateRoute;
  final GenerateAppTitle? onGenerateTitle;
  final VoidCallback? onInit;
  final VoidCallback? onReady;
  final RouteFactory? onUnknownRoute;
  final bool? opaqueRoute;
  final bool? popGesture;
  final Map<String, WidgetBuilder>? routes;
  final ValueChanged<Routing?>? routingCallback;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final ScrollBehavior? scrollBehavior;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final bool showPerformanceOverlay;
  final bool showSemanticsDebugger;
  final SmartManagement smartManagement;
  final Iterable<Locale> supportedLocales;
  final TextDirection? textDirection;
  final ThemeData? theme;
  final ThemeMode themeMode;
  final String title;
  final Duration? transitionDuration;
  final Translations? translations;
  final Map<String, Map<String, String>>? translationsKeys;
  final GetPage? unknownRoute;
  final bool useInheritedMediaQuery;
  final bool useSystemColorScheme;

  Widget _app({Widget? defaultHome, FluTheme? fluTheme}) => GetMaterialApp(
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
        home: defaultHome ?? home,
        routes: routes ?? const <String, WidgetBuilder>{},
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoute,
        onGenerateInitialRoutes: onGenerateInitialRoutes,
        onUnknownRoute: onUnknownRoute,
        useInheritedMediaQuery: useInheritedMediaQuery,
        navigatorObservers: navigatorObservers ?? [],
        builder: builder,
        textDirection: textDirection,
        onGenerateTitle: onGenerateTitle,
        themeMode: themeMode,
        locale: locale,
        fallbackLocale: fallbackLocale,
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
        customTransition: customTransition,
        translationsKeys: translationsKeys,
        translations: translations,
        onInit: onInit,
        onReady: onReady,
        onDispose: onDispose,
        routingCallback: routingCallback,
        defaultTransition: defaultTransition,
        getPages: getPages,
        opaqueRoute: opaqueRoute,
        enableLog: enableLog,
        logWriterCallback: logWriterCallback,
        popGesture: popGesture,
        transitionDuration: transitionDuration,
        defaultGlobalState: defaultGlobalState,
        smartManagement: smartManagement,
        initialBinding: initialBinding,
        unknownRoute: unknownRoute,
        actions: actions,
        highContrastTheme: highContrastTheme,
        highContrastDarkTheme: highContrastDarkTheme,
        theme: fluTheme?.light ?? theme,
        darkTheme: fluTheme?.dark ?? darkTheme,
        color: color,
        title: title,
      );

  @override
  Widget build(BuildContext context) {
    Widget? defaultHome;

    /// Lets display default screen if there are no routes or home specified by the user
    if (home == null &&
        initialRoute == null &&
        routes == null &&
        getPages == null) {
      defaultHome = const FluDefaultScreen();
    }

    if (useSystemColorScheme) {
      return DynamicColorBuilder(builder:
          (ColorScheme? lightColorScheme, ColorScheme? darkColorScheme) {
        return _app(
            defaultHome: defaultHome,
            fluTheme: FluTheme(
              lightColorScheme: lightColorScheme,
              darkColorScheme: darkColorScheme,
            ));
      });
    }

    return _app(defaultHome: defaultHome);
  }
}
