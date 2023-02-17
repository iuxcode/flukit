import 'package:flukit/flukit.dart';
import 'package:flukit/widgets/bottom_navigation.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

class FluScreenWithBottomNav extends StatefulWidget {
  const FluScreenWithBottomNav({
    super.key,
    required this.bottomNavBarType,
    required this.pages,
    this.onPageChange,
    this.animationDuration = const Duration(milliseconds: 400),
    this.animationCurve = Curves.decelerate,
    this.initialPage = 0,
    this.physics,
  });

  final void Function(int)? onPageChange;
  final Curve animationCurve;
  final Duration animationDuration;
  final FluBottomNavBarTypes bottomNavBarType;
  final int initialPage;
  final List<FluScreenPage> pages;
  final ScrollPhysics? physics;

  @override
  State<FluScreenWithBottomNav> createState() => _FluScreenWithBottomNavState();
}

class _FluScreenWithBottomNavState extends State<FluScreenWithBottomNav> {
  late final PageController _pageController;

  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.initialPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FluScreen(
      body: PageView.builder(
        onPageChanged: (value) => setState(() => _currentPage = value),
        itemCount: widget.pages.length,
        itemBuilder: (context, index) => widget.pages[index].content,
      ),
      bottomNavigationBar: FluBottomNavBar(
        type: widget.bottomNavBarType,
        items: widget.pages
            .map((page) => FluBottomNavBarItem(page.icon, page.label))
            .toList(),
        onItemTap: (index) => _pageController.animateToPage(
          index,
          duration: widget.animationDuration,
          curve: widget.animationCurve,
        ),
      ),
    );
  }
}

/// Creates a page that will be displayed on [FluScreenWithBottomNav].
class FluScreenPage {
  FluScreenPage({
    required this.icon,
    required this.label,
    required this.content,
  });

  final Widget content;
  final FluIcons icon;
  final String label;
}
