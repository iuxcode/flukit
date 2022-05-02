import 'package:flukit/src/controllers/flu_controllers.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../flukit.dart';

class FluTabScreen extends StatefulWidget {
  final int initialPage;
  final List<Widget> pages;
  final List<FluBottomNavBarItemData> bottomNavBarItems;
  final FluTabScreenController? controller;
  final Color? bottomNavBarColor;
  final Duration animationDuration;
  final Curve animationCurve;

  const FluTabScreen({
    Key? key,
    required this.pages,
    required this.bottomNavBarItems,
    this.initialPage = 0,
    this.controller,
    this.animationDuration = const Duration(milliseconds: 400),
    this.animationCurve = Curves.decelerate,
    this.bottomNavBarColor,
  }): assert(pages.length > 0 && bottomNavBarItems.length > 0 && pages.length == bottomNavBarItems.length), super(key: key);

  @override
  State<FluTabScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<FluTabScreen> {
  late FluTabScreenController controller;
  late PageController pageController;

  @override
  void initState() {
    controller = Get.put(widget.controller ?? FluTabScreenController());
    pageController = PageController(initialPage: widget.initialPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FluScreen(
    extendBody: true,
    body: PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: widget.pages.map((page) => page).toList()
    ),
    bottomNavigationBar: Obx(() => FluBottomNavBar(
      selectedIndex: controller.currentIndex,
      onTap: (index) {
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
        Flukit.mediumImpactHaptic();
      },
      background: widget.bottomNavBarColor ?? Flukit.themePalette.dark,
      color: Flukit.themePalette.light,
      activeColor: Flukit.theme.primaryColor,
      duration: widget.animationDuration,
      curve: widget.animationCurve,
      items: widget.bottomNavBarItems,
    )
  ));
}