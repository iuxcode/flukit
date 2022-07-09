import 'package:flukit/src/controllers/tab_screen_controller.dart';
import 'package:flukit/src/models/tab_screen.dart';
import 'package:flukit/src/screens/base.dart';
import 'package:flukit/src/utils/flu_utils.dart';
import 'package:flukit/src/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FluTabScreen extends StatefulWidget {
  final bool isMainScreen;
  final int initialPage;
  final Duration animationDuration;
  final Curve animationCurve;
  final ScrollPhysics? physics;
  final FluTabScreenController? controller;
  final FluBottomNavBarStyle? bottomNavBarStyle;
  final List<FluTabScreenPage> Function(FluTabScreenController controller, PageController pageController) pages;
  final void Function(FluTabScreenController controller, PageController pageController)? onPageChange;

  const FluTabScreen({
    Key? key,
    required this.pages,
    this.isMainScreen = true,
    this.initialPage = 0,
    this.controller,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.decelerate,
    this.bottomNavBarStyle,
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
  }

  void onInit() async {
    if(widget.isMainScreen) {
      await Flukit.appController.setAuthorizationState(FluAuthorizationStates.ready)
        .onError((error, stackTrace) => throw {"Error while setting authorizationState parameter in secure storage.", error, stackTrace});
    }
  }

  @override
  void initState() {
    onInit();

    controller = Get.put(widget.controller ?? FluTabScreenController());
    pageController = PageController(initialPage: widget.initialPage);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<FluTabScreenPage> pages = widget.pages(controller, pageController);
    
    return FluScreen(
      extendBody: true,
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChange,
        physics: widget.physics ?? const NeverScrollableScrollPhysics(),
        children: pages.map((page) => page.content).toList()
      ),
      bottomNavigationBar: Obx(() => FluBottomNavBar(
        selectedIndex: controller.currentIndex,
        onItemTap: (index) {
          onPageChange(index);
          controller.currentIndex = index.toDouble();
          Flukit.selectionClickHaptic();
          widget.onPageChange?.call(controller, pageController);
        },
        style: widget.bottomNavBarStyle,
        items: pages.map((page) => FluBottomNavBarItem(
          icon: page.icon,
          filledIcon: page.filledIcon,
          label: page.name,
        )).toList()
      ))
    );
  }
}