import 'package:flukit/flukit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final List<FluPage<dynamic>> _kDefaultPages = [
  FluPage(
    name: '404',
    page: buildUnknownRoute(null, null).page,
    initial: true,
  ),
];

/// Creates a MaterialApp.
class FluMaterialApp extends StatefulWidget {
  // ignore: public_member_api_docs
  const FluMaterialApp({
    this.pages,
    this.navigatorKey,
    this.unknownRoute,
    super.key,
    this.scaffoldMessengerKey,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.themeAnimationDuration = kThemeAnimationDuration,
    this.themeAnimationCurve = Curves.linear,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.useInheritedMediaQuery = false,
    this.showNavigationLogs = false,
  });

  /// App pages. Routes will be created automatically.
  final List<FluPage<dynamic>>? pages;

  /// 404 page.
  /// Called when the called route has not been found.
  final FluPage<dynamic>? unknownRoute;

  /// {@macro flutter.widgets.widgetsApp.actions}
  /// {@tool snippet}
  /// This example shows how to add a single action handling an
  /// [ActivateAction] to the default actions without needing to
  /// add your own [Actions] widget.
  ///
  /// Alternatively, you could insert a [Actions] widget with just the mapping
  /// you want to add between the [WidgetsApp] and its child and get the same
  /// effect.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return WidgetsApp(
  ///     actions: <Type, Action<Intent>>{
  ///       ... WidgetsApp.defaultActions,
  ///       ActivateAction: CallbackAction<Intent>(
  ///         onInvoke: (Intent intent) {
  ///           // Do something here...
  ///           return null;
  ///         },
  ///       ),
  ///     },
  ///     color: const Color(0xFFFF0000),
  ///     builder: (BuildContext context, Widget? child) {
  ///       return const Placeholder();
  ///     },
  ///   );
  /// }
  /// ```
  /// {@end-tool}
  /// {@macro flutter.widgets.widgetsApp.actions.seeAlso}
  final Map<Type, Action<Intent>>? actions;

  /// {@macro flutter.widgets.widgetsApp.builder}
  ///
  /// Material specific features such
  /// as [showDialog] and [showMenu], and widgets
  /// such as [Tooltip], [PopupMenuButton],
  /// also require a [Navigator] to properly
  /// function.
  final TransitionBuilder? builder;

  /// Turns on checkerboarding of layers rendered to offscreen bitmaps.
  final bool checkerboardOffscreenLayers;

  /// Turns on checkerboarding of raster cache images.
  final bool checkerboardRasterCacheImages;

  /// {@macro flutter.widgets.widgetsApp.color}
  final Color? color;

  /// The [ThemeData] to use when a 'dark mode' is requested by the system.
  ///
  /// Some host platforms allow the users to select a system-wide 'dark mode',
  /// or the application may want to offer the user the ability to choose a
  /// dark theme just for this application. This is theme that will be used for
  /// such cases. [themeMode] will control which theme will be used.
  ///
  /// This theme should have a [ThemeData.brightness] set to [Brightness.dark].
  ///
  /// Uses [theme] instead when null. Defaults to the value of
  /// [ThemeData.light()] when both [darkTheme] and [theme] are null.
  ///
  /// See also:
  ///
  ///  * [themeMode], which controls which theme to use.
  ///  * [MediaQueryData.platformBrightness], which indicates the platform's
  ///    desired brightness and is used to automatically toggle between [theme]
  ///    and [darkTheme] in [MaterialApp].
  ///  * [ThemeData.brightness], which is typically set to the value of
  ///    [MediaQueryData.platformBrightness].
  final ThemeData? darkTheme;

  /// {@macro flutter.widgets.widgetsApp.debugShowCheckedModeBanner}
  final bool debugShowCheckedModeBanner;

  /// Turns on a [GridPaper] overlay that paints a baseline grid
  /// Material apps.
  ///
  /// Only available in debug mode.
  ///
  /// See also:
  ///
  ///  * <https://material.io/design/layout/spacing-methods.html>
  final bool debugShowMaterialGrid;

