import 'package:flukit/flukit.dart';
import 'package:flukit_icons/icons.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_navigation.dart';

class FluNavScreen extends StatelessWidget {
  FluNavScreen({
    super.key,
    required this.pages,
    this.initialPage = 0,
    GlobalKey<NavigatorState>? navigatorKey,
    this.onNav,
  }) : navigatorKey = navigatorKey ?? GlobalKey<NavigatorState>();

  final void Function(int)? onNav;
  final List<FluNavPage> pages;
  final int initialPage;
  GlobalKey<NavigatorState> navigatorKey;

  List<FluNavPage> get validPages =>
      pages..removeWhere((p) => p.content == null);

  Map<String, Widget Function(BuildContext)> get _routes => {
        for (var page in validPages)
          page.path: (BuildContext context) => page.content!
      };

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    final String? name = settings.name;
    final index = validPages.indexWhere((page) => page.path == name);

    if (index > -1) {
      return FluPage(
        name: name,
        arguments: settings.arguments,
        page: () => validPages[index].content!,
      ).toRoute();
    }

    return buildUnknownRoute(null, name);
  }

  void _navigateTo(BuildContext context, int index) {
    FluNavPage page = pages[index];

    if (page.content != null && navigatorKey.currentState != null) {
      navigatorKey.currentState!.pushReplacementNamed(page.path);
      onNav?.call(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle
          .copyWith(statusBarColor: Colors.transparent),
      body: SafeArea(
        child: Navigator(
          key: navigatorKey,
          restorationScopeId: 'MainScreenNav',
          initialRoute: pages[0].path,
          onGenerateRoute: _onGenerateRoute,
          onUnknownRoute: (settings) => buildUnknownRoute(null, settings.name),
        ),
      ),
      bottomNavigationBar: FluBottomNavBar(
        onItemTap: (index) => _navigateTo(context, index),
        items: pages
            .map((page) => FluBottomNavBarItem(page.icon, page.name))
            .toList(),
        style: const FluBottomNavBarStyle(),
      ),
    );
  }
}

class FluNavPage {
  FluNavPage(this.name, this.icon, this.content);

  final Widget? content;
  final FluIcons icon;
  final String name;

  String get path => '/$name';
}
