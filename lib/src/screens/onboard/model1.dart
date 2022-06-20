import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import '../../../flukit.dart';

/// TODO Optimize this screen.
class FluFluOnboardingScreenModel1 extends StatelessWidget {
  final FluOnboardingScreenParameters parameters;

  const FluFluOnboardingScreenModel1({
    Key? key,
    required this.parameters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FluOnboardingScreen(
    parameters: parameters,
    builder: (FluOnboardingBuilderParameters builderParameters) {
      return SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Flukit.appConsts.defaultPaddingSize).copyWith(top: 25),
              child: FluOnboardingScreenIndicators(
                count: parameters.pages.length,
                controller: builderParameters.pageController,
              ),
            ),
            Expanded(child:FluOnboardingScreenPageBuilder(
              controller: builderParameters.controller,
              pageController: builderParameters.pageController,
              pagesCount: parameters.pages.length,
              builder: (context, index) {
                FluOnboardingScreenPage page = parameters.pages[index];
                bool isCurrent = builderParameters.controller.currentIndex == index;
                double maxWidth = !builderParameters.controller.onLastPage ? Flukit.appConsts.defaultElSize : (Flukit.screenSize.width - (Flukit.appConsts.defaultPaddingSize * 2)) * .45;
              
                Widget icon = FluIcon(
                  icon: page.buttonIcon ?? parameters.mainButtonIcon ?? FluBulkIcons.essentional_flash,
                  style: FluIconStyle(
                    color: Flukit.themePalette.light,
                    size: 20,
                  ),
                );
                Widget buttonContext = !builderParameters.controller.onLastPage ? icon : FluCollapsible(
                  collapse: !builderParameters.controller.onLastPage,
                  axis: FluCollapsibleAxis.horizontal,
                  animDuration: parameters.animationDuration,
                  /// i use [SingleChildScrollView] to avoid overflow error
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FluIcon(
                          icon: page.buttonIcon ?? parameters.mainButtonIcon ?? FluBulkIcons.essentional_flash,
                          style: FluIconStyle(
                            color: Flukit.themePalette.light,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(page.buttonText ?? parameters.mainButtonText, style: Flukit.textTheme.bodyText1!.copyWith(
                          color: Flukit.themePalette.light
                        )),
                      ],
                    ),
                  ),
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
                    FluButton(
                      onPressed: builderParameters.onForward,
                      style: FluButtonStyle.main.merge(FluButtonStyle(
                        height: Flukit.appConsts.defaultElSize,
                        maxWidth: maxWidth,
                      )),
                      child: buttonContext
                    ),
                    /// TODO add progress bar
                    /* FluSquareProgressBar(
                      height: Flukit.appConsts.defaultElSize,
                      // width: Flukit.appConsts.defaultElSize,
                      maxWidth: maxWidth,
                      strokeWidth: 2,
                      emptyBarColor: Flukit.theme.backgroundColor,
                      solidBarColor: Flukit.theme.primaryColor,
                      progress: .5,
                      animationCurve: parameters.animationCurve,
                      animationDuration: parameters.animationDuration,
                      child: FluButton(
                        onPressed: builderParameters.onForward,
                        style: FluButtonStyle.main.merge(FluButtonStyle(
                          height: Flukit.appConsts.defaultElSize,
                          maxWidth: maxWidth,
                        )),
                        child: buttonContext
                      ),
                    ) */
                  ]
                );
              }
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(Flukit.appInfos.name, style: Flukit.textTheme.bodyText1!.copyWith(
                fontFamily: Flukit.textFonts.neptune,
                package: 'flukit'
              )),
            )
          ],
        ),
      );
    },
  );
}