  /// The [ThemeData] to use when a 'dark mode' and 'high contrast' is requested
  /// by the system.
  ///
  /// Some host platforms (for example, iOS) allow the users to increase
  /// contrast through an accessibility setting.
  ///
  /// This theme should have a [ThemeData.brightness] set to [Brightness.dark].
  ///
  /// Uses [darkTheme] instead when null.
  ///
  /// See also:
  ///
  ///  * [MediaQueryData.highContrast], which indicates the platform's
  ///    desire to increase contrast.
  final ThemeData? highContrastDarkTheme;

  /// The [ThemeData] to use when 'high contrast' is requested by the system.
  ///
  /// Some host platforms (for example, iOS) allow the users to increase
  /// contrast through an accessibility setting.
  ///
  /// Uses [theme] instead when null.
  ///
  /// See also:
  ///
  ///  * [MediaQueryData.highContrast], which indicates the platform's
  ///    desire to increase contrast.
  final ThemeData? highContrastTheme;

  /// {@macro flutter.widgets.widgetsApp.locale}
  final Locale? locale;

  /// {@macro flutter.widgets.widgetsApp.localeListResolutionCallback}
  ///
  /// This callback is passed along to the [WidgetsApp] built by this widget.
  final LocaleListResolutionCallback? localeListResolutionCallback;

  /// {@macro flutter.widgets.LocaleResolutionCallback}
  ///
  /// This callback is passed along to the [WidgetsApp] built by this widget.
  final LocaleResolutionCallback? localeResolutionCallback;

  /// {@macro flutter.widgets.widgetsApp.localizationsDelegates}
  ///
  /// Internationalized apps that require translations for one of the locales
  /// listed in GlobalMaterialLocalizations should specify this parameter
  /// and list the [supportedLocales] that the application can handle.
  ///
  /// ```dart
  /// // The GlobalMaterialLocalizations and GlobalWidgetsLocalizations
  /// // classes require the following import:
  /// // import 'package:flutter_localizations/flutter_localizations.dart';
  ///
  /// const MaterialApp(
  ///   localizationsDelegates: <LocalizationsDelegate<Object>>[
  ///     // ... app-specific localization delegate(s) here
  ///     GlobalMaterialLocalizations.delegate,
  ///     GlobalWidgetsLocalizations.delegate,
  ///   ],
  ///   supportedLocales: <Locale>[
  ///     Locale('en', 'US'), // English
  ///     Locale('he', 'IL'), // Hebrew
  ///     // ... other locales the app supports
  ///   ],
  ///   // ...
  /// )
  /// ```
  ///
  /// ## Adding localizations for a new locale
  ///
  /// The information that follows applies to the unusual case of an app
  /// adding translations for a language not already supported by
  /// GlobalMaterialLocalizations.
  ///
  /// Delegates that produce [WidgetsLocalizations] and [MaterialLocalizations]
  /// are included automatically. Apps can provide their own versions of these
  /// localizations by creating implementations of
  /// [LocalizationsDelegate<WidgetsLocalizations>] or
  /// [LocalizationsDelegate<MaterialLocalizations>] whose load methods return
  /// custom versions of [WidgetsLocalizations] or [MaterialLocalizations].
  ///
  /// For example: to add support to [MaterialLocalizations] for a locale it
  /// doesn't already support, say `const Locale('foo', 'BR')`, one first
  /// creates a subclass of [MaterialLocalizations] that provides the
  /// translations:
  ///
  /// ```dart
  /// class FooLocalizations extends MaterialLocalizations {
  ///   FooLocalizations();
  ///   @override
  ///   String get okButtonLabel => 'foo';
  ///   // ...
  ///   // lots of other getters and methods to override!
  /// }
  /// ```
  ///
  /// One must then create a [LocalizationsDelegate] subclass that can provide
  /// an instance of the [MaterialLocalizations] subclass. In this case, this is
  /// essentially just a method that constructs a `FooLocalizations` object. A
  /// SynchronousFuture is used here because no asynchronous work takes place
  /// upon "loading" the localizations object.
  ///
  /// ```dart
  /// // continuing from previous example...
  /// class FooLocalizationsDelegate extends
  /// LocalizationsDelegate<MaterialLocalizations> {
  ///   const FooLocalizationsDelegate();
  ///   @override
  ///   bool isSupported(Locale locale) {
  ///     return locale == const Locale('foo', 'BR');
  ///   }
  ///   @override
  ///   Future<FooLocalizations> load(Locale locale) {
  ///     assert(locale == const Locale('foo', 'BR'));
  ///     return SynchronousFuture<FooLocalizations>(FooLocalizations());
  ///   }
  ///   @override
  ///   bool shouldReload(FooLocalizationsDelegate old) => false;
  /// }
  /// ```
  ///
  /// Constructing a [MaterialApp] with a `FooLocalizationsDelegate` overrides
  /// the automatically included delegate for [MaterialLocalizations] because
  /// only the first delegate of each [LocalizationsDelegate.type] is used and
  /// the automatically included delegates are added to the end of the app's
  /// [localizationsDelegates] list.
  ///
  /// ```dart
  /// // continuing from previous example...
  /// const MaterialApp(
  ///   localizationsDelegates: <LocalizationsDelegate<Object>>[
  ///     FooLocalizationsDelegate(),
  ///   ],
  ///   // ...
  /// )
  /// ```
  /// See also:
  ///
  ///  * [supportedLocales], which must be specified along with
  ///    [localizationsDelegates].
  ///  * GlobalMaterialLocalizations, a [localizationsDelegates] value
  ///    which provides material localizations for many languages.
  ///  * The Flutter Internationalization Tutorial,
  ///    <https://flutter.dev/tutorials/internationalization/>.
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// {@macro flutter.widgets.widgetsApp.navigatorKey}
  final GlobalKey<NavigatorState>? navigatorKey;

