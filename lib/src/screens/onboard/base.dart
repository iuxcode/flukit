import 'dart:math' as math;

import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FluOnboardingScreen extends StatefulWidget {
  final FluOnboardingScreenParameters parameters;
  final Widget Function()? builder;

  FluOnboardingScreen({required this.parameters, this.builder})
      : super(key: parameters.key);

  @override
  State<FluOnboardingScreen> createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<FluOnboardingScreen> {
  // bool onFirstPage = false, onLastPage = false;
  late FluOnboardingScreenController controller;
  late PageController pageController;

  @override
  void initState() {
    controller = widget.parameters.controller;
    pageController = widget.parameters.pageController;

    () async {
      await Flu.appController
          .setFirstTimeOpeningState(false)
          .onError((error, stackTrace) => throw {
                "Error while setting firstTimeOpening parameter in secure storage.",
                error,
                stackTrace
              });
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FluScreen(
      systemUiOverlayStyle: Flu.theme()
          .systemUiOverlayStyle
          .copyWith(statusBarColor: Colors.transparent),
      body: GetX<FluOnboardingScreenController>(
        init: controller,
        initState: (_) {},
        builder: (_) {
          controller.onLastPage =
              controller.currentIndex == widget.parameters.pages.length - 1;

          return widget.builder?.call() ??
              Column(
                children: [
                  Expanded(
                    child: FluOnboardingScreenPageBuilder(
                        controller: controller,
                        pageController: pageController,
                        pagesCount: widget.parameters.pages.length,
                        builder: (context, index) {
                          FluOnboardingScreenPage page =
                              widget.parameters.pages[index];
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
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                            horizontal: Flu.appSettings.defaultPaddingSize)
                        .copyWith(bottom: 15),
                    child: AnimatedSwitcher(
                      duration: widget.parameters.animationDuration,
                      transitionBuilder: (child, animation) => SlideTransition(
                        position: Tween<Offset>(
                                begin: const Offset(1, 0),
                                end: const Offset(0, 0))
                            .animate(animation),
                        child: child,
                      ),
                      child: !controller.onLastPage
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  FluButton.text(
                                    onPressed: widget.parameters.onBack,
                                    text: controller.onFirstPage
                                        ? widget.parameters.skipButtonText
                                        : widget.parameters.prevButtonText,
                                    textStyle: TextStyle(
                                        fontWeight:
                                            Flu.appSettings.textSemibold),
                                    style: FluButtonStyle(
                                      height: Flu.appSettings.defaultElSize,
                                      color: Flu.theme().accentText,
                                    ),
                                  ),
                                  FluOnboardingScreenIndicators(
                                    count: widget.parameters.pages.length,
                                    controller: pageController,
                                  ),
                                  FluButton.text(
                                    onPressed: widget.parameters.onForward,
                                    text: controller.onLastPage
                                        ? widget.parameters.mainButtonText
                                        : widget.parameters.nextButtonText,
                                    textStyle: TextStyle(
                                        fontWeight:
                                            Flu.appSettings.textSemibold),
                                    style: FluButtonStyle(
                                      height: Flu.appSettings.defaultElSize,
                                      color: Flu.theme().accentText,
                                    ),
                                  )
                                ])
                          : Hero(
                              tag: Flu.appSettings.mainButtonHeroTag,
                              child: FluButton.text(
                                onPressed: widget.parameters.onForward,
                                text: widget.parameters.mainButtonText,
                                prefixIcon: widget.parameters.mainButtonIcon ??
                                    FluIcons.flash,
                                textStyle: TextStyle(
                                    fontWeight: Flu.appSettings.textBold),
                                style: FluButtonStyle(
                                  height: Flu.appSettings.defaultElSize,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  color: Flu.theme().onPrimary,
                                  background: Flu.theme().primary,
                                  iconSize: 24,
                                  iconStrokewidth: 1.8,
                                  // alignment: Alignment.centerLeft
                                ),
                              ),
                            ),
                    ),
                  )
                ],
              );
        },
      ));
}

class FluOnboardingScreenPageBuilder extends StatelessWidget {
  final FluOnboardingScreenController controller;
  final PageController pageController;
  final int pagesCount;
  final Widget Function(BuildContext context, int index) builder;

  const FluOnboardingScreenPageBuilder(
      {Key? key,
      required this.controller,
      required this.pageController,
      required this.pagesCount,
      required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) => PageView.builder(
      controller: pageController,
      onPageChanged: (v) {
        controller.currentIndex = v;
        // controller.onLastPage = controller.currentIndex == pagesCount - 1;
      },
      itemCount: pagesCount,
      itemBuilder: builder);
}

class FluOnboardingScreenImageViewer extends StatelessWidget {
  final double? height;
  final bool scale, expand, gradient;
  final Duration animationDuration;
  final Curve animationCurve;
  final String? imageUrl;
  final FluImageSource imageType;

  const FluOnboardingScreenImageViewer({
    Key? key,
    this.imageUrl,
    this.imageType = FluImageSource.network,
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
          gradient: gradient
              ? LinearGradient(
                  colors: [Flu.theme().secondary, Flu.theme().background],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)
              : null),
      child: AnimatedScale(
          scale: scale ? 1 : 0,
          duration: animationDuration,
          curve: animationCurve,
          child: imageUrl?.isNotEmpty ?? false
              ? FluImage(
                  imageUrl!,
                  src: imageType,
                )
              : Container()),
    );

    return expand
        ? Expanded(child: wgt)
        : SizedBox(height: height ?? Flu.screenSize.height * .3, child: wgt);
  }
}

class FluOnboardingScreenTexts extends StatelessWidget {
  final String title, desc;
  final double? marginBottom;

  const FluOnboardingScreenTexts(
      {Key? key, required this.title, required this.desc, this.marginBottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Flu.appSettings.defaultPaddingSize)
                .copyWith(
                    bottom: marginBottom ?? Flu.screenSize.height * .075,
                    top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: Flu.appSettings.titleTextHeroTag,
              child: FluText(
                text: title,
                textAlign: TextAlign.center,
                stylePreset: FluTextStyle.headlineBold,
              ),
            ),
            const SizedBox(height: 5),
            Hero(
                tag: Flu.appSettings.descriptionTextHeroTag,
                child: FluText(
                  text: desc,
                  textAlign: TextAlign.center,
                  stylePreset: FluTextStyle.body,
                )),
          ],
        ),
      );
}

