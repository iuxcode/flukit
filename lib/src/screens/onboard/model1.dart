import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import '../../../flukit.dart';

class FluOnboardingScreenModel1 extends StatelessWidget {
  final FluOnboardingScreenParameters parameters;

  const FluOnboardingScreenModel1({
    Key? key,
    required this.parameters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FluOnboardingScreen(
        parameters: parameters,
        builder: () {
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                          horizontal: Flukit.appConsts.defaultPaddingSize)
                      .copyWith(top: 25),
                  child: FluOnboardingScreenIndicators(
                    count: parameters.pages.length,
                    controller: parameters.pageController,
                  ),
                ),
                Expanded(
                    child: FluOnboardingScreenPageBuilder(
                        controller: parameters.controller,
                        pageController: parameters.pageController,
                        pagesCount: parameters.pages.length,
                        builder: (context, index) {
                          FluOnboardingScreenPage page = parameters.pages[index];
                          bool isCurrent =
                              parameters.controller.currentIndex == index;
                          bool mustCollapse = !parameters.controller.onFirstPage &&
                              !parameters.controller.onLastPage;
                          double maxWidth = mustCollapse
                              ? Flukit.appConsts.defaultElSize
                              : (Flukit.screenSize.width -
                                      (Flukit.appConsts.defaultPaddingSize * 2)) *
                                  .45;

                          Widget icon = FluIcon(
                            page.buttonIcon ??
                                parameters.mainButtonIcon ??
                                FluIcons.flash,
                            color: Flukit.themePalette.light,
                            size: 20,
                          );

                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FluOnboardingScreenImageViewer(
                                  imageUrl: page.image,
                                  imageType: page.imageType,
                                  scale: isCurrent,
                                  expand: false,
                                  gradient: false,
                                ),
                                FluOnboardingScreenTexts(
                                  title: page.title,
                                  desc: page.desc,
                                  marginBottom: 20,
                                ),
                                Hero(
                                  tag: Flukit.appConsts.mainButtonHeroTag,
                                  child: FluButton(
                                      onPressed: parameters.onForward,
                                      style:
                                          FluButtonStyle.main.merge(FluButtonStyle(
                                        height: Flukit.appConsts.minElSize + 5,
                                        radius: Flukit.appConsts.minElRadius + 2,
                                        maxWidth: maxWidth,
                                      )),

                                      /// TODO Optimize this.
                                      /// add square progress bar with border radius and remove top indicator
                                      child: AnimatedSwitcher(
                                        duration: parameters.animationDuration,
                                        child: mustCollapse
                                            ? icon
                                            : FluCollapsible(
                                                collapse: mustCollapse,
                                                axis: FluCollapsibleAxis.horizontal,
                                                animDuration:
                                                    parameters.animationDuration,

                                                /// i use [SingleChildScrollView] to avoid overflow error
                                                child: SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children: [
                                                      FluIcon(
                                                        page.buttonIcon ??
                                                            parameters
                                                                .mainButtonIcon ??
                                                            FluIcons.flash,
                                                        color: Flukit
                                                            .themePalette.light,
                                                        size: 20,
                                                      ),
                                                      const SizedBox(width: 6),
                                                      Text(
                                                          page.buttonText ??
                                                              parameters
                                                                  .mainButtonText,
                                                          style: Flukit
                                                              .textTheme.bodyText1!
                                                              .copyWith(
                                                                  fontWeight: Flukit
                                                                      .appConsts
                                                                      .textSemibold,
                                                                  color: Flukit
                                                                      .themePalette
                                                                      .light)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                      )),
                                ),
                              ]);
                        })),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Hero(
                    tag: Flukit.appConsts.brandTextHeroTag,
                    child: Text(Flukit.appInfos.name,
                        style: Flukit.textTheme.bodyText1!.copyWith(
                            fontFamily: Flukit.fonts.neptune, package: 'flukit')),
                  ),
                )
              ],
            ),
          );
        },
      );
}