  /// {@macro flutter.widgets.widgetsApp.navigatorObservers}
  final List<NavigatorObserver> navigatorObservers;

  /// {@macro flutter.widgets.widgetsApp.onGenerateTitle}
  ///
  /// This value is passed unmodified to [WidgetsApp.onGenerateTitle].
  final GenerateAppTitle? onGenerateTitle;

  /// {@macro flutter.widgets.widgetsApp.onUnknownRoute}
  final RouteFactory? onUnknownRoute;

  /// {@macro flutter.widgets.widgetsApp.restorationScopeId}
  final String? restorationScopeId;

  /// A key to use when building the [ScaffoldMessenger].
  ///
  /// If a [scaffoldMessengerKey] is specified, the [ScaffoldMessenger] can be
  /// directly manipulated without first obtaining it from a [BuildContext] via
  /// [ScaffoldMessenger.of]: from the [scaffoldMessengerKey], use the
  /// [GlobalKey.currentState] getter.
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  /// {@template flutter.material.materialApp.scrollBehavior}
  /// The default [ScrollBehavior] for the application.
  ///
  /// [ScrollBehavior]s describe how [Scrollable] widgets behave. Providing
  /// a [ScrollBehavior] can set the default [ScrollPhysics] across
  /// an application, and manage [Scrollable] decorations like [Scrollbar]s and
  /// [GlowingOverscrollIndicator]s.
  /// {@endtemplate}
  ///
  /// When null, defaults to [MaterialScrollBehavior].
  ///
  /// See also:
  ///
  ///  * [ScrollConfiguration], which controls how [Scrollable] widgets behave
  ///    in a subtree.
  final ScrollBehavior? scrollBehavior;

  /// {@macro flutter.widgets.widgetsApp.shortcuts}
  /// {@tool snippet}
  /// This example shows how to add a single shortcut for
  /// LogicalKeyboardKey.select to the default shortcuts without needing to
  /// add your own [Shortcuts] widget.
  ///
  /// Alternatively, you could insert a [Shortcuts] widget with just the mapping
  /// you want to add between the [WidgetsApp] and its child and get the same
  /// effect.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return WidgetsApp(
  ///     shortcuts: <ShortcutActivator, Intent>{
  ///       ... WidgetsApp.defaultShortcuts,
  ///       const SingleActivator(LogicalKeyboardKey.select):
  ///         const ActivateIntent(),
  ///     },
  ///     color: const Color(0xFFFF0000),
  ///     builder: (BuildContext context, Widget? child) {
  ///       return const Placeholder();
  ///     },
  ///   );
  /// }
  /// ```
  /// {@end-tool}
  /// {@macro flutter.widgets.widgetsApp.shortcuts.seeAlso}
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// Turns on a performance overlay.
  ///
  /// See also:
  ///
  ///  * <https://flutter.dev/debugging/#performance-overlay>
  final bool showPerformanceOverlay;

