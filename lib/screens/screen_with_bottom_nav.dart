import 'package:flukit/flukit.dart';
import 'package:flukit/widgets/bottom_navigation.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FluScreenWithBottomNav extends StatefulWidget {
  const FluScreenWithBottomNav({
    super.key,
    this.bottomNavBarType = FluBottomNavBarTypes.flat,
    required this.pages,
    this.onPageChange,
    this.animationDuration = const Duration(milliseconds: 400),
    this.animationCurve = Curves.decelerate,
    this.initialPage = 0,
    this.physics,
    this.overlayStyle,
    this.bottomNavPadding,
    this.bottomNavHeight,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerDocked,
    this.floatingActionButton,
  });

  final void Function(int)? onPageChange;
  final Curve animationCurve;
  final Duration animationDuration;
  final FluBottomNavBarTypes bottomNavBarType;
  final double? bottomNavHeight;
  final EdgeInsets? bottomNavPadding;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final int initialPage;
  final SystemUiOverlayStyle? overlayStyle;
  final List<FluScreenPage> pages;
  final ScrollPhysics? physics;

  @override
  State<FluScreenWithBottomNav> createState() => _FluScreenWithBottomNavState();
}

class _FluScreenWithBottomNavState extends State<FluScreenWithBottomNav> {
  late final PageController _pageController;
  final List<FluScreenPage> _pages = [];

  int _currentPage = 0;

  @override
  void didUpdateWidget(covariant FluScreenWithBottomNav oldWidget) {
    loadPages();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    loadPages();
    _pageController = PageController(initialPage: widget.initialPage);
    super.initState();
  }

  void loadPages() {
    for (var page in widget.pages) {
      _pages.addIf(page.content != null, page);
    }
  }

  void _onItemTap(int index) {
    final page = widget.pages[index];

    if (_pages.contains(page)) {
      final pageIndex = _pages.indexOf(page);
      var diff = pageIndex - _currentPage;

      if (diff >= 2 || diff <= -2) {
        _pageController.jumpToPage(pageIndex);
      } else {
        _pageController.animateToPage(pageIndex,
            duration: widget.animationDuration, curve: widget.animationCurve);
      }
    } else {
      widget.pages[index].onNavigateTo?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FluScreen(
      overlayStyle: widget.overlayStyle,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) => setState(() => _currentPage = value),
        itemCount: _pages.length,
        itemBuilder: (context, index) {
          print('$index ${_pages[index].content}');
          return _pages[index].content;
        },
      ),
      bottomNavigationBar: FluBottomNavBar(
        type: widget.bottomNavBarType,
        padding: widget.bottomNavPadding,
        height: widget.bottomNavHeight,
        items: widget.pages
            .map((page) => FluBottomNavBarItem(page.icon, page.label))
            .toList(),
        onItemTap: _onItemTap,
      ),
    );
  }
}

/// Creates a page that will be displayed on [FluScreenWithBottomNav].
class FluScreenPage {
  FluScreenPage({
    required this.icon,
    required this.label,
    this.content,
    this.onNavigateTo,
  }) : assert(content != null || onNavigateTo != null);

  final Widget? content;
  final FluIcons icon;
  final String label;
  final VoidCallback? onNavigateTo;
}
