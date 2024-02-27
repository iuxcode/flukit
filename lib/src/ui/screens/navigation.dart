import 'package:flukit/flukit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FluNavScreen extends StatefulWidget {
  const FluNavScreen({
    required this.pages,
    super.key,
    this.initialPage = 0,
    this.navigatorKey,
    this.onNav,
    this.canPop = false,
    this.bottomNavBarStyle,
    this.appBar,
    this.overlayStyle,
    this.floatingActionButton,
    this.extendBody,
    this.background,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerDocked,
    this.drawer,
    this.endDrawer,
    this.scaffoldKey,
    this.drawerScrimColor,
  });

  final void Function(int)? onNav;
  final FluBottomNavBarStyle Function(int currentPage)? bottomNavBarStyle;
  final PreferredSizeWidget? appBar;
  final bool canPop;
  final Color? background, drawerScrimColor;
  final Widget? drawer, endDrawer;
  final bool? extendBody;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final int initialPage;
  final GlobalKey<NavigatorState>? navigatorKey;
  final SystemUiOverlayStyle? overlayStyle;
  final List<FluNavPage> pages;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  State<FluNavScreen> createState() => _FluNavScreenState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<void Function(int p1)?>.has('onNav', onNav))
      ..add(IterableProperty<FluNavPage>('pages', pages))
      ..add(IntProperty('initialPage', initialPage))
      ..add(
        DiagnosticsProperty<GlobalKey<NavigatorState>?>(
          'navigatorKey',
          navigatorKey,
        ),
      )
      ..add(DiagnosticsProperty<bool>('canPop', canPop))
      ..add(
        ObjectFlagProperty<
            FluBottomNavBarStyle Function(
              int currentPage,
            )?>.has('bottomNavBarStyle', bottomNavBarStyle),
      )
      ..add(ColorProperty('background', background))
      ..add(ColorProperty('drawerScrimColor', drawerScrimColor))
      ..add(DiagnosticsProperty<bool?>('extendBody', extendBody))
      ..add(
        DiagnosticsProperty<FloatingActionButtonLocation>(
          'floatingActionButtonLocation',
          floatingActionButtonLocation,
        ),
      )
      ..add(
        DiagnosticsProperty<SystemUiOverlayStyle?>(
          'overlayStyle',
          overlayStyle,
        ),
      )
      ..add(
        DiagnosticsProperty<GlobalKey<ScaffoldState>?>(
          'scaffoldKey',
          scaffoldKey,
        ),
      )
      ..add(IterableProperty<FluNavPage>('pages', pages))
      ..add(IntProperty('initialPage', initialPage))
      ..add(
        DiagnosticsProperty<GlobalKey<NavigatorState>?>(
          'navigatorKey',
          navigatorKey,
        ),
      )
      ..add(DiagnosticsProperty<bool>('canPop', canPop))
      ..add(
        ObjectFlagProperty<
            FluBottomNavBarStyle Function(
              int currentPage,
            )?>.has('bottomNavBarStyle', bottomNavBarStyle),
      )
      ..add(ColorProperty('background', background))
      ..add(ColorProperty('drawerScrimColor', drawerScrimColor))
      ..add(DiagnosticsProperty<bool?>('extendBody', extendBody))
      ..add(
        DiagnosticsProperty<FloatingActionButtonLocation>(
          'floatingActionButtonLocation',
          floatingActionButtonLocation,
        ),
      )
      ..add(
        DiagnosticsProperty<SystemUiOverlayStyle?>(
          'overlayStyle',
          overlayStyle,
        ),
      )
      ..add(
        DiagnosticsProperty<GlobalKey<ScaffoldState>?>(
          'scaffoldKey',
          scaffoldKey,
        ),
      )
      ..add(IterableProperty<FluNavPage>('pages', pages))
      ..add(IntProperty('initialPage', initialPage))
      ..add(
        DiagnosticsProperty<GlobalKey<NavigatorState>?>(
          'navigatorKey',
          navigatorKey,
        ),
      )
      ..add(DiagnosticsProperty<bool>('canPop', canPop))
      ..add(
        ObjectFlagProperty<
            FluBottomNavBarStyle Function(
              int currentPage,
            )?>.has('bottomNavBarStyle', bottomNavBarStyle),
      )
      ..add(ColorProperty('background', background))
      ..add(ColorProperty('drawerScrimColor', drawerScrimColor))
      ..add(DiagnosticsProperty<bool?>('extendBody', extendBody))
      ..add(
        DiagnosticsProperty<FloatingActionButtonLocation>(
          'floatingActionButtonLocation',
          floatingActionButtonLocation,
        ),
      )
      ..add(
        DiagnosticsProperty<SystemUiOverlayStyle?>(
          'overlayStyle',
          overlayStyle,
        ),
      )
      ..add(
        DiagnosticsProperty<GlobalKey<ScaffoldState>?>(
          'scaffoldKey',
          scaffoldKey,
        ),
      )
      ..add(IterableProperty<FluNavPage>('pages', pages))
      ..add(IntProperty('initialPage', initialPage))
      ..add(
        DiagnosticsProperty<GlobalKey<NavigatorState>?>(
          'navigatorKey',
          navigatorKey,
        ),
      )
      ..add(DiagnosticsProperty<bool>('canPop', canPop))
      ..add(
        ObjectFlagProperty<
            FluBottomNavBarStyle Function(
              int currentPage,
            )?>.has('bottomNavBarStyle', bottomNavBarStyle),
      )
      ..add(ColorProperty('background', background))
      ..add(ColorProperty('drawerScrimColor', drawerScrimColor))
      ..add(DiagnosticsProperty<bool?>('extendBody', extendBody))
      ..add(
        DiagnosticsProperty<FloatingActionButtonLocation>(
          'floatingActionButtonLocation',
          floatingActionButtonLocation,
        ),
      )
      ..add(
        DiagnosticsProperty<SystemUiOverlayStyle?>(
          'overlayStyle',
          overlayStyle,
        ),
      )
      ..add(
        DiagnosticsProperty<GlobalKey<ScaffoldState>?>(
          'scaffoldKey',
          scaffoldKey,
        ),
      );
  }
}