  /// Turns on an overlay that shows the accessibility information
  /// reported by the framework.
  final bool showSemanticsDebugger;

  /// {@macro flutter.widgets.widgetsApp.supportedLocales}
  ///
  /// It is passed along unmodified to the [WidgetsApp] built by this widget.
  ///
  /// See also:
  ///
  ///  * [localizationsDelegates], which must be specified for localized
  ///    applications.
  ///  * GlobalMaterialLocalizations, a [localizationsDelegates] value
  ///    which provides material localizations for many languages.
  ///  * The Flutter Internationalization Tutorial,
  ///    <https://flutter.dev/tutorials/internationalization/>.
  final Iterable<Locale> supportedLocales;

  /// Default visual properties, like colors fonts and shapes, for this app's
  /// material widgets.
  ///
  /// A second [darkTheme] [ThemeData] value, which is used to provide a dark
  /// version of the user interface can also be specified. [themeMode] will
  /// control which theme will be used if a [darkTheme] is provided.
  ///
  /// The default value of this property is the value of [ThemeData.light()].
  ///
  /// See also:
  ///
  ///  * [themeMode], which controls which theme to use.
  ///  * [MediaQueryData.platformBrightness], which indicates the platform's
  ///    desired brightness and is used to automatically toggle between [theme]
  ///    and [darkTheme] in [MaterialApp].
  ///  * [ThemeData.brightness], which indicates the [Brightness] of a theme's
  ///    colors.
  final ThemeData? theme;

  /// The curve to apply when animating theme changes.
  ///
  /// The default is [Curves.linear].
  ///
  /// This is ignored if [themeAnimationDuration] is [Duration.zero].
  ///
  /// See also:
  ///   [themeAnimationDuration], which defines how long the animation is.
  final Curve themeAnimationCurve;

  /// The duration of animated theme changes.
  ///
  /// When the theme changes (either by the [theme], [darkTheme] or [themeMode]
  /// parameters changing) it is animated to the new theme over time.
  /// The [themeAnimationDuration] determines how long this animation takes.
  ///
  /// To have the theme change immediately, you can set this to [Duration.zero].
  ///
  /// The default is [kThemeAnimationDuration].
  ///
  /// See also:
  ///   [themeAnimationCurve], which defines the curve used for the animation.
  final Duration themeAnimationDuration;

  /// Determines which theme will be used by the application if both [theme]
  /// and [darkTheme] are provided.
  ///
  /// If set to [ThemeMode.system], the choice of which theme to use will
  /// be based on the user's system preferences.
  /// If the [MediaQuery.platformBrightnessOf]
  /// is [Brightness.light], [theme] will be used. If it is [Brightness.dark],
  /// [darkTheme] will be used (unless it is null, in which case [theme]
  /// will be used.
  ///
  /// If set to [ThemeMode.light] the [theme] will always be used,
  /// regardless of the user's system preference.
  ///
  /// If set to [ThemeMode.dark] the [darkTheme] will be used
  /// regardless of the user's system preference. If [darkTheme] is null
  /// then it will fallback to using [theme].
  ///
  /// The default value is [ThemeMode.system].
  ///
  /// See also:
  ///
  ///  * [theme], which is used when a light mode is selected.
  ///  * [darkTheme], which is used when a dark mode is selected.
  ///  * [ThemeData.brightness], which indicates to various parts of the
  ///    system what kind of theme is being used.
  final ThemeMode? themeMode;

  /// {@macro flutter.widgets.widgetsApp.title}
  ///
  /// This value is passed unmodified to [WidgetsApp.title].
  final String title;

  /// {@macro flutter.widgets.widgetsApp.useInheritedMediaQuery}
  final bool useInheritedMediaQuery;

  /// Set to true to display logs about navigation
  /// ie: GOING TO ROUTE /otp with args: ...
  final bool showNavigationLogs;

