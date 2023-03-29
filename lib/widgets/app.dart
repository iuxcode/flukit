import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/providers/locales.dart';
import '../data/providers/theme_provider.dart';
import '../data/repositories/theme_repository.dart';
import '../navigation/router.dart';
import '../screens/default.dart';
import '../utils/theme_utils.dart';

class FluApp extends StatelessWidget {
  const FluApp({
    this.title,
    this.home,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.theme = FluDefaultThemes.blue,
    this.themeMode = ThemeMode.system,
    this.useSystemTheme = false,
    this.debugShowCheckedModeBanner = false,
    this.routes = const [],
    super.key,
  });

  final Widget? home;
  final List<Locale> supportedLocales;
  final FluTheme theme;
  final ThemeMode themeMode;
  final String? title;
  final bool useSystemTheme;
  final bool debugShowCheckedModeBanner;
  final List<RouteBase> routes;

  Widget _buildApp(
      {required ThemeData theme,
      required ThemeData darkTheme,
      required ThemeMode themeMode,
      required Locale locale}) {
    List<RouteBase> _routes = routes;

    if (_routes.isEmpty) {
      _routes = [
        FluRoute(
          name: "flukit_default",
          path: "/flukit_default",
          builder: (context, state) => const FlukitDefaultScreen(),
        )
      ];
    }

    return MaterialApp.router(
      title: title ?? "",
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      locale: locale,
      supportedLocales: supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routerConfig: FluRouter(_routes).getRouterConfig(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        if (themeMode != ThemeMode.system || theme != FluDefaultThemes.blue)
          themeProvider
              .overrideWith((ref) => ThemeNotifier(theme, themeMode: themeMode))
      ],
      child: Consumer(
        builder: (context, ref, child) {
          final themeManager = ref.watch(themeProvider);
          final locale = ref.watch(localesProvider);

          FluTheme appTheme = themeManager.currentTheme;

          if (useSystemTheme) {
            return DynamicColorBuilder(
              builder: (ColorScheme? lightColors, ColorScheme? darkColors) {
                if (lightColors != null && darkColors != null) {
                  appTheme = FluTheme(
                      lightColors: lightColors, darkColors: darkColors);
                }

                return _buildApp(
                  theme: appTheme.light,
                  darkTheme: appTheme.dark,
                  themeMode: themeManager.themeMode,
                  locale: locale,
                );
              },
            );
          }

          return _buildApp(
            theme: appTheme.light,
            darkTheme: appTheme.dark,
            themeMode: themeManager.themeMode,
            locale: locale,
          );
        },
      ),
    );
  }
}
