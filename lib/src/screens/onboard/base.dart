import 'dart:math' as math;

import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


const Duration _defaultDuration = Duration(milliseconds: 300);
const Curve _defaultCurve = Curves.fastOutSlowIn;

class FluOnboardingScreenParameters {
  final Key? key;
  final List<FluOnboardingScreenPage> pages;
  final Duration animationDuration;
  final Curve animationCurve;
  final String mainButtonText, prevButtonText, nextButtonText, skipButtonText;
  final FluIconModel? mainButtonIcon;
  final VoidCallback onLeaving;
  
  const FluOnboardingScreenParameters({
    this.key,
    required this.pages,
    required this.onLeaving,
    this.animationDuration = _defaultDuration,
    this.animationCurve = _defaultCurve,
    this.mainButtonText = 'Get Started',
    this.prevButtonText = 'Back',
    this.nextButtonText = 'Next',
    this.skipButtonText = 'Skip',
    this.mainButtonIcon,
  });
}

class FluOnboardingBuilderParameters {
  final FluOnboardingScreenController controller;
  final FluOnboardingScreenParameters screenParameters;
  final PageController pageController;
  final VoidCallback onForward, onBack, onSkip;

  FluOnboardingBuilderParameters({
    required this.controller,
    required this.screenParameters,
    required this.pageController,
    required this.onForward,
    required this.onBack,
    required this.onSkip
  });
}

class FluOnboardingScreen extends StatefulWidget {
  final FluOnboardingScreenParameters parameters;
  final Widget Function(FluOnboardingBuilderParameters builderParameters)? builder;

  FluOnboardingScreen({
    required this.parameters,
    this.builder
  }) : super(key: parameters.key);

