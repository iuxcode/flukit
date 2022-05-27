import 'package:flukit/flukit.dart';
import 'package:flukit/src/controllers/screens/splashScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FluSplashScreen extends StatefulWidget {
  final void Function()? onInitialized;
  final FluSplashScreenController? controller;
  final Widget Function(FluSplashScreenController)? builder;
  final Widget? child;
  final String? title;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final Color? titleColor;
  final TextStyle? titleTextstyle;

  const FluSplashScreen({
    Key? key,
    this.onInitialized,
    this.controller,
    this.builder,
    this.child,
    this.title,
    this.titleFontSize,
    this.titleFontWeight,
    this.titleColor,
    this.titleTextstyle
  }): assert(
    (builder != null && (child == null && title == null)) ||
    ((child != null && title != null) && builder == null)
  ), super(key: key);

  @override
  State<FluSplashScreen> createState() => _FluSplashScreenState();
}

class _FluSplashScreenState extends State<FluSplashScreen> {
  late FluSplashScreenController controller;

  @override
  void initState() {
    controller = Get.put<FluSplashScreenController>(widget.controller ?? FluSplashScreenController(widget.onInitialized));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FluScreen(
    body: GetBuilder<FluSplashScreenController>(
      init: controller,
      initState: (_) {},
      builder: widget.builder ?? (_) {
        return SafeArea(
          child: Column(children: [
            Expanded(
              child: Center(child: widget.child)
            ),
            Padding(
              padding: EdgeInsets.only(bottom: Flukit.screenSize.height * .15),
              child: Text(
                widget.title!,
                style: widget.titleTextstyle ?? TextStyle(
                  fontSize: widget.titleFontSize ?? FluConsts.titleFs,
                  fontWeight: widget.titleFontWeight ?? FluConsts.textSemibold,
                  color: widget.titleColor ?? Flukit.theme.accentTextColor,
                ),
              ),
            ),
          ])
        );
      },
    )
  );
}