import 'dart:math' as math;

import 'package:flukit/flukit.dart';
import 'package:flukit/src/models/flu_models.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../configs/theme/tweaks.dart';
import '../../controllers/flu_controllers.dart';

class FluOnboardingScreen extends StatefulWidget {
  final List<FluOnboardingScreenPageModel> pages;
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
  final FluOnboardingScreenController controller = Get.put(FluOnboardingScreenController(), tag: 'FluOnboardingScreenController' + math.Random().nextInt(99999).toString());
  final PageController pageController = PageController();

  bool onFirstPage = false, onLastPage = false;

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
                controller: pageController..addListener(() => controller.pageOffset = pageController.page!),
                onPageChanged: (v) => controller.currentIndex = v,
                itemCount: widget.pages.length,
                itemBuilder: (context, index) {
                  FluOnboardingScreenPageModel page = widget.pages[index];
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
                          horizontal: FluConsts.defaultPaddingSize
                        ).copyWith(bottom: Flukit.screenSize.height * .065, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Hero(
                              tag: '< title_text >',
                              child: Text(page.title, textAlign: TextAlign.center, style: Flukit.textTheme.headline1?.copyWith(
                                fontSize: FluConsts.headlineFs
                              )),
                            ),
                            const SizedBox(height: 5),
                            Hero(tag: '< desc_text >', child: Text(page.desc, textAlign: TextAlign.center, style: Flukit.textTheme.bodyText1)),
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
                horizontal: FluConsts.defaultPaddingSize
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
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    color: Flukit.themePalette.accentText,
                    text: onFirstPage ? widget.skipButtonText : widget.prevButtonText,
                    textStyle: TextStyle(
                      fontWeight: FluConsts.textSemibold
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
                    height: FluConsts.defaultElSize,
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    color: Flukit.themePalette.accentText,
                    text: onLastPage ? widget.mainButtonText : widget.nextButtonText,
                    textStyle: TextStyle(
                      fontWeight: FluConsts.textSemibold
                    ),
                  )
                ]) : Hero(
                  tag: '< main_button >',
                  child: FluButton.text(
                    onPressed: () => onForward(context),
                    height: FluConsts.defaultElSize,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    text: widget.mainButtonText,
                    prefixIcon: widget.mainButtonIcon ?? FluBulkIcons.essentional_flash,
                    iconSize: 24,
                    iconStrokeWidth: 1.8,
                    color: Flukit.themePalette.primaryText,
                    backgroundColor: Flukit.themeData.primaryColor,
                    textStyle: TextStyle(
                      fontWeight: FluConsts.textBold
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