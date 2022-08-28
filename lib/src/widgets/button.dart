import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/flu_utils.dart';

class FluButton extends StatefulWidget {
  /// Handle the button press event.
  final void Function()? onPressed;

  /// Handle the button long press event.
  final void Function()? onLongPress;

  /// Button style.
  final FluButtonStyle? style;

  /// Button child.
  final Widget child;

  const FluButton(
      {Key? key, this.onLongPress, this.onPressed, this.style, required this.child})
      : super(key: key);

  factory FluButton.icon({
    required FluIcons icon,
    void Function()? onPressed,
    void Function()? onLongPress,
    FluButtonStyle? style,
  }) {
    style = FluButtonStyle(
            height: Flukit.appConsts.minElSize,
            width: Flukit.appConsts.minElSize,
            radius: Flukit.appConsts.minElRadius,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            // alignment: Alignment.center,
            backgroundColor: Flukit.theme.data.backgroundColor)
        .merge(style);

    return FluButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: style,
        child: FluIcon(
          icon,
          size: style.iconSize,
          strokewidth: style.iconStrokewidth,
          color: style.color,
          style: style.iconStyle,
        ));
  }

  factory FluButton.text({
    required String text,
    final FluIcons? prefixIcon,
    final FluIcons? suffixIcon,
    void Function()? onPressed,
    void Function()? onLongPress,
    FluButtonStyle? style,
    TextStyle? textStyle,
    double spacing = 4,
  }) {
    style = FluButtonStyle.flat.merge(FluButtonStyle(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
    ).merge(style));

    Widget spacer = SizedBox(width: spacing);
    Widget _icon(FluIcons? icon, [bool pref = false]) => icon != null
        ? FluIcon(
            icon,
            size: style!.iconSize,
            strokewidth: style.iconStrokewidth,
            color: style.color ?? Flukit.themePalette.light,
            style: style.iconStyle,
          )
        : Container();

    return FluButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: style,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _icon(prefixIcon, prefixIcon != null),
            if (prefixIcon != null) spacer,
            Text(text,
                style: Flukit.textTheme.bodyText1
                    ?.copyWith(
                      color: style.color,
                    )
                    .merge(textStyle)),
            if (suffixIcon != null) spacer,
            _icon(suffixIcon, suffixIcon != null),
          ],
        ));
  }

  factory FluButton.back({
    VoidCallback? onGoingBack,
    VoidCallback? onLongPress,
    Color? color,
    BoxShadow? boxShadow,
  }) =>
      FluButton.icon(
        onPressed: () {
          onGoingBack?.call();
          Get.back();
        },
        onLongPress: onLongPress,
        icon: FluIcons.arrowLeft,
        style: FluButtonStyle(
            color: color ?? Flukit.theme.textColor,
            backgroundColor: Flukit.theme.backgroundColor,
            boxShadow: boxShadow ??
                Flukit.boxShadow(
                  offset: const Offset(15, 15),
                )),
      );

  @override
  State<FluButton> createState() => _FluButtonState();
}

class _FluButtonState extends State<FluButton> {
  bool get isLoading => widget.style?.loading ?? false;
  FluButtonStyle get style => widget.style ?? FluButtonStyle.main;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
      height: style.height,
      width: style.expand ? double.infinity : style.width,
      margin: style.margin,
      duration: style.animationDuration ?? const Duration(milliseconds: 300),
      curve: style.animationCurve ?? Curves.linear,
      // alignment: style.alignment ?? Alignment.centerLeft,
      constraints: BoxConstraints(
        minWidth: style.minWidth ?? 0.0,
        maxWidth: style.maxWidth ?? double.infinity,
      ),
      decoration: BoxDecoration(
        border: style.border,
        borderRadius: style.borderRadius ??
            BorderRadius.circular(style.radius ?? Flukit.appConsts.defaultElRadius),
        boxShadow: [if (style.boxShadow != null) style.boxShadow!],
      ),
      child: TextButton(
          onPressed: widget.onPressed != null
              ? () => {
                    if (!isLoading)
                      {Flukit.selectionClickHaptic(), widget.onPressed!()}
                  }
              : null,
          onLongPress: widget.onLongPress,
          /* style: TextButton.styleFrom(
            fixedSize: style.height != null
                ? const Size(double.infinity, double.infinity)
                : null,
            primary: style.color,
            backgroundColor:
                style.backgroundColor ?? Flukit.theme.data.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: style.borderRadius ??
                    BorderRadius.circular(
                        style.radius ?? Flukit.appConsts.defaultElRadius)),
            padding:
                style.padding ?? const EdgeInsets.symmetric(horizontal: 15),
            alignment: style.alignment ?? Alignment.center,
          ), */
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            fixedSize: MaterialStateProperty.all(
                /* style.height != null
                  ?  */
                const Size(double.infinity, double.infinity)
                // : null,
                ),
            // primary: MaterialStateProperty.all(style.color),
            backgroundColor: MaterialStateProperty.all(
                style.backgroundColor ?? Flukit.theme.data.primaryColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: style.borderRadius ??
                    BorderRadius.circular(
                        style.radius ?? Flukit.appConsts.defaultElRadius),
              ),
            ),
            padding: MaterialStateProperty.all(
                style.padding ?? const EdgeInsets.symmetric(horizontal: 15)),
            // alignment: style.alignment ?? Alignment.centerLeft,
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
                                  style.color ?? Flukit.themePalette.dark),
                              strokeWidth: 2)),
                )));
}

