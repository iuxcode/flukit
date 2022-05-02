import 'dart:math' as math;

import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

typedef OnAuthGoingBackFunction = void Function(
  FluAuthScreenController controller,
  TextEditingController inputController,
  bool onFirstPage,
  bool onLastPage
);
typedef OnAuthGoingForwardFunction = void Function(
  FluAuthScreenController controller,
  PageController pageController,
  TextEditingController inputController,
  bool onFirstPage,
  bool onLastPage
);

class FluAuthScreenParameters {
  final bool canGetBack;

  FluAuthScreenParameters({this.canGetBack = true});
}

class FluSteppedAuthScreen extends StatefulWidget {
  final FluAuthScreenController? controller;
  final List<FluAuthScreenStepModel> steps;
  final OnAuthGoingBackFunction? onGoingBack;
  final OnAuthGoingForwardFunction? onGoingForward;

  const FluSteppedAuthScreen({
    Key? key,
    required this.steps,
    this.controller,
    this.onGoingBack,
    this.onGoingForward,
  }) : super(key: key);

  @override
  State<FluSteppedAuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<FluSteppedAuthScreen> {
  late FluAuthScreenController controller;
  late FluAuthScreenParameters args;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController inputController = TextEditingController();
  final PageController pageController = PageController();
  final Duration animationDuration = const Duration(milliseconds: 300), buttonSwitchAnimationDuration = const Duration(milliseconds: 200);
  final Curve animationCurve = Curves.fastOutSlowIn;

  bool get onFirstPage => controller.stepIndex == 0; 
  bool get onLastPage => controller.stepIndex == widget.steps.length - 1;


  /// check if input value is empty or not.
  /// or if the custom validator test is passed.
  String? inputValidator(String? value, bool Function(String value, FluAuthScreenController controller)? customValidator) {
    bool valid = false;

    if(customValidator == null) {
      valid = value!.isNotEmpty;
    }
    else {
      valid = value!.isNotEmpty && customValidator(value, controller);
    }

    return !valid ? 'incorrect' : null;
  }

  /// On input value changed, we reset the error state and make user able to submit or not.
  void onInputValueChanged(String value, void Function(String value, FluAuthScreenController controller)? callback) {
    controller.hasError = false;
    controller.canSubmit = value.isNotEmpty;
    callback?.call(value, controller);
  }

  ///handle back button "onPressed" event.
  void onBack() {
    /// if we are not on first page, we call the "onGoingBack" action.
    if(!onFirstPage) {
      widget.onGoingBack?.call(
        controller,
        inputController,
        onFirstPage,
        onLastPage
      );

      inputController.text = controller.previousInputValue;
      controller.hasError = false;
      pageController.previousPage(duration: animationDuration, curve: animationCurve);
    }
    /// else just navigate to previous page.
    else {
      Get.back();
    }
  }

  ///handle next button "onPressed" event.
  Future onSubmit(BuildContext context) async {
    /// if keyboard is visible, let's hide it.
    FocusScope.of(Flukit.context).unfocus();

    /// ensure that another action is not ongoing.
    if(!controller.loading) {
      if(_formKey.currentState!.validate()) {
        widget.onGoingForward?.call(
          controller,
          pageController,
          inputController,
          onFirstPage,
          onLastPage
        );

        if(!onLastPage) {
          controller.previousInputValue = inputController.text;
          inputController.text = '';
          pageController.nextPage(duration: animationDuration, curve: animationCurve);
        }
      }
      else {
        controller.hasError = true;
        Flukit.throwError(widget.steps[controller.stepIndex].onError?.call(controller));
      }
    }
  }

  @override
  void initState() {
    /// initialize controller
    controller = Get.put(
      widget.controller ?? FluAuthScreenController(),
      tag: 'AuthScreenController_' + math.Random().nextInt(99999).toString()
    );

    /// Get the arguments and set controller values;
    args = (Get.arguments != null && Get.arguments is FluAuthScreenParameters) ? Get.arguments as FluAuthScreenParameters : FluAuthScreenParameters();
    controller.canGetBack = args.canGetBack;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FluScreen(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    onPageChanged: (v) => {
                      controller.canSubmit = !(v == 0 && v == 1),
                      controller.stepIndex = v
                    },
                    itemCount: widget.steps.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        Expanded(child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Flukit.theme.secondaryColor,
                              Flukit.theme.backgroundColor
                            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
                          ),
                          ///! TODO: add an images for each page
                          child: widget.steps[index].image.isNotEmpty ? FluImage(
                            image: widget.steps[index].image,
                            type: widget.steps[index].imageType,
                          ) : null
                        )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: FluConsts.defaultPaddingSize
                          ).copyWith(top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Hero(
                                tag: '< title_text >',
                                child: text(widget.steps[index].title, isTitle: true),
                              ),
                              const SizedBox(height: 3),
                              Hero(tag: '< desc_text >', child: text(widget.steps[index].desc)),
                              Obx(() => FluTextInput(
                                controller: inputController,
                                height: FluConsts.defaultElSize,
                                hintText: widget.steps[index].inputHint,
                                hintColor: controller.hasError ? Flukit.theme.palette.danger : Flukit.theme.palette.text,
                                color: controller.hasError ? Flukit.theme.palette.danger : Flukit.theme.palette.accentText,
                                borderColor: (controller.hasError ? Flukit.theme.palette.danger : Flukit.theme.backgroundColor).withOpacity(.015),
                                borderWidth: 1.5,
                                margin: const EdgeInsets.only(top: 35, bottom: 8),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                boxShadow: [Flukit.boxShadow(
                                  blurRadius: 30,
                                  opacity: .025,
                                  offset: const Offset(0,0),
                                  color: Flukit.theme.shadowColor
                                )],
                                inputFormatters: [LengthLimitingTextInputFormatter(15)],
                                validator: (value) => inputValidator(value, widget.steps[index].inputValidator),
                                onChanged: (value) => onInputValueChanged(value,  widget.steps[index].onInputValueChanged),
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: buttonSwitchAnimationDuration,
                  child: !Flukit.isKeyboardHidden(context) ? GetX<FluAuthScreenController>(
                    init: controller,
                    initState: (_) {},
                    builder: (_) {
                      return Hero(
                        tag: '< main_button >',
                        child: FluButton.text(
                          onPressed: controller.canSubmit ? () => onSubmit(context) : null,
                          height: FluConsts.defaultElSize,
                          width: double.infinity,
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.symmetric(horizontal: FluConsts.defaultPaddingSize).copyWith(bottom: 25),
                          /* boxShadow: Flukit.boxShadow(
                            color: Flukit.theme.shadowColor,
                            opacity: controller.canSubmit ? .085 : .05,
                            blurRadius: 30,
                            offset: const Offset(0, 0)
                          ), */
                          text: widget.steps[controller.stepIndex].buttonLabel,
                          prefixIcon: widget.steps[controller.stepIndex].buttonIcon,
                          iconSize: 24,
                          iconStrokeWidth: 1.8,
                          spacing: 8,
                          color: controller.canSubmit ? Flukit.theme.primaryTextColor : Flukit.theme.palette.accentText,
                          backgroundColor: controller.canSubmit ? Flukit.theme.primaryColor : Flukit.theme.secondaryColor,
                          textStyle: TextStyle(
                            fontWeight: FluConsts.textBold
                          ),
                          loading: controller.loading,
                        ),
                      );
                    }
                  ) : Container()
                )
              ],
            ),
            Positioned(
              top: Flukit.statusBarHeight,
              child: Container(
                width: Flukit.screenSize.width,
                padding: EdgeInsets.symmetric(
                  horizontal: FluConsts.defaultPaddingSize
                ).copyWith(top: 8),
                child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedOpacity(
                      opacity: controller.canGetBack ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Hero(
                        tag: '< back_button >',
                        child: FluButton.icon(
                          onPressed: controller.canGetBack ? () => onBack() : null,
                          size: FluConsts.minElSize,
                          icon: FluTwotoneIcons.arrow_arrowLeft,
                          iconSize: 24,
                          backgroundColor: Flukit.theme.secondaryColor,
                          color: Flukit.theme.palette.accentText,
                          boxShadow: Flukit.boxShadow(
                            color: Flukit.theme.palette.shadow,
                            offset: const Offset(-5, 15),
                            opacity: .06
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: onFirstPage ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: FluButton(
                        onPressed: onFirstPage ? () => Flukit.showCountrySelectionBottomSheet(
                          context: context,
                          onCountrySelected: (FluCountryModel country) {
                            controller.setRegion(country.isoCode);
                          }
                        ) : null,
                        height: FluConsts.minElSize + 2,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        backgroundColor: Flukit.theme.secondaryColor,
                        boxShadow: Flukit.boxShadow(
                          color: Flukit.theme.palette.shadow,
                          offset: const Offset(10, 15),
                          opacity: .06
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: controller.countriesLoading ? SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Flukit.theme.palette.accentText),
                              strokeWidth: 2,
                            ),
                          ) : Row(children: [
                            Text(controller.region == null ? 'Togo' : controller.region!.name, style: Flukit.textTheme.bodyText1!.copyWith(
                              color: Flukit.theme.palette.accentText,
                              fontWeight: FluConsts.textSemibold
                            )),
                            Container(
                              height: 20,
                              width: 25,
                              margin: const EdgeInsets.only(left: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  'icons/flags/png/${controller.countryCode.toLowerCase()}.png',
                                  package: 'country_icons',
                                  fit: BoxFit.fill,
                                ),
                              )
                            ),
                          ]),
                        )
                      ),
                    )
                  ],
                ))
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget text(String text, {bool isTitle = false}) => Text(
    text,
    textAlign: TextAlign.center,
    style: isTitle ? Flukit.textTheme.headline1?.copyWith(
      fontSize: FluConsts.subHeadlineFs
    ) : Flukit.textTheme.bodyText1
  );
}