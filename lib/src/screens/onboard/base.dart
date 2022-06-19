import 'dart:math' as math;

import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class FluOnboardingScreen extends StatefulWidget {
  final List<FluOnboardingScreenPage> pages;
  final Duration animationDuration;
  final Curve animationCurve;
  final String mainButtonText, prevButtonText, nextButtonText, skipButtonText;
  final FluIconModel? mainButtonIcon;
  final void Function() onLeaving;

  const FluOnboardingScreen({
    Key? key,
    required this.pages,
    required this.onLeaving,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.fastOutSlowIn,
    this.mainButtonText = 'Get Started',
    this.prevButtonText = 'Back',
    this.nextButtonText = 'Next',
    this.skipButtonText = 'Skip',
    this.mainButtonIcon
  }) : super(key: key);

  @override
  State<FluOnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<FluOnboardingScreen> {
  final FluOnboardingScreenController controller = Get.put(
    FluOnboardingScreenController(),
    tag: 'FluOnboardingScreenController#${math.Random().nextInt(99999)}'
  );
  final PageController pageController = PageController();

  bool onFirstPage = false, onLastPage = false;

  void onInit() async {
    await Flukit.appController.setFirstTimeOpeningState(false)
      .onError((error, stackTrace) => throw {"Error while setting firstTimeOpening parameter in secure storage.", error, stackTrace});
  }
  void onBack(BuildContext context) {
    if(!onFirstPage) {
      pageController.previousPage(duration: widget.animationDuration, curve: widget.animationCurve);
    } else {
      pageController.jumpToPage(widget.pages.length - 1); //, duration: animationDuration, curve: animationCurve
    }
  }
  void onForward(BuildContext context) async {
    if(!onLastPage) {
      pageController.nextPage(duration: widget.animationDuration, curve: widget.animationCurve);
    } else {
      widget.onLeaving();
    }
  }

  @override
  void initState() {
    onInit();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) => FluScreen(
    body: GetX<FluOnboardingScreenController>(
      init: controller,
      initState: (_) {},
      builder: (_) {
        onFirstPage = controller.currentIndex == 0;
        onLastPage = controller.currentIndex == widget.pages.length - 1;

        return Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (v) => controller.currentIndex = v,
                itemCount: widget.pages.length,
                itemBuilder: (context, index) {
                  FluOnboardingScreenPage page = widget.pages[index];
                  bool isCurrent = controller.currentIndex == index;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Flukit.theme.data.colorScheme.secondary,
                              Flukit.theme.data.backgroundColor
                            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
                          ),
                          child: AnimatedScale(
                            scale: isCurrent ? 1 : 0,
                            duration: widget.animationDuration,
                            curve: widget.animationCurve,
                            child: page.image.isNotEmpty ? FluImage(
                              image: page.image,
                              type: page.imageType,
                            ) : null
                          ),
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Flukit.appConsts.defaultPaddingSize
                        ).copyWith(bottom: Flukit.screenSize.height * .075, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Hero(
                              tag: '<title_text>',
                              child: Text(page.title, textAlign: TextAlign.center, style: Flukit.textTheme.headline1?.copyWith(
                                fontSize: Flukit.appConsts.headlineFs
                              )),
                            ),
                            const SizedBox(height: 5),
                            Hero(tag: '<desc_text>', child: Text(page.desc, textAlign: TextAlign.center, style: Flukit.textTheme.bodyText1)),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Flukit.appConsts.defaultPaddingSize
              ).copyWith(bottom: 15),
              child: AnimatedSwitcher(
                duration: widget.animationDuration,
                transitionBuilder: (child, animation) => SlideTransition(
                  position: Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(animation),
                  child: child,
                ),
                child: !onLastPage ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  FluButton.text(
                    onPressed: () => onBack(context),
                    text: onFirstPage ? widget.skipButtonText : widget.prevButtonText,
                    textStyle: TextStyle(
                      fontWeight: Flukit.appConsts.textSemibold
                    ),
                    style: FluButtonStyle(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      color: Flukit.themePalette.accentText,
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count:  widget.pages.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Flukit.theme.data.primaryColor,
                      dotHeight: 4,
                      dotWidth: 4,
                      expansionFactor: 8
                    )
                  ),
                  FluButton.text(
                    onPressed: () => onForward(context),
                    text: onLastPage ? widget.mainButtonText : widget.nextButtonText,
                    textStyle: TextStyle(
                      fontWeight: Flukit.appConsts.textSemibold
                    ),
                    style: FluButtonStyle(
                      height: Flukit.appConsts.defaultElSize,
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      color: Flukit.themePalette.accentText,
                    ),
                  )
                ]) : Hero(
                  tag: '<main_button>',
                  child: FluButton.text(
                    onPressed: () => onForward(context),
                    text: widget.mainButtonText,
                    prefixIcon: widget.mainButtonIcon ?? FluBulkIcons.essentional_flash,
                    textStyle: TextStyle(
                      fontWeight: Flukit.appConsts.textBold
                    ),
                    style: FluButtonStyle(
                      height: Flukit.appConsts.defaultElSize,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      color: Flukit.themePalette.primaryText,
                      backgroundColor: Flukit.themeData.primaryColor,
                      iconStyle: FluIconStyle(
                        size: 24,
                        strokeWidth: 1.8,
                      )
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    )
  );
}