import 'package:flukit/src/utils/flu_utils.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'style.dart';

class FluButton extends StatefulWidget {
  const FluButton({
    super.key,
    this.onLongPress,
    this.onPressed,
    this.style,
    required this.child,
  });

  /// You can use this button to get back to the previous page.
  factory FluButton.back({
    Color? color,
    BoxShadow? boxShadow,
    FluIcons? icon,
    double iconSize = 20,
    double iconStrokewidth = 1.6,
    VoidCallback? onGoingBack,
  }) =>
      FluButton.icon(
        onPressed: () {
          onGoingBack?.call();
          Get.back();
        },
        icon: icon ?? FluIcons.arrowLeft,
        style: FluButtonStyle(
            iconSize: iconSize,
            iconStrokewidth: iconStrokewidth,
            color: color ?? Flu.theme().text,
            background: Flu.theme().background,
            boxShadow: boxShadow ??
                Flu.boxShadow(
                  offset: const Offset(15, 15),
                )),
      );

  /// If you need an icon-only button, this is for you !!!
  /// you can use [iconRotationQuarterTurn] or [rotationAngle] to rotate the icon.
  factory FluButton.icon({
    required FluIcons icon,
    void Function()? onPressed,
    void Function()? onLongPress,
    FluButtonStyle? style,
    int iconRotationQuarterTurn = 0,
    double? rotationAngle,
  }) {
    style = FluButtonStyle.flat
        .copyWith(
          height: Flu.appSettings.minElSize,
          square: true,
          cornerRadius: Flu.appSettings.minElRadius,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          background: Flu.theme().background,
        )
        .merge(style);

    Widget iconWidget = FluIcon(
      icon,
      size: style.iconSize,
      strokewidth: style.iconStrokewidth,
      color: style.color,
      style: style.iconStyle,
    );

    return FluButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      child: rotationAngle != null
          ? Transform.rotate(
              angle: rotationAngle,
              child: iconWidget,
            )
          : RotatedBox(
              quarterTurns: iconRotationQuarterTurn, child: iconWidget),
    );
  }

  /// Use this if you're looking for a button with text with or without an icon.
  /// [spacing] define the amount of space between text and icon(s).
  factory FluButton.text({
    required String text,
    final FluIcons? prefixIcon,
    final FluIcons? suffixIcon,
    void Function()? onPressed,
    void Function()? onLongPress,
    FluButtonStyle? style,
    TextStyle? textStyle,
    double spacing = 6,
  }) {
    style = FluButtonStyle.flat.merge(const FluButtonStyle(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
    ).merge(style));

    Widget buildIcon(FluIcons icon) => FluIcon(
          icon,
          size: style!.iconSize,
          strokewidth: style.iconStrokewidth,
          color: style.color ?? Flu.theme().light,
          style: style.iconStyle,
          margin: EdgeInsets.only(
            right: prefixIcon != null ? spacing : 0,
            left: suffixIcon != null ? spacing : 0,
          ),
        );

    return FluButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: style,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixIcon != null) buildIcon(prefixIcon),
            Text(text,
                style: Flu.textTheme.bodyText1
                    ?.copyWith(
                      color: style.color,
                    )
                    .merge(textStyle)),
            if (suffixIcon != null) buildIcon(suffixIcon),
          ],
        ));
  }

  /// Handle the button press event.
  final void Function()? onPressed;

  /// Handle the button long press event.
  final void Function()? onLongPress;

  /// Button content.
  final Widget child;

  /// Button style.
  final FluButtonStyle? style;

  @override
  State<FluButton> createState() => _FluButtonState();
}

class _FluButtonState extends State<FluButton> {
  bool get isLoading => widget.style?.loading ?? false;
  FluButtonStyle get style => widget.style ?? FluButtonStyle.primary;

  void onPressed() {
    if (!isLoading && widget.onPressed != null) {
      Flu.physicFeedback();
      widget.onPressed!.call();
    }
  }

  void onLongPress() {
    if (!isLoading && widget.onLongPress != null) {
      Flu.physicFeedback();
      widget.onLongPress!.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    double? height, width;

    if (style.square) {
      if (style.height != null && style.width == null) {
        height = style.height;
        width = style.height;
      } else if (style.height == null && style.width != null) {
        height = style.width;
        width = style.width;
      } else if (style.height != null && style.width != null) {
        height = style.height;
        width = style.height;
      } else {
        height = Flu.appSettings.defaultElSize;
        width = Flu.appSettings.defaultElSize;
      }
    } else
      height = style.height;
    width = style.width;

    /// TODO: remove either the container shadow or the textButton one.
    return AnimatedContainer(
      height: height,
      width: style.block ? double.infinity : width,
      margin: style.margin,
      duration: style.animationDuration ?? const Duration(milliseconds: 300),
      curve: style.animationCurve ?? Curves.linear,
      constraints: BoxConstraints(
        minWidth: style.minWidth ?? 0.0,
        maxWidth: style.maxWidth ?? double.infinity,
      ),
      decoration: BoxDecoration(
        border: style.border,
        borderRadius: style.borderRadius ??
            BorderRadius.circular(
                style.cornerRadius ?? Flu.appSettings.defaultElRadius),
        boxShadow: [if (style.boxShadow != null) style.boxShadow!],
      ),
      child: TextButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          fixedSize: MaterialStateProperty.all(
              const Size(double.infinity, double.infinity)),
          backgroundColor: MaterialStateProperty.all(
              style.background ?? Flu.theme().primary),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: style.borderRadius ??
                  BorderRadius.circular(
                    style.cornerRadius ?? Flu.appSettings.defaultElRadius,
                  ),
            ),
          ),
          padding: MaterialStateProperty.all(
              style.padding ?? const EdgeInsets.symmetric(horizontal: 15)),
          alignment: style.alignment,
        ),
        child: !isLoading
            ? widget.child
            : Center(
                child: style.loadingWidget ??
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            style.color ?? Flu.theme().dark),
                        strokeWidth: 2,
                      ),
                    ),
              ),
      ),
    );
  }
}