class FluButtonStyle {
  double? height;
  double? width;
  double? minWidth;
  double? maxWidth;
  double? radius;
  EdgeInsets? margin;
  EdgeInsets? padding;
  Border? border;
  BorderRadius? borderRadius;
  Duration? animationDuration;
  Curve? animationCurve;
  BoxShadow? boxShadow;
  Color? color;
  Color? backgroundColor;
  bool loading;
  Widget? loadingWidget;
  Alignment? alignment;
  FluIconStyles iconStyle;
  final double iconSize, iconStrokewidth;

  /// make the button expand to the full width of the screen
  bool expand;

  FluButtonStyle({
    this.height,
    this.width,
    this.minWidth,
    this.maxWidth,
    this.radius,
    this.margin = EdgeInsets.zero,
    this.padding,
    this.boxShadow,
    this.backgroundColor,
    this.border,
    this.borderRadius,
    this.color = Colors.white,
    this.animationDuration,
    this.animationCurve,
    this.loading = false,
    this.loadingWidget,
    this.alignment,
    this.iconStyle = FluIconStyles.twotone,
    this.expand = false,
    this.iconSize = 22,
    this.iconStrokewidth = 1.5,
  });

  FluButtonStyle merge(FluButtonStyle? buttonStyle) => FluButtonStyle(
        height: buttonStyle?.height ?? height,
        width: buttonStyle?.width ?? width,
        minWidth: buttonStyle?.minWidth ?? minWidth,
        maxWidth: buttonStyle?.maxWidth ?? maxWidth,
        radius: buttonStyle?.radius ?? radius,
        margin: buttonStyle?.margin ?? margin,
        padding: buttonStyle?.padding ?? padding,
        boxShadow: buttonStyle?.boxShadow ?? boxShadow,
        backgroundColor: buttonStyle?.backgroundColor ?? backgroundColor,
        border: buttonStyle?.border ?? border,
        borderRadius: buttonStyle?.borderRadius ?? borderRadius,
        color: buttonStyle?.color ?? color,
        animationDuration: buttonStyle?.animationDuration ?? animationDuration,
        animationCurve: buttonStyle?.animationCurve ?? animationCurve,
        loading: buttonStyle?.loading ?? loading,
        loadingWidget: buttonStyle?.loadingWidget ?? loadingWidget,
        alignment: buttonStyle?.alignment ?? alignment,
        iconStyle: buttonStyle?.iconStyle ?? iconStyle,
        expand: buttonStyle?.expand ?? expand,
        iconSize: buttonStyle?.iconSize ?? iconSize,
        iconStrokewidth: buttonStyle?.iconStrokewidth ?? iconStrokewidth,
      );

  /// Defining styles
  static FluButtonStyle flat = FluButtonStyle(
    backgroundColor: Colors.transparent,
    color: Flukit.themePalette.accentText,
  );

  static FluButtonStyle main = FluButtonStyle(
      height: Flukit.appConsts.defaultElSize,
      radius: Flukit.appConsts.defaultElRadius,
      backgroundColor: Flukit.theme.primaryColor,
      color: Flukit.themePalette.light,
      padding: const EdgeInsets.symmetric(horizontal: 20));
}
