import 'package:flukit/src/controllers/flu_controllers.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../flukit.dart';

class FluTabScreen extends StatefulWidget {
  final int initialPage;
  final List<Widget> Function(FluTabScreenController controller, PageController pageController) pages;
  final List<FluBottomNavBarItemData> bottomNavBarItems;
  final FluTabScreenController? controller;
  final Color? bottomNavBarColor;
  final Duration animationDuration;
  final Curve animationCurve;
  final ScrollPhysics? physics;
  final void Function(FluTabScreenController controller, PageController pageController)? onPageChange;

  const FluTabScreen({
    Key? key,
    required this.pages,
    required this.bottomNavBarItems,
    this.initialPage = 0,
    this.controller,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.decelerate,
    this.bottomNavBarColor,
    this.physics,
    this.onPageChange
  }): super(key: key);

  @override
  State<FluTabScreen> createState() => _FluTabScreenState();
}

class _FluTabScreenState extends State<FluTabScreen> {
  late FluTabScreenController controller;
  late PageController pageController;

  void onPageChange(index) {
    var diff = index - controller.currentIndex;

    if(diff >= 2 || diff <= -2) {
      pageController.jumpToPage(index);
    } else {
      pageController.animateToPage(
        index,
        duration: widget.animationDuration,
        curve: widget.animationCurve
      );
    }

    controller.currentIndex = index.toDouble();
    Flukit.selectionClickHaptic();
    widget.onPageChange?.call(controller, pageController);
  }

  @override
  void initState() {
    controller = Get.put(widget.controller ?? FluTabScreenController());
    pageController = PageController(initialPage: widget.initialPage);
    
    assert(
      widget.pages(controller, pageController).isNotEmpty &&
      widget.bottomNavBarItems.isNotEmpty &&
      widget.pages(controller, pageController).length == widget.bottomNavBarItems.length
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) => FluScreen(
    extendBody: true,
    body: PageView(
      controller: pageController,
      onPageChanged: onPageChange,
      physics: widget.physics ?? const NeverScrollableScrollPhysics(),
      children: widget.pages(controller, pageController).map((page) => page).toList()
    ),
    bottomNavigationBar: Obx(() => FluBottomNavBar(
      selectedIndex: controller.currentIndex,
      onTap: onPageChange,
      background: widget.bottomNavBarColor ?? Flukit.themePalette.dark,
      color: Flukit.themePalette.light,
      activeColor: Flukit.theme.primaryColor,
      duration: widget.animationDuration,
      curve: widget.animationCurve,
      items: widget.bottomNavBarItems,
    ))
  );
}