  @override
  State<FluMaterialApp> createState() => _FluMaterialAppState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<FluPage<dynamic>>('pages', pages))
      ..add(
        DiagnosticsProperty<FluPage<dynamic>?>('unknownRoute', unknownRoute),
      )
      ..add(
        DiagnosticsProperty<GlobalKey<NavigatorState>?>(
          'navigatorKey',
          navigatorKey,
        ),
      )
      ..add(
        DiagnosticsProperty<GlobalKey<ScaffoldMessengerState>?>(
          'scaffoldMessengerKey',
          scaffoldMessengerKey,
        ),
      )
      ..add(
        ObjectFlagProperty<RouteFactory?>.has(
          'onUnknownRoute',
          onUnknownRoute,
        ),
      )
      ..add(
        IterableProperty<NavigatorObserver>(
          'navigatorObservers',
          navigatorObservers,
        ),
      )
      ..add(ObjectFlagProperty<TransitionBuilder?>.has('builder', builder))
      ..add(StringProperty('title', title))
      ..add(
        ObjectFlagProperty<GenerateAppTitle?>.has(
          'onGenerateTitle',
          onGenerateTitle,
        ),
      )
      ..add(DiagnosticsProperty<ThemeData?>('theme', theme))
      ..add(DiagnosticsProperty<ThemeData?>('darkTheme', darkTheme))
      ..add(
        DiagnosticsProperty<ThemeData?>(
          'highContrastTheme',
          highContrastTheme,
        ),
      )
      ..add(
        DiagnosticsProperty<ThemeData?>(
          'highContrastDarkTheme',
          highContrastDarkTheme,
        ),
      )
      ..add(EnumProperty<ThemeMode?>('themeMode', themeMode))
      ..add(
        DiagnosticsProperty<Duration>(
          'themeAnimationDuration',
          themeAnimationDuration,
        ),
      )
      ..add(
        DiagnosticsProperty<Curve>(
          'themeAnimationCurve',
          themeAnimationCurve,
        ),
      )
      ..add(ColorProperty('color', color))
      ..add(DiagnosticsProperty<Locale?>('locale', locale))
      ..add(
        IterableProperty<LocalizationsDelegate<dynamic>>(
          'localizationsDelegates',
          localizationsDelegates,
        ),
      )
      ..add(
        ObjectFlagProperty<LocaleListResolutionCallback?>.has(
          'localeListResolutionCallback',
          localeListResolutionCallback,
        ),
      )
      ..add(
        ObjectFlagProperty<LocaleResolutionCallback?>.has(
          'localeResolutionCallback',
          localeResolutionCallback,
        ),
      )
      ..add(IterableProperty<Locale>('supportedLocales', supportedLocales))
      ..add(
        DiagnosticsProperty<bool>(
          'showPerformanceOverlay',
          showPerformanceOverlay,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'checkerboardRasterCacheImages',
          checkerboardRasterCacheImages,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'checkerboardOffscreenLayers',
          checkerboardOffscreenLayers,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'showSemanticsDebugger',
          showSemanticsDebugger,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'debugShowCheckedModeBanner',
          debugShowCheckedModeBanner,
        ),
      )
      ..add(
        DiagnosticsProperty<Map<ShortcutActivator, Intent>?>(
          'shortcuts',
          shortcuts,
        ),
      )
      ..add(DiagnosticsProperty<Map<Type, Action<Intent>>?>('actions', actions))
      ..add(StringProperty('restorationScopeId', restorationScopeId))
      ..add(
        DiagnosticsProperty<ScrollBehavior?>(
          'scrollBehavior',
          scrollBehavior,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'debugShowMaterialGrid',
          debugShowMaterialGrid,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'useInheritedMediaQuery',
          useInheritedMediaQuery,
        ),
      )
      ..add(
        DiagnosticsProperty<FluPage<dynamic>?>('unknownRoute', unknownRoute),
      )
      ..add(
        DiagnosticsProperty<GlobalKey<NavigatorState>?>(
          'navigatorKey',
          navigatorKey,
        ),
      )
      ..add(
        DiagnosticsProperty<GlobalKey<ScaffoldMessengerState>?>(
          'scaffoldMessengerKey',
          scaffoldMessengerKey,
        ),
      )
      ..add(
        ObjectFlagProperty<RouteFactory?>.has(
          'onUnknownRoute',
          onUnknownRoute,
        ),
      )
      ..add(
        IterableProperty<NavigatorObserver>(
          'navigatorObservers',
          navigatorObservers,
        ),
      )
      ..add(ObjectFlagProperty<TransitionBuilder?>.has('builder', builder))
      ..add(StringProperty('title', title))
      ..add(
        ObjectFlagProperty<GenerateAppTitle?>.has(
          'onGenerateTitle',
          onGenerateTitle,
        ),
      )
      ..add(DiagnosticsProperty<ThemeData?>('theme', theme))
      ..add(DiagnosticsProperty<ThemeData?>('darkTheme', darkTheme))
      ..add(
        DiagnosticsProperty<ThemeData?>(
          'highContrastTheme',
          highContrastTheme,
        ),
      )
      ..add(
        DiagnosticsProperty<ThemeData?>(
          'highContrastDarkTheme',
          highContrastDarkTheme,
        ),
      )
      ..add(EnumProperty<ThemeMode?>('themeMode', themeMode))
      ..add(
        DiagnosticsProperty<Duration>(
          'themeAnimationDuration',
          themeAnimationDuration,
        ),
      )
      ..add(
        DiagnosticsProperty<Curve>(
          'themeAnimationCurve',
          themeAnimationCurve,
        ),
      )
      ..add(ColorProperty('color', color))
      ..add(DiagnosticsProperty<Locale?>('locale', locale))
      ..add(
        IterableProperty<LocalizationsDelegate<dynamic>>(
          'localizationsDelegates',
          localizationsDelegates,
        ),
      )
      ..add(
        ObjectFlagProperty<LocaleListResolutionCallback?>.has(
          'localeListResolutionCallback',
          localeListResolutionCallback,
        ),
      )
      ..add(
        ObjectFlagProperty<LocaleResolutionCallback?>.has(
          'localeResolutionCallback',
          localeResolutionCallback,
        ),
      )
      ..add(IterableProperty<Locale>('supportedLocales', supportedLocales))
      ..add(
        DiagnosticsProperty<bool>(
          'showPerformanceOverlay',
          showPerformanceOverlay,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'checkerboardRasterCacheImages',
          checkerboardRasterCacheImages,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'checkerboardOffscreenLayers',
          checkerboardOffscreenLayers,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'showSemanticsDebugger',
          showSemanticsDebugger,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'debugShowCheckedModeBanner',
          debugShowCheckedModeBanner,
        ),
      )
      ..add(
        DiagnosticsProperty<Map<ShortcutActivator, Intent>?>(
          'shortcuts',
          shortcuts,
        ),
      )
      ..add(DiagnosticsProperty<Map<Type, Action<Intent>>?>('actions', actions))
      ..add(StringProperty('restorationScopeId', restorationScopeId))
      ..add(
        DiagnosticsProperty<ScrollBehavior?>(
          'scrollBehavior',
          scrollBehavior,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'debugShowMaterialGrid',
          debugShowMaterialGrid,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'useInheritedMediaQuery',
          useInheritedMediaQuery,
        ),
      )
      ..add(
        DiagnosticsProperty<FluPage<dynamic>?>('unknownRoute', unknownRoute),
      )
      ..add(
        DiagnosticsProperty<GlobalKey<NavigatorState>?>(
          'navigatorKey',
          navigatorKey,
        ),
      )
      ..add(
        DiagnosticsProperty<GlobalKey<ScaffoldMessengerState>?>(
          'scaffoldMessengerKey',
          scaffoldMessengerKey,
        ),
      )
      ..add(
        ObjectFlagProperty<RouteFactory?>.has(
          'onUnknownRoute',
          onUnknownRoute,
        ),
      )
      ..add(
        IterableProperty<NavigatorObserver>(
          'navigatorObservers',
          navigatorObservers,
        ),
      )
      ..add(ObjectFlagProperty<TransitionBuilder?>.has('builder', builder))
      ..add(StringProperty('title', title))
      ..add(
        ObjectFlagProperty<GenerateAppTitle?>.has(
          'onGenerateTitle',
          onGenerateTitle,
        ),
      )
      ..add(DiagnosticsProperty<ThemeData?>('theme', theme))
      ..add(DiagnosticsProperty<ThemeData?>('darkTheme', darkTheme))
      ..add(
        DiagnosticsProperty<ThemeData?>(
          'highContrastTheme',
          highContrastTheme,
        ),
      )
      ..add(
        DiagnosticsProperty<ThemeData?>(
          'highContrastDarkTheme',
          highContrastDarkTheme,
        ),
      )
      ..add(EnumProperty<ThemeMode?>('themeMode', themeMode))
      ..add(
        DiagnosticsProperty<Duration>(
          'themeAnimationDuration',
          themeAnimationDuration,
        ),
      )
      ..add(
        DiagnosticsProperty<Curve>(
          'themeAnimationCurve',
          themeAnimationCurve,
        ),
      )
      ..add(ColorProperty('color', color))
      ..add(DiagnosticsProperty<Locale?>('locale', locale))
      ..add(
        IterableProperty<LocalizationsDelegate<dynamic>>(
          'localizationsDelegates',
          localizationsDelegates,
        ),
      )
      ..add(
        ObjectFlagProperty<LocaleListResolutionCallback?>.has(
          'localeListResolutionCallback',
          localeListResolutionCallback,
        ),
      )
      ..add(
        ObjectFlagProperty<LocaleResolutionCallback?>.has(
          'localeResolutionCallback',
          localeResolutionCallback,
        ),
      )
      ..add(IterableProperty<Locale>('supportedLocales', supportedLocales))
      ..add(
        DiagnosticsProperty<bool>(
          'showPerformanceOverlay',
          showPerformanceOverlay,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'checkerboardRasterCacheImages',
          checkerboardRasterCacheImages,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'checkerboardOffscreenLayers',
          checkerboardOffscreenLayers,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'showSemanticsDebugger',
          showSemanticsDebugger,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'debugShowCheckedModeBanner',
          debugShowCheckedModeBanner,
        ),
      )
      ..add(
        DiagnosticsProperty<Map<ShortcutActivator, Intent>?>(
          'shortcuts',
          shortcuts,
        ),
      )
      ..add(DiagnosticsProperty<Map<Type, Action<Intent>>?>('actions', actions))
      ..add(StringProperty('restorationScopeId', restorationScopeId))
      ..add(
        DiagnosticsProperty<ScrollBehavior?>(
          'scrollBehavior',
          scrollBehavior,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'debugShowMaterialGrid',
          debugShowMaterialGrid,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'useInheritedMediaQuery',
          useInheritedMediaQuery,
        ),
      )
      ..add(
        DiagnosticsProperty<FluPage<dynamic>?>('unknownRoute', unknownRoute),
      )
      ..add(
        DiagnosticsProperty<GlobalKey<NavigatorState>?>(
          'navigatorKey',
          navigatorKey,
        ),
      )
      ..add(
        DiagnosticsProperty<GlobalKey<ScaffoldMessengerState>?>(
          'scaffoldMessengerKey',
          scaffoldMessengerKey,
        ),
      )
      ..add(
        ObjectFlagProperty<RouteFactory?>.has(
          'onUnknownRoute',
          onUnknownRoute,
        ),
      )
      ..add(
        IterableProperty<NavigatorObserver>(
          'navigatorObservers',
          navigatorObservers,
        ),
      )
      ..add(ObjectFlagProperty<TransitionBuilder?>.has('builder', builder))
      ..add(StringProperty('title', title))
      ..add(
        ObjectFlagProperty<GenerateAppTitle?>.has(
          'onGenerateTitle',
          onGenerateTitle,
        ),
      )
      ..add(DiagnosticsProperty<ThemeData?>('theme', theme))
      ..add(DiagnosticsProperty<ThemeData?>('darkTheme', darkTheme))
      ..add(
        DiagnosticsProperty<ThemeData?>(
          'highContrastTheme',
          highContrastTheme,
        ),
      )
      ..add(
        DiagnosticsProperty<ThemeData?>(
          'highContrastDarkTheme',
          highContrastDarkTheme,
        ),
      )
      ..add(EnumProperty<ThemeMode?>('themeMode', themeMode))
      ..add(
        DiagnosticsProperty<Duration>(
          'themeAnimationDuration',
          themeAnimationDuration,
        ),
      )
      ..add(
        DiagnosticsProperty<Curve>(
          'themeAnimationCurve',
          themeAnimationCurve,
        ),
      )
      ..add(ColorProperty('color', color))
      ..add(DiagnosticsProperty<Locale?>('locale', locale))
      ..add(
        IterableProperty<LocalizationsDelegate<dynamic>>(
          'localizationsDelegates',
          localizationsDelegates,
        ),
      )
      ..add(
        ObjectFlagProperty<LocaleListResolutionCallback?>.has(
          'localeListResolutionCallback',
          localeListResolutionCallback,
        ),
      )
      ..add(
        ObjectFlagProperty<LocaleResolutionCallback?>.has(
          'localeResolutionCallback',
          localeResolutionCallback,
        ),
      )
      ..add(IterableProperty<Locale>('supportedLocales', supportedLocales))
      ..add(
        DiagnosticsProperty<bool>(
          'showPerformanceOverlay',
          showPerformanceOverlay,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'checkerboardRasterCacheImages',
          checkerboardRasterCacheImages,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'checkerboardOffscreenLayers',
          checkerboardOffscreenLayers,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'showSemanticsDebugger',
          showSemanticsDebugger,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'debugShowCheckedModeBanner',
          debugShowCheckedModeBanner,
        ),
      )
      ..add(
        DiagnosticsProperty<Map<ShortcutActivator, Intent>?>(
          'shortcuts',
          shortcuts,
        ),
      )
      ..add(DiagnosticsProperty<Map<Type, Action<Intent>>?>('actions', actions))
      ..add(StringProperty('restorationScopeId', restorationScopeId))
      ..add(
        DiagnosticsProperty<ScrollBehavior?>(
          'scrollBehavior',
          scrollBehavior,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'debugShowMaterialGrid',
          debugShowMaterialGrid,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'useInheritedMediaQuery',
          useInheritedMediaQuery,
        ),
      );
  }
}

