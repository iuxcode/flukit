import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/providers/theme_provider.dart';
import '../data/repositories/theme_repository.dart';
import '../utils/theme.dart';

class FluApp extends StatelessWidget {
  const FluApp({
    required this.builder,
    this.theme = FluDefaultThemes.blue,
    this.themeMode = ThemeMode.system,
    this.useSystemTheme = false,
    super.key,
  });

  final FluTheme theme;
  final ThemeMode themeMode;
  final bool useSystemTheme;
  final Widget Function(
      BuildContext context, FluTheme theme, ThemeMode themeMode) builder;

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

          FluTheme appTheme = themeManager.currentTheme;

          if (useSystemTheme) {
            return DynamicColorBuilder(
              builder: (ColorScheme? lightColors, ColorScheme? darkColors) {
                if (lightColors != null && darkColors != null) {
                  appTheme = FluTheme(
                      lightColors: lightColors, darkColors: darkColors);
                }

                return builder.call(context, appTheme, themeManager.themeMode);
              },
            );
          }

          return builder.call(context, appTheme, themeManager.themeMode);
        },
      ),
    );
  }
}
