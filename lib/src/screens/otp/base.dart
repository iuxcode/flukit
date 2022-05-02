import 'dart:async';
import 'dart:convert';

import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class FluBasicOtpScreen extends StatefulWidget {
  final int waitingTime;
  final String? title, desc, buttonText, codeAskButtonText, inputHint, inputErrorText;
  final FluIconModel? buttonIcon;
  final void Function() onGoingBack;
  final void Function(String value, FluOtpScreenController controller) onGoingForward;
  final void Function(FluOtpScreenController controller) onAskCode;

  const FluBasicOtpScreen({
    Key? key,
    required this.onGoingBack,
    required this.onGoingForward,
    required this.onAskCode,
    this.title,
    this.desc,
    this.buttonText,
    this.codeAskButtonText,
    this.inputHint,
    this.buttonIcon,
    this.inputErrorText,
    this.waitingTime = 500
  }) : super(key: key);

  @override
  State<FluBasicOtpScreen> createState() => _FluBasicOtpScreenState();
}

class _FluBasicOtpScreenState extends State<FluBasicOtpScreen> {
  late Timer _timer;

  final FluOtpScreenController controller = FluOtpScreenController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController inputController = TextEditingController();

  /// time to wait before user will be able to ask for another OTP
  void startTimer(int seconds) {
    controller.canAsk = false;
    controller.waitingTime = seconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(controller.waitingTime > 0){
        controller.waitingTime--;
      }else{
        _timer.cancel();
        controller.canAsk = true;
      }
    });
  }

  /// check if input value is empty or not.
  String? inputValidator(String? value) => value!.isEmpty ? 'incorrect' : null;

  /// On input value changed, we reset the error state and make user able to submit or not.
  void onInputValueChanged(String value) {
    controller.hasError = false;
    controller.canSubmit = value.isNotEmpty;
  }

  void onSubmit(BuildContext context) async {
    /// if keyboard is visible, let's hide it.
    FocusScope.of(context).unfocus();

    /// ensure that another action is not ongoing.
    if(!controller.loading) {
      /// let's validate the form and do the correct action for each page.
      if (_formKey.currentState!.validate()) {
        controller.loading = true;
        controller.canSubmit = false;

        widget.onGoingForward(inputController.text, controller);

        controller.loading = false;
      }
      /// if form not valid, display the right error message.
      else {
        controller.loading = false;
        controller.canSubmit = true;

        Flukit.throwError(widget.inputErrorText ?? 'OTP cannot be empty.');
      }
    }
  }

  @override
  void initState() {
    startTimer(widget.waitingTime);
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
                Expanded(child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Flukit.theme.secondaryColor,
                      Flukit.theme.backgroundColor
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
                  ),
                )),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: FluConsts.defaultPaddingSize
                  ).copyWith(top: 25, bottom: !Flukit.isKeyboardHidden(context) ? 25 : 0),
                  child: Column(
                    children: [
                      Hero(
                        tag: '< title_text >',
                        child: Text(widget.title ?? 'Lorem ipsum dolor sit amet', textAlign: TextAlign.center, style: Flukit.textTheme.headline1?.copyWith(
                          fontSize: FluConsts.headlineFs
                        )),
                      ),
                      const SizedBox(height: 5),
                      Hero(
                        tag: '< desc_text >',
                        child: Text(
                          widget.desc ?? 'consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                          textAlign: TextAlign.center,
                          style: Flukit.textTheme.bodyText1
                        )
                      ),
                      Obx(() => FluTextInput(
                        controller: inputController,
                        height: FluConsts.defaultElSize,
                        hintText: widget.inputHint ?? 'Enter the OTP code.',
                        hintColor: controller.hasError ? Flukit.themePalette.danger : Flukit.themePalette.text,
                        color: controller.hasError ? Flukit.themePalette.danger : Flukit.themePalette.accentText,
                        borderColor: (controller.hasError ? Flukit.theme.palette.danger : Flukit.theme.backgroundColor).withOpacity(.015),
                        borderWidth: 1.5,
                        margin: const EdgeInsets.only(top: 15, bottom: 8),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [LengthLimitingTextInputFormatter(15)],
                        validator: inputValidator,
                        onChanged: onInputValueChanged,
                      )),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: !Flukit.isKeyboardHidden(context) ? Hero(
                          tag: '< main_button >',
                          child: Obx(() => FluButton.text(
                            onPressed: () => controller.canSubmit ? widget.onGoingForward(inputController.text, controller) : null,
                            loading: controller.loading,
                            height: FluConsts.defaultElSize,
                            width: double.infinity,
                            padding: EdgeInsets.zero,
                            text: widget.buttonText ?? 'Verify',
                            prefixIcon: widget.buttonIcon ?? FluBulkIcons.security_scan,
                            iconSize: 24,
                            iconStrokeWidth: 1.8,
                            color: controller.canSubmit ? Flukit.theme.primaryTextColor : Flukit.theme.palette.accentText,
                            backgroundColor: controller.canSubmit ? Flukit.theme.primaryColor : Flukit.theme.secondaryColor,
                            textStyle: TextStyle(
                              fontWeight: FluConsts.textBold
                            ),
                            boxShadow: Flukit.boxShadow(
                              blurRadius: 30,
                              opacity: .025,
                              offset: const Offset(0,0),
                              color: Flukit.themePalette.shadow
                            ),
                          )),
                        ) : Container(),
                      ),
                    ],
                  ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: '< back_button >',
                      child: FluButton.icon(
                        onPressed: widget.onGoingBack,
                        size: FluConsts.minElSize,
                        icon: FluTwotoneIcons.arrow_arrowLeft,
                        iconSize: 24,
                        backgroundColor: Flukit.theme.secondaryColor,
                        color: Flukit.themePalette.accentText,
                        boxShadow: Flukit.boxShadow(
                          color: Flukit.themePalette.shadow,
                          offset: const Offset(-5, 15),
                          opacity: .065
                        )
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) => SlideTransition(
                        position: Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(animation),
                        child: child,
                      ),
                      child: Obx(() => controller.canAsk ? FluButton.text(
                        onPressed: () => widget.onAskCode(controller),
                        loading: controller.askLoading,
                        height: FluConsts.minElSize,
                        padding: EdgeInsets.zero,
                        suffixIcon: FluTwotoneIcons.arrow_refresh,
                        iconSize: 20,
                        iconStrokeWidth: 1.8,
                        text: widget.codeAskButtonText ?? 'Resend the code.',
                        textStyle: TextStyle(fontWeight: FluConsts.textSemibold),
                        spacing: 10,
                        backgroundColor: Colors.transparent,
                        color: Flukit.themePalette.accentText,
                      ) : Row(
                        children: [
                          Text(Flukit.timeLeft(controller.waitingTime), style: Flukit.textTheme.bodyText1!.copyWith(
                            color: Flukit.themePalette.accentText,
                            fontSize: FluConsts.bodyFs + 1,
                            fontWeight: FluConsts.textBold
                          )),
                          const SizedBox(width: 10),
                          FluIcon(
                            icon: FluTwotoneIcons.arrow_refresh,
                            size: 20,
                            strokeWidth: 2.5,
                            color: Flukit.theme.primaryColor,
                          )
                        ],
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}