class FluOnboardingScreenIndicators extends StatelessWidget {
  final PageController controller;
  final int count;
  final double expansionFactor, dotHeight, dotWidth;
  final Color? dotColor;

  const FluOnboardingScreenIndicators({
    Key? key,
    required this.controller,
    required this.count,
    this.expansionFactor = 6,
    this.dotHeight = 4,
    this.dotWidth = 4,
    this.dotColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SmoothPageIndicator(
        controller: controller,
        count: count,
        effect: ExpandingDotsEffect(
          dotColor: dotColor ?? Colors.grey,
          activeDotColor: Flu.theme().primary,
          dotHeight: dotHeight,
          dotWidth: dotWidth,
          expansionFactor: expansionFactor,
        ),
      );
}

class FluOnboardingScreenParameters {
  final Key? key;
  final List<FluOnboardingScreenPage> pages;
  final Duration animationDuration;
  final Curve animationCurve;
  final String mainButtonText, prevButtonText, nextButtonText, skipButtonText;
  final FluIcons? mainButtonIcon;
  final VoidCallback onLeaving;

  late PageController _pageController;
  late FluOnboardingScreenController _controller;

  FluOnboardingScreenParameters({
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
    FluOnboardingScreenController? controller,
    PageController? pageController,
  }) {
    _controller = controller ??
        Get.put(
          FluOnboardingScreenController(),
          tag: 'FluOnboardingScreenController#${math.Random().nextInt(99999)}',
        );
    _pageController = pageController ?? PageController();
  }

  FluOnboardingScreenController get controller => _controller;
  PageController get pageController => _pageController;

  void onBack() {
    if (!controller.onFirstPage) {
      pageController.previousPage(
        duration: animationDuration,
        curve: animationCurve,
      );
    } else {
      pageController.jumpToPage(pages.length - 1);
    }
  }

  void onForward() async {
    if (!controller.onLastPage) {
      pageController.nextPage(
          duration: animationDuration, curve: animationCurve);
    } else {
      onLeaving();
    }
  }

  void onSkip() {
    // widget.parameters.onLeaving();
  }
}

const Duration _defaultDuration = Duration(milliseconds: 300);
const Curve _defaultCurve = Curves.fastOutSlowIn;
