import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FluSplashScreen extends StatefulWidget {
  final void Function()? onInitialized;
  final FluSplashScreenController? controller;
  final Widget Function(FluSplashScreenController)? builder;
  final Widget? child;
  final TextStyle? textStyle;
  final VoidCallback? onWaitCode;
  final VoidCallback? onWaitAuth;
  final VoidCallback? onWaitTerms;
  final VoidCallback? onReady;
  final VoidCallback? defaultAction;

  const FluSplashScreen({
    Key? key,
    this.onInitialized,
    this.controller,
    this.builder,
    this.child,
    this.textStyle,
    this.onWaitAuth,
    this.onWaitCode,
    this.onWaitTerms,
    this.onReady,
    this.defaultAction,
  })  : assert(builder == null || child == null),
        super(key: key);

  @override
  State<FluSplashScreen> createState() => _FluSplashScreenState();
}

class _FluSplashScreenState extends State<FluSplashScreen> {
  late FluSplashScreenController controller;

  FluStorageService storageService = Flu.secureStorage;

  void onInitialized() async {
    /// TODO check if phone is connected to internet
    /// if not redirect to errors page or get cached data
    if (await storageService
        .containsKey(FluSecureStorageKeys.firstTimeOpening)) {
      String? state =
          await storageService.read(FluSecureStorageKeys.firstTimeOpening);

      if (state != null && state.toLowerCase() == 'false') {
        switch (await Flu.appController.getAuthorizationState()) {
          case FluAuthorizationStates.waitCode:
            widget.onWaitCode?.call();
            break;
          case FluAuthorizationStates.waitTerms:
            widget.onWaitTerms?.call();
            break;
          case FluAuthorizationStates.ready:
            widget.onReady?.call();
            break;
          case FluAuthorizationStates.waitAuth:
          default:
            widget.onWaitAuth?.call();
            break;
        }
      } else {
        widget.defaultAction?.call();
      }
    } else {
      widget.defaultAction?.call();
    }
  }

  @override
  void initState() {
    controller = Get.put(widget.controller ??
        FluSplashScreenController(widget.onInitialized ?? onInitialized));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GetBuilder<FluSplashScreenController>(
      init: controller,
      initState: (_) {},
      builder: widget.builder ??
          (_) => FluScreen(
                body: SafeArea(
                    child: Column(children: [
                  Expanded(child: Center(child: widget.child)),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: Flu.screenSize.height * .15),
                    child: Hero(
                      tag: '</brand>',
                      child: Text(
                        Flu.appInfos.name,
                        style: widget.textStyle ??
                            TextStyle(
                              fontFamily: FluFonts.neptune.name,
                              package: 'flukit',
                              fontSize: Flu.appSettings.subHeadlineFs,
                              fontWeight: FontWeight.bold,
                              color: Flu.theme().accentText,
                            ),
                      ),
                    ),
                  ),
                ])),
              ));
}
