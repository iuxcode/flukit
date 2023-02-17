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
  });

  final void Function(int)? onPageChange;
  final Curve animationCurve;
  final Duration animationDuration;
  final FluBottomNavBarTypes bottomNavBarType;
  final int initialPage;
  final List<FluScreenPage> pages;
  final ScrollPhysics? physics;
  final SystemUiOverlayStyle? overlayStyle;

  final EdgeInsets? bottomNavPadding;
  final double? bottomNavHeight;

  @override
  State<FluScreenWithBottomNav> createState() => _FluScreenWithBottomNavState();
}

class _FluScreenWithBottomNavState extends State<FluScreenWithBottomNav> {
  late final PageController _pageController;

  List<FluScreenPage> _pages = [];
  int _currentPage = 0;

  void _onItemTap(int index) {
    if (widget.pages[index].content != null) {
      _pageController.animateToPage(
        index,
        duration: widget.animationDuration,
        curve: widget.animationCurve,
      );
    } else {
      widget.pages[index].onNavigateTo?.call();
    }
  }

  @override
  void initState() {
    for (var page in widget.pages) {
      _pages.addIf(page.content != null, page);
    }
    _pageController = PageController(initialPage: widget.initialPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FluScreen(
      overlayStyle: widget.overlayStyle,
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) => setState(() => _currentPage = value),
        itemCount: _pages.length,
        itemBuilder: (context, index) => _pages[index].content,
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
  final VoidCallback? onNavigateTo;
  final FluIcons icon;
  final String label;
}
