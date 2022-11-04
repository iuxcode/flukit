import 'dart:async';
import 'dart:math' as math;

import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FluBasicOtpScreen extends StatefulWidget {
  final FluOtpScreenController? controller;
  final int initialWaitTime;
  final String image;
  final FluImageSource? imageType;
  final String? title,
      desc,
      buttonText,
      codeAskButtonText,
      inputHint,
      inputErrorText;
  final FluIcons? buttonIcon;
  final String authRoute;
  final OnAuthGoingForwardFunction onGoingForward;
  final Future<int> Function(FluOtpScreenController controller,
      TextEditingController inputController) onAskCode;

  const FluBasicOtpScreen(
      {Key? key,
      required this.authRoute,
      required this.onGoingForward,
      required this.onAskCode,
      this.controller,
      this.image = '',
      this.imageType,
      this.title,
      this.desc,
      this.buttonText,
      this.codeAskButtonText,
      this.inputHint,
      this.buttonIcon,
      this.inputErrorText,
      this.initialWaitTime = 120})
      : super(key: key);

  @override
  State<FluBasicOtpScreen> createState() => _FluBasicOtpScreenState();
}

class _FluBasicOtpScreenState extends State<FluBasicOtpScreen> {
  late FluOtpScreenController controller;
  late Timer _timer;

  final TextEditingController inputController = TextEditingController();

  List<FluAuthScreenStep> buildSteps() => <FluAuthScreenStep>[
        FluAuthScreenInputStep(
          image: widget.image,
          imageType: widget.imageType,
          title: widget.title ?? 'Lorem ipsum dolor sit amet',
          desc: widget.desc ??
              'consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          inputHint: widget.inputHint ?? 'Enter the OTP code.',
          buttonLabel: widget.buttonText ?? 'Verify',
          buttonIcon: widget.buttonIcon ?? FluIcons.scan,
        )
      ];

  /// time to wait before user will be able to ask for another OTP
  void startTimer(int seconds) {
    controller.canAsk = false;
    controller.waitingTime = seconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (controller.waitingTime > 0) {
        controller.waitingTime--;
      } else {
        _timer.cancel();
        controller.canAsk = true;
      }
    });
  }

  void onInit() async {
    await Flu.appController
        .setAuthorizationState(FluAuthorizationStates.waitCode)
        .onError((error, stackTrace) => throw {
              "Error while setting authorizationState parameter in secure storage.",
              error,
              stackTrace
            })
        .whenComplete(() => startTimer(widget.initialWaitTime));
  }

  @override
  void initState() {
    /// initialize controller
    controller = Get.put(
        widget.controller ??
            FluOtpScreenController(
              initialSteps: buildSteps(),
            ),
        tag: 'AuthScreenController_${math.Random().nextInt(99999)}');

    onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FluSteppedAuthScreen(
        controller: controller,
        onGoingBack: (FluAuthScreenController controller,
                TextEditingController inputController,
                bool onFirstPage,
                bool onLastPage) =>
            widget.authRoute,
        onGoingForward: widget.onGoingForward,
        headerAction: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) => SlideTransition(
            position: Tween<Offset>(
                    begin: const Offset(0, 1), end: const Offset(0, 0))
                .animate(animation),
            child: child,
          ),
          child: Obx(() => controller.canAsk
              ? FluButton.text(
                  onPressed: () async {
                    int waitingTime =
                        await widget.onAskCode(controller, inputController);
                    if (waitingTime > 0) startTimer(waitingTime);
                  },
                  suffixIcon: FluIcons.refresh,
                  text: widget.codeAskButtonText ?? 'Resend the code.',
                  textStyle:
                      TextStyle(fontWeight: Flu.appSettings.textSemibold),
                  spacing: 10,
                  style: FluButtonStyle(
                    loading: controller.askLoading,
                    height: Flu.appSettings.minElSize,
                    padding: EdgeInsets.zero,
                    background: Colors.transparent,
                    color: Flu.theme().accentText,
                    iconSize: 20,
                    iconStrokewidth: 1.8,
                  ))
              : Row(
                  children: [
                    Text(Flu.timeLeft(controller.waitingTime),
                        style: Flu.textTheme.bodyText1!.copyWith(
                            color: Flu.theme().accentText,
                            fontSize: Flu.appSettings.bodyFs + 1,
                            fontWeight: Flu.appSettings.textBold)),
                    const SizedBox(width: 10),
                    FluIcon(
                      FluIcons.refresh,
                      size: 20,
                      strokewidth: 2.5,
                      color: Flu.theme().primary,
                    )
                  ],
                )),
        ));
  }
}