class _FluNavScreenState extends State<FluNavScreen> {
  late final GlobalKey<NavigatorState> _navigatorKey;

  late int _currentPage;
  late bool _mustExtendBody;

  @override
  void initState() {
    _navigatorKey = widget.navigatorKey ?? GlobalKey<NavigatorState>();
    _currentPage = widget.initialPage;
    _mustExtendBody = widget.pages[_currentPage].extendBody;
    super.initState();
  }

  Future<void> onPopInvoked(bool didPop) async {
    if (!didPop && !widget.canPop && _currentPage != 0) {
      for (var i = _currentPage - 1; i >= 0; i--) {
        if (widget.pages[i].content != null) {
          await _navigateTo(context, i);
          break;
        }
      }
    }
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    final name = settings.name;
    final index = widget.pages
        .indexWhere((page) => page.path == name && page.content != null);

    if (index > -1) {
      return FluPage<dynamic>(
        name: name!,
        arguments: settings.arguments,
        page: widget.pages[index].content!,
        transition: index > _currentPage
            ? PageTransitions.rightToLeft
            : PageTransitions.leftToRight,
      ).toRoute();
    }

    return buildUnknownRoute(null, name);
  }

  Future<void> _navigateTo(BuildContext context, int index) async {
    final page = widget.pages[index];

    if (index != _currentPage && page.content != null) {
      await _navigatorKey.currentState?.pushNamed(page.path);
    }

    setState(() {
      _currentPage = index;
      _mustExtendBody = widget.pages[index].extendBody;
    });

    widget.onNav?.call(index);
  }

  @override
  Widget build(BuildContext context) => PopScope(
        onPopInvoked: onPopInvoked,
        child: FluScreen(
          overlayStyle: context.systemUiOverlayStyle
              .copyWith(statusBarColor: Colors.transparent),
          key: widget.scaffoldKey,
          background: widget.background,
          extendBody: widget.extendBody ?? _mustExtendBody,
          appBar: widget.appBar,
          floatingActionButtonLocation: widget.floatingActionButtonLocation,
          floatingActionButton: widget.floatingActionButton,
          drawer: widget.drawer,
          endDrawer: widget.endDrawer,
          drawerScrimColor: widget.drawerScrimColor,
          body: Navigator(
            key: _navigatorKey,
            restorationScopeId: 'MainScreenNav',
            initialRoute: widget.pages[0].path,
            onGenerateRoute: _onGenerateRoute,
            onUnknownRoute: (settings) =>
                buildUnknownRoute(null, settings.name),
          ),
          bottomNavigationBar: FluBottomNavBar(
            index: _currentPage,
            onItemTap: (index) async {
              await _navigateTo(context, index);
            },
            items: widget.pages
                .map((page) => FluBottomNavBarItem(page.icon, page.name))
                .toList(),
            style: widget.bottomNavBarStyle?.call(_currentPage) ??
                const FluBottomNavBarStyle(),
          ),
        ),
      );
}

/// Define a [FluNavScreen] page.
/// The `name` represent the page name, `icon`, the corresponding icon in the
/// [FluBottomNavBar], `content`, the page body content, and `extendBody` must
/// be marked to true if you want the [content] to extends
/// to the bottom of the Scaffold, instead of only extending to the top of
/// the `bottomNavigationBar` or the `persistentFooterButtons`.
class FluNavPage {
  // ignore: public_member_api_docs
  FluNavPage(this.name, this.icon, this.content, {this.extendBody = false});

  /// page body content
  final Widget? content;

  /// if marked to `true`, the [content] will extends
  /// to the bottom of the Scaffold, instead of only extending to the top of
  /// the `bottomNavigationBar` or the `persistentFooterButtons`.
  final bool extendBody;

  /// corresponding icon in the [FluBottomNavBar]
  final FluIcons icon;

  /// Page name
  final String name;

  /// Routing path of this page.
  String get path => '/$name';
}
