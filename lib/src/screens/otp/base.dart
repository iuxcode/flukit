import 'dart:async';
import 'dart:math' as math;

import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FluBasicOtpScreen extends StatefulWidget {
  final FluOtpScreenController? controller;
  final int waitingTime;
  final String image;
  final FluImageType? imageType;
  final String? title, desc, buttonText, codeAskButtonText, inputHint, inputErrorText;
  final FluIconModel? buttonIcon;
  final String authRoute;
  final OnAuthGoingForwardFunction onGoingForward;
  final Future<int> Function(FluOtpScreenController controller, TextEditingController inputController) onAskCode;

  const FluBasicOtpScreen({
    Key? key,
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
    this.waitingTime = 500
  }) : super(key: key);

  @override
  State<FluBasicOtpScreen> createState() => _FluBasicOtpScreenState();
}

class _FluBasicOtpScreenState extends State<FluBasicOtpScreen> {
  late FluOtpScreenController controller;
  late Timer _timer;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController inputController = TextEditingController();
  
  List<FluAuthScreenStep> buildSteps() => <FluAuthScreenStep>[
    FluAuthScreenInputStep(
      image: widget.image,
      imageType: widget.imageType,
      title: widget.title ?? 'Lorem ipsum dolor sit amet',
      desc: widget.desc ?? 'consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      inputHint: widget.inputHint ?? 'Enter the OTP code.',
      buttonLabel: widget.buttonText ?? 'Verify',
      buttonIcon: widget.buttonIcon ?? FluBulkIcons.security_scan,
    )
  ];

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

  void onInit() async {
    await Flukit.appController.setAuthorizationState(FluAuthorizationStates.waitCode)
      .onError((error, stackTrace) => throw {"Error while setting authorizationState parameter in secure storage.", error, stackTrace});
  }

  @override
  void initState() {
    /// initialize controller
    controller = Get.put(
      widget.controller ?? FluOtpScreenController(
        initialSteps: buildSteps(),
      ),
      tag: 'AuthScreenController_' + math.Random().nextInt(99999).toString()
    );

    onInit();
    startTimer(widget.waitingTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FluSteppedAuthScreen(
      controller: controller,
      onGoingBack: (FluAuthScreenController controller, TextEditingController inputController, bool onFirstPage, bool onLastPage) => widget.authRoute,
      onGoingForward: widget.onGoingForward,
      headerAction: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) => SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(animation),
          child: child,
        ),
        child: Obx(() => controller.canAsk ? FluButton.text(
          onPressed: () async {
            int waitingTime = await widget.onAskCode(controller, inputController);
            if(waitingTime > 0) startTimer(waitingTime);
          },
          suffixIcon: FluTwotoneIcons.arrow_refresh,
          text: widget.codeAskButtonText ?? 'Resend the code.',
          textStyle: TextStyle(fontWeight: Flukit.appConsts.textSemibold),
          spacing: 10,
          style: FluButtonStyle(
            loading: controller.askLoading,
            height: Flukit.appConsts.minElSize,
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            color: Flukit.themePalette.accentText,
            iconStyle: FluIconStyle(
              size: 20,
              strokeWidth: 1.8,
            )
          ),
        ) : Row(
          children: [
            Text(Flukit.timeLeft(controller.waitingTime), style: Flukit.textTheme.bodyText1!.copyWith(
              color: Flukit.themePalette.accentText,
              fontSize: Flukit.appConsts.bodyFs + 1,
              fontWeight: Flukit.appConsts.textBold
            )),
            const SizedBox(width: 10),
            FluIcon(
              icon: FluTwotoneIcons.arrow_refresh,
              style: FluIconStyle(
                size: 20,
                strokeWidth: 2.5,
                color: Flukit.theme.primaryColor,
              ),
            )
          ],
        )),
      )
    );
  }
}