class _FluMaterialAppState extends State<FluMaterialApp> {
  late final GlobalKey<NavigatorState> _navigatorKey;
  late final List<FluPage<dynamic>> pages;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<GlobalKey<NavigatorState>?>(
          'navigatorKey',
          _navigatorKey,
        ),
      )
      ..add(IterableProperty<FluPage<dynamic>>('pages', pages));
  }

  @override
  void initState() {
    _navigatorKey =
        Flu.navigatorKey = widget.navigatorKey ?? GlobalKey<NavigatorState>();
    pages = widget.pages ?? _kDefaultPages;
    super.initState();
  }

  String get _initialRoute {
    try {
      return pages.singleWhere((page) => page.initial).name!;
    } on Exception {
      throw Exception(
        // ignore: lines_longer_than_80_chars
        'One of provided pages must be marked as initial! Set the `initial` property of one of your pages to `true` in order to get it as initial route.',
      );
    }
  }

  FluPageRoute<dynamic> _findPageAndReturnRoute(
    RouteSettings settings,
    List<FluPage<dynamic>> pages,
    FluPage<dynamic>? unknownRoute,
  ) {
    final index = pages.indexWhere((page) => page.name == settings.name);

    return index > -1
        ? pages[index].copyWith(arguments: settings.arguments).toRoute()
        : buildUnknownRoute(unknownRoute, settings.name);
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        key: widget.key,
        navigatorKey: _navigatorKey,
        scaffoldMessengerKey: widget.scaffoldMessengerKey,
        initialRoute: _initialRoute,
        onGenerateRoute: (settings) =>
            _findPageAndReturnRoute(settings, pages, widget.unknownRoute),
        onGenerateInitialRoutes: (route) => [
          _findPageAndReturnRoute(
            RouteSettings(name: route),
            pages,
            widget.unknownRoute,
          ),
        ],
        onUnknownRoute: widget.onUnknownRoute,
        navigatorObservers: [
          if (widget.showNavigationLogs) FluNavObserver(),
          ...widget.navigatorObservers,
        ],
        builder: widget.builder,
        title: widget.title,
        onGenerateTitle: widget.onGenerateTitle,
        color: widget.color,
        theme: widget.theme,
        darkTheme: widget.darkTheme,
        themeMode: widget.themeMode,
        locale: widget.locale,
        localizationsDelegates: widget.localizationsDelegates,
        localeListResolutionCallback: widget.localeListResolutionCallback,
        localeResolutionCallback: widget.localeResolutionCallback,
        supportedLocales: widget.supportedLocales,
        debugShowMaterialGrid: widget.debugShowMaterialGrid,
        showPerformanceOverlay: widget.showPerformanceOverlay,
        checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
        showSemanticsDebugger: widget.showSemanticsDebugger,
        debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
        shortcuts: widget.shortcuts,
        scrollBehavior: widget.scrollBehavior,
      );
}
