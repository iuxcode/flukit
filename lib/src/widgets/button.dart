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

  const FluButton({
    Key? key,
    this.onLongPress,
    this.onPressed,
    this.style,
    required this.child
  }) : super(key: key);

  factory FluButton.icon({
    required FluIconModel icon,
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
      alignment: Alignment.center,
      backgroundColor: Flukit.theme.data.backgroundColor
    ).merge(style);

    return FluButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      child: FluIcon(
        icon: icon,
        style: FluIconStyle(
          size: 20,
          strokeWidth: 1.5,
          color: style.color
        ).merge(style.iconStyle)
      )
    );
  }
  
  factory FluButton.text({
    required String text,
    final FluIconModel? prefixIcon,
    final FluIconModel? suffixIcon,
    void Function()? onPressed,
    void Function()? onLongPress,
    FluButtonStyle? style,
    TextStyle? textStyle,
    double spacing = 4,
  }) {
    style = FluButtonStyle(
      margin: EdgeInsets.zero,
    ).merge(style);
    Widget spacer = SizedBox(width: spacing);
    Widget _icon(FluIconModel? icon, [bool pref = false]) => icon != null ? FluIcon(
      icon: icon,
      style: FluIconStyle(
        size: 20,
        strokeWidth: 1.5,
        color: style?.color ?? Flukit.themePalette.light
      ).merge(style?.iconStyle)
    ) : Container();

    return FluButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _icon(prefixIcon, prefixIcon != null),
          if(prefixIcon != null) spacer,
          Text(text, style: Flukit.textTheme.bodyText1?.copyWith(
            color: style.color,
          ).merge(textStyle)),
          if(suffixIcon != null) spacer,
          _icon(suffixIcon, suffixIcon != null),
        ],
      )
    );
  }

  factory FluButton.back({
    required String text,
    VoidCallback? onGoingBack,
    VoidCallback? onLongPress,
    Color? color,
    BoxShadow? boxShadow,
  }) => FluButton.icon(
    onPressed: () {
      onGoingBack?.call();
      Get.back();
    },
    onLongPress: onLongPress,
    icon: FluTwotoneIcons.arrow_arrowLeft,
    style: FluButtonStyle(
      color: color ?? Flukit.theme.textColor,
      backgroundColor: Flukit.theme.backgroundColor,
      boxShadow: boxShadow ?? Flukit.boxShadow(
        offset: const Offset(15, 15),
      )
    ),
  );

  @override
  State<FluButton> createState() => _FluButtonState();
}

class _FluButtonState extends State<FluButton> {
  bool get isLoading => widget.style?.loading ?? false;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    height: widget.style?.height ?? Flukit.appConsts.defaultElSize,
    width: widget.style?.width,
    margin: widget.style?.margin,
    duration: widget.style?.animationDuration ?? const Duration(milliseconds: 300),
    curve: widget.style?.animationCurve ?? Curves.linear,
    alignment: widget.style?.alignment ?? Alignment.center,
    decoration: BoxDecoration(
      border: widget.style?.border,
      borderRadius: widget.style?.borderRadius ?? BorderRadius.circular(widget.style?.radius ?? Flukit.appConsts.defaultElRadius),
      boxShadow: [
        if(widget.style != null && widget.style?.boxShadow != null) widget.style!.boxShadow!
      ]
    ),
    child: TextButton(
      onPressed: widget.onPressed != null ? () => {
        if(!isLoading) {
          Flukit.selectionClickHaptic(),
          widget.onPressed!()
        }
      } : null,
      onLongPress: widget.onLongPress,
      style: TextButton.styleFrom(
        fixedSize: const Size(double.infinity, double.infinity),
        primary: widget.style?.color,
        backgroundColor: widget.style?.backgroundColor ?? Flukit.theme.data.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: widget.style?.borderRadius ?? BorderRadius.circular(widget.style?.radius ?? Flukit.appConsts.defaultElRadius
        )),
        padding: widget.style?.padding ?? const EdgeInsets.symmetric(horizontal: 15)
      ),
      child: !isLoading ? widget.child : Center(
        child: widget.style?.loadingWidget ?? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(widget.style?.color ?? Flukit.themePalette.dark),
          strokeWidth: 2
        )),
      )
    )
  );
}

class FluButtonStyle {
  double? height;
  double? width;
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
  Alignment alignment;
  FluIconStyle? iconStyle;

  FluButtonStyle({
    this.height,
    this.width,
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
    this.alignment = Alignment.center,
    this.iconStyle
  });

  FluButtonStyle merge(FluButtonStyle? buttonStyle) => FluButtonStyle(
    height: buttonStyle?.height ?? height,
    width: buttonStyle?.width ?? width,
  );
}