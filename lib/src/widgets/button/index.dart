import 'package:flukit/src/utils/flu_utils.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'style.dart';

class FluButton extends StatefulWidget {
  /// Handle the button press event.
  final void Function()? onPressed;

  /// Handle the button long press event.
  final void Function()? onLongPress;

  /// Button style.
  final FluButtonStyle? style;

  /// Button content.
  final Widget child;

  const FluButton({
    super.key,
    this.onLongPress,
    this.onPressed,
    this.style,
    required this.child,
  });

  factory FluButton.icon({
    required FluIcons icon,
    void Function()? onPressed,
    void Function()? onLongPress,
    FluButtonStyle? style,
    int iconQuarterTurn = 0,
  }) {
    style = FluButtonStyle.flat
        .copyWith(
          height: Flukit.appSettings.minElSize,
          width: Flukit.appSettings.minElSize,
          radius: Flukit.appSettings.minElRadius,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          background: Flukit.theme.background,
        )
        .merge(style);

    return FluButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      child: RotatedBox(
        quarterTurns: iconQuarterTurn,
        child: FluIcon(
          icon,
          size: style.iconSize,
          strokewidth: style.iconStrokewidth,
          color: style.color,
          style: style.iconStyle,
        ),
      ),
    );
  }

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
    style = FluButtonStyle.flat.merge(FluButtonStyle(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
    ).merge(style));

    Widget buildIcon(FluIcons icon) => FluIcon(
          icon,
          size: style!.iconSize,
          strokewidth: style.iconStrokewidth,
          color: style.color ?? Flukit.theme.light,
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
                style: Flukit.textTheme.bodyText1
                    ?.copyWith(
                      color: style.color,
                    )
                    .merge(textStyle)),
            if (suffixIcon != null) buildIcon(suffixIcon),
          ],
        ));
  }

  factory FluButton.back({
    Color? color,
    BoxShadow? boxShadow,
    FluIcons? icon,
    double iconSize = 20,
    double iconStrokewidth = 1.6,
    VoidCallback? onGoingBack,
    VoidCallback? onLongPress,
  }) =>
      FluButton.icon(
        onPressed: () {
          onGoingBack?.call();
          Get.back();
        },
        onLongPress: onLongPress,
        icon: icon ?? FluIcons.arrowLeft,
        style: FluButtonStyle(
          iconSize: iconSize,
          iconStrokewidth: iconStrokewidth,
          color: color ?? Flukit.theme.text,
          background: Flukit.theme.background,
          boxShadow: boxShadow ??
              Flukit.boxShadow(
                offset: const Offset(15, 15),
              ),
        ),
      );

  @override
  State<FluButton> createState() => _FluButtonState();
}

class _FluButtonState extends State<FluButton> {
  bool get isLoading => widget.style?.loading ?? false;
  FluButtonStyle get style => widget.style ?? FluButtonStyle.defaultt;

  void onPressed() {
    if (widget.onPressed != null) {
      if (!isLoading) {
        Flukit.selectionClickHaptic();
        widget.onPressed!();
      }
    }
  }

  void onLongPress() => widget.onLongPress ?? () => Flukit.selectionClickHaptic();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: style.height,
      width: style.expand ? double.infinity : style.width,
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
                style.radius ?? Flukit.appSettings.defaultElRadius),
        boxShadow: [if (style.boxShadow != null) style.boxShadow!],
      ),
      child: TextButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          fixedSize: MaterialStateProperty.all(
              const Size(double.infinity, double.infinity)),
          backgroundColor:
              MaterialStateProperty.all(style.background ?? Flukit.theme.primary),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: style.borderRadius ??
                  BorderRadius.circular(
                    style.radius ?? Flukit.appSettings.defaultElRadius,
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
                            style.color ?? Flukit.theme.dark),
                        strokeWidth: 2,
                      ),
                    ),
              ),
      ),
    );
  }
}