  @override
  State<FluOnboardingScreen> createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<FluOnboardingScreen> {
  final FluOnboardingScreenController controller = Get.put(
    FluOnboardingScreenController(),
    tag: 'FluOnboardingScreenController#${math.Random().nextInt(99999)}'
  );
  final PageController pageController = PageController();
  // bool onFirstPage = false, onLastPage = false;

  void onInit() async {
    await Flukit.appController.setFirstTimeOpeningState(false)
      .onError((error, stackTrace) => throw {"Error while setting firstTimeOpening parameter in secure storage.", error, stackTrace});
  }
  void onBack(BuildContext context) {
    if(!controller.onFirstPage) {
      pageController.previousPage(duration: widget.parameters.animationDuration, curve: widget.parameters.animationCurve);
    } else {
      pageController.jumpToPage(widget.parameters.pages.length - 1); //, duration: animationDuration, curve: animationCurve
    }
  }
  void onForward(BuildContext context) async {
    if(!controller.onLastPage) {
      pageController.nextPage(duration: widget.parameters.animationDuration, curve: widget.parameters.animationCurve);
    } else {
      widget.parameters.onLeaving();
    }
  }
  void onSkip(BuildContext context) {
    // widget.parameters.onLeaving();
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
        controller.onLastPage = controller.currentIndex == widget.parameters.pages.length - 1;

        return widget.builder?.call(FluOnboardingBuilderParameters(
          controller: controller,
          screenParameters: widget.parameters,
          pageController: pageController,
          onForward: () => onForward(context),
          onBack: () => onBack(context),
          onSkip: () => onSkip(context),
        )) ?? Column(
          children: [
            Expanded(
              child: FluOnboardingScreenPageBuilder(
                controller: controller,
                pageController: pageController,
                pagesCount: widget.parameters.pages.length,
                builder: (context, index) {
                  FluOnboardingScreenPage page = widget.parameters.pages[index];
                  bool isCurrent = controller.currentIndex == index;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FluOnboardingScreenImageViewer(
                        imageUrl: page.image,
                        imageType: page.imageType,
                        scale: isCurrent,
                      ),
                      FluOnboardingScreenTexts(
                        title: page.title,
                        desc: page.desc,
                      )
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
                duration: widget.parameters.animationDuration,
                transitionBuilder: (child, animation) => SlideTransition(
                  position: Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(animation),
                  child: child,
                ),
                child: !controller.onLastPage ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  FluButton.text(
                    onPressed: () => onBack(context),
                    text: controller.onFirstPage ? widget.parameters.skipButtonText : widget.parameters.prevButtonText,
                    textStyle: TextStyle(
                      fontWeight: Flukit.appConsts.textSemibold
                    ),
                    style: FluButtonStyle(
                      height: Flukit.appConsts.defaultElSize,
                      color: Flukit.themePalette.accentText,
                    ),
                  ),
                  FluOnboardingScreenIndicators(
                    count: widget.parameters.pages.length,
                    controller: pageController,
                  ),
                  FluButton.text(
                    onPressed: () => onForward(context),
                    text: controller.onLastPage ? widget.parameters.mainButtonText : widget.parameters.nextButtonText,
                    textStyle: TextStyle(
                      fontWeight: Flukit.appConsts.textSemibold
                    ),
                    style: FluButtonStyle(
                      height: Flukit.appConsts.defaultElSize,
                      color: Flukit.themePalette.accentText,
                    ),
                  )
                ]) : Hero(
                  tag: '<main_button>',
                  child: FluButton.text(
                    onPressed: () => onForward(context),
                    text: widget.parameters.mainButtonText,
                    prefixIcon: widget.parameters.mainButtonIcon ?? FluBulkIcons.essentional_flash,
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
                      ),
                      // alignment: Alignment.centerLeft
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

class FluOnboardingScreenPageBuilder extends StatelessWidget {
  final FluOnboardingScreenController controller;
  final PageController pageController;
  final int pagesCount;
  final Widget Function(BuildContext context, int index) builder;

  const FluOnboardingScreenPageBuilder({
    Key? key,
    required this.controller,
    required this.pageController,
    required this.pagesCount,
    required this.builder
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => PageView.builder(
    controller: pageController,
    onPageChanged: (v) {
      controller.currentIndex = v;
      // controller.onLastPage = controller.currentIndex == pagesCount - 1;
    },
    itemCount: pagesCount,
    itemBuilder: builder
  );
}

class FluOnboardingScreenImageViewer extends StatelessWidget {
  final double? height;
  final bool scale, expand, gradient;
  final Duration animationDuration;
  final Curve animationCurve;
  final String? imageUrl;
  final FluImageType? imageType;

  const FluOnboardingScreenImageViewer({
    Key? key,
    this.imageUrl,
    this.imageType,
    this.height,
    this.scale = false,
    this.expand = true,
    this.gradient = true,
    this.animationDuration = _defaultDuration,
    this.animationCurve = _defaultCurve,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget wgt = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: gradient ? LinearGradient(colors: [
          Flukit.theme.data.colorScheme.secondary,
          Flukit.theme.data.backgroundColor
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter) : null
      ),
      child: AnimatedScale(
        scale: scale ? 1 : 0,
        duration: animationDuration,
        curve: animationCurve,
        child: imageUrl?.isNotEmpty ?? false ? FluImage(
          url: imageUrl,
          type: imageType,
        ) : Container()
      ),
    );
    
    return expand ? Expanded(
      child: wgt
    ) : SizedBox(
      height: height ?? Flukit.screenSize.height * .3,
      child: wgt
    );
  }
}

class FluOnboardingScreenTexts extends StatelessWidget {
  final String title, desc;
  final double? marginBottom;

  const FluOnboardingScreenTexts({
    Key? key,
    required this.title,
    required this.desc,
    this.marginBottom
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: Flukit.appConsts.defaultPaddingSize
    ).copyWith(bottom: marginBottom ?? Flukit.screenSize.height * .075, top: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Hero(
          tag: '<title_text>',
          child: Text(title, textAlign: TextAlign.center, style: Flukit.textTheme.headline1?.copyWith(
            fontSize: Flukit.appConsts.headlineFs
          )),
        ),
        const SizedBox(height: 5),
        Hero(tag: '<desc_text>', child: Text(desc, textAlign: TextAlign.center, style: Flukit.textTheme.bodyText1)),
      ],
    ),
  );
}

class FluOnboardingScreenIndicators extends StatelessWidget {
  final PageController controller;
  final int count;

  const FluOnboardingScreenIndicators({
    Key? key,
    required this.controller,
    required this.count
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SmoothPageIndicator(
    controller: controller,
    count: count,
    effect: ExpandingDotsEffect(
      dotColor: Colors.grey,
      activeDotColor: Flukit.theme.data.primaryColor,
      dotHeight: 4,
      dotWidth: 4,
      expansionFactor: 8
    )
  );
}