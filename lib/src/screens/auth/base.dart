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
typedef OnAuthGoingForwardFunction = Future<bool> Function(
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
  final Widget? headerAction;
  final FluAuthScreenController? controller;
  final OnAuthGoingBackFunction? onGoingBack;
  final OnAuthGoingForwardFunction? onGoingForward;
  final Duration? animationDuration;
  final Curve? animationCurve;

  const FluSteppedAuthScreen({
    Key? key,
    this.controller,
    this.onGoingBack,
    this.onGoingForward,
    this.headerAction,
    this.animationDuration,
    this.animationCurve
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
  final Duration animationDuration = const Duration(milliseconds: 300);
  final Curve animationCurve = Curves.fastOutSlowIn;

  bool get onFirstPage => controller.stepIndex == 0; 
  bool get onLastPage => controller.stepIndex == controller.steps.length - 1;


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
    if(controller.steps.length == 1) {
      widget.onGoingBack?.call(
        controller,
        inputController,
        onFirstPage,
        onLastPage
      );
    }
    /// if we are not on first page, we call the "onGoingBack" action.
    else if(!onFirstPage) {
      widget.onGoingBack?.call(
        controller,
        inputController,
        onFirstPage,
        onLastPage
      );

      if(controller.previousInputValue.isNotEmpty) {
        inputController.text = controller.previousInputValue;
        controller.canSubmit = true;
        controller.previousInputValue = "";
      }
      else {
        inputController.text = "";
        controller.canSubmit = false;
      }

      controller.hasError = false;
      pageController.previousPage(duration: widget.animationDuration ?? animationDuration, curve: widget.animationCurve ?? animationCurve);
    }
    /// else just navigate to previous page.
    else {
      Get.back();
    }
  }

  ///handle next button "onPressed" event.
  Future onSubmit(BuildContext context) async {
    FluAuthScreenStep step =  controller.steps[controller.stepIndex];

    /// if keyboard is visible, let's hide it.
    FocusScope.of(Flukit.context).unfocus();

    /// ensure that another action is not ongoing.
    if(!controller.loading) {
      bool v = false;

      if(step is FluAuthScreenCustomStep) {
        if(step.onButtonPressed != null && step.onButtonPressed!(controller)) {
          if(widget.onGoingForward != null) {
            v = await widget.onGoingForward!(
              controller,
              pageController,
              inputController,
              onFirstPage,
              onLastPage
            );
          }
        }
      }
      else if(step is FluAuthScreenInputStep) {
        if(_formKey.currentState!.validate()) {
          v = widget.onGoingForward != null && await widget.onGoingForward!(
            controller,
            pageController,
            inputController,
            onFirstPage,
            onLastPage
          );
        }
        else {
          controller.hasError = true;
          Flukit.throwError(step.onError?.call(controller));
        }
      }

      if(!onLastPage && v) {
        controller.previousInputValue = inputController.text;
        inputController.text = '';

        controller.canSubmit = false;
        pageController.nextPage(duration: widget.animationDuration ?? animationDuration, curve: widget.animationCurve ?? animationCurve);
      }
    }
  }

  @override
  void initState() {
    /// initialize controller
    controller = Get.put(
      widget.controller ?? FluAuthScreenController(
        initialSteps: <FluAuthScreenStep>[]
      ),
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
                    onPageChanged: (v) {
                      controller.stepIndex = v;
                      controller.canGetBack = onFirstPage ? args.canGetBack : true;
                    },
                    itemCount: controller.steps.length,
                    itemBuilder: (context, index) {
                      FluAuthScreenStep step = controller.steps[index];
                    
                      return Column(
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
                            child: controller.steps[index].image.isNotEmpty ? FluImage(
                              image: controller.steps[index].image,
                              type: controller.steps[index].imageType,
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
                                  child: text(controller.steps[index].title, isTitle: true),
                                ),
                                const SizedBox(height: 3),
                                Hero(tag: '< desc_text >', child: text(controller.steps[index].desc)),
                                GetBuilder<FluAuthScreenController>(
                                  init: controller,
                                  initState: (_) {},
                                  builder: (_) {
                                    if(step is FluAuthScreenCustomStep) {
                                      return  Container(
                                        margin: const EdgeInsets.only(top: 35, bottom: 8),
                                        child: step.builder(context, controller, inputController)
                                      );
                                    }
                                    else if(step is FluAuthScreenInputStep) {
                                      return FluOutline(
                                        strokeWidth: .85,
                                        radius: FluConsts.defaultElRadius + 2,
                                        margin: const EdgeInsets.only(top: 35, bottom: 8),
                                        boxShadow: Flukit.boxShadow(
                                          blurRadius: 30,
                                          opacity: .075,
                                          offset: const Offset(5, 5),
                                          color: Flukit.theme.shadowColor
                                        ),
                                        child: FluTextInput(
                                          controller: inputController,
                                          height: step.inputHeight ?? FluConsts.defaultElSize - 2,
                                          hintText: step.inputHint,
                                          hintColor: controller.hasError ? Flukit.theme.palette.danger : Flukit.theme.palette.text,
                                          color: controller.hasError ? Flukit.theme.palette.danger : Flukit.theme.palette.accentText,
                                          fillColor: Flukit.theme.backgroundColor,
                                          borderColor: (controller.hasError ? Flukit.theme.palette.danger : Flukit.theme.backgroundColor).withOpacity(.015),
                                          borderWidth: 1.5,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.done,
                                          inputFormatters: null,
                                          validator: (value) => inputValidator(value, step.inputValidator),
                                          onChanged: (value) => onInputValueChanged(value,  step.onInputValueChanged),
                                        ),
                                      );
                                    }
                                    else {
                                      return Container();
                                    }
                                  }
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                ),
                AnimatedSwitcher(
                  duration: widget.animationDuration ?? animationDuration,
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
                          boxShadow: Flukit.boxShadow(
                            color: Flukit.theme.shadowColor,
                            opacity: controller.canSubmit ? .085 : .045,
                            blurRadius: 30,
                            offset: const Offset(0, 0)
                          ),
                          text: controller.steps[controller.stepIndex].buttonLabel,
                          prefixIcon: controller.steps[controller.stepIndex].buttonIcon,
                          iconSize: 24,
                          iconStrokeWidth: 1.8,
                          spacing: 2,
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
                          backgroundColor: Flukit.theme.backgroundColor.withOpacity(.25),
                          color: Flukit.theme.palette.accentText,
                          boxShadow: Flukit.boxShadow(
                            color: Flukit.theme.palette.shadow,
                            offset: const Offset(-5, 15),
                            opacity: .06
                          ),
                        ),
                      ),
                    ),
                    widget.headerAction ?? AnimatedOpacity(
                      opacity: onFirstPage ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: FluButton(
                        onPressed: onFirstPage ? () => Flukit.showCountrySelectionBottomSheet(
                          context: context,
                          onCountrySelected: (FluCountryModel country) {
                            controller.setRegion(country.isoCode);
                          }
                        ) : null,
                        height: FluConsts.minElSize + 5,
                        radius: FluConsts.defaultElRadius - 2,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        backgroundColor: Flukit.theme.backgroundColor.withOpacity(.25),
                        boxShadow: Flukit.boxShadow(
                          color: Flukit.theme.palette.primary,
                          offset: const Offset(15, 15),
                          opacity: .1
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