import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import '../configs/theme/tweaks.dart';
import '../utils/flu_utils.dart';

class FluButton extends StatefulWidget {
  final void Function()? onPressed;
  final void Function()? onLongPress;
  final double? height, width, radius;
  final EdgeInsets? margin, padding;
  final Border? border;
  final BorderRadius? borderRadius;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final BoxShadow? boxShadow;
  final Color? color, backgroundColor;
  final bool loading;
  final Widget? loadingWidget;
  final Widget child;

  const FluButton({
    Key? key, 
    this.width,
    this.margin = EdgeInsets.zero,
    this.padding,
    this.boxShadow,
    this.backgroundColor,
    this.height,
    this.radius,
    this.border,
    this.borderRadius,
    this.color = Colors.white,
    this.animationDuration,
    this.animationCurve,
    this.onLongPress,
    this.loading = false,
    this.loadingWidget,
    this.onPressed,
    required this.child
  }) : super(key: key);

  factory FluButton.icon({
    required FluIconModel icon,
    void Function()? onPressed,
    void Function()? onLongPress,
    BoxShadow? boxShadow,
    Color? backgroundColor,
    Color? color,
    Border? border,
    BorderRadius? borderRadius,
    EdgeInsets margin = EdgeInsets.zero,
    EdgeInsets padding = EdgeInsets.zero,
    Duration? animationDuration,
    Curve? animationCurve,
    double? size = 45,
    double? radius,
    double iconSize = 20.0,
    double iconStrokeWidth = 1.5,
    Alignment alignment = Alignment.center
  }) => FluButton(
    onPressed: onPressed,
    onLongPress: onLongPress,
    height: size ?? FluConsts.minElSize,
    width: size ?? FluConsts.minElSize,
    boxShadow: boxShadow,
    backgroundColor: backgroundColor ?? Flukit.theme.data.backgroundColor,
    radius: radius ?? FluConsts.minElRadius,
    animationDuration: animationDuration,
    animationCurve: animationCurve,
    margin: margin,
    padding: padding,
    border: border,
    borderRadius: borderRadius,
    child: FluIcon(
      icon: icon,
      size: iconSize,
      color: color,
      strokeWidth: iconStrokeWidth,
      alignment: alignment,
    )
  );

  
  factory FluButton.text({
    required String text,
    final FluIconModel? prefixIcon,
    final FluIconModel? suffixIcon,
    void Function()? onPressed,
    void Function()? onLongPress,
    BoxShadow? boxShadow,
    Color? backgroundColor,
    Border? border,
    BorderRadius? borderRadius,
    Color color = Colors.white,
    EdgeInsets margin = EdgeInsets.zero, 
    EdgeInsets? padding,
    Duration? animationDuration,
    Curve? animationCurve,
    double? height,
    double? width,
    double? radius,
    TextStyle? textStyle,
    double spacing = 4,
    double iconSize = 20,
    double iconStrokeWidth = 1.5,
    bool loading = false,
    Widget? loadingWidget
  }) {
    Widget spacer = SizedBox(width: spacing);
    Widget _icon(FluIconModel? icon, [bool pref = false]) => icon != null ? FluIcon(
      icon: icon,
      size: iconSize,
      strokeWidth: iconStrokeWidth,
      color: color
    ) : Container();

    return FluButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      height: height,
      width: width,
      boxShadow: boxShadow,
      backgroundColor: backgroundColor,
      radius: radius,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      margin: margin,
      padding: padding,
      border: border,
      borderRadius: borderRadius,
      loading: loading,
      loadingWidget: loadingWidget,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _icon(prefixIcon, prefixIcon != null),
          if(prefixIcon != null) spacer,
          Text(text, style: Flukit.textTheme.bodyText1?.copyWith(
            color: color
          ).merge(textStyle)),
          if(suffixIcon != null) spacer,
          _icon(suffixIcon, suffixIcon != null),
        ],
      )
    );
  }

  @override
  State<FluButton> createState() => _FluButtonState();
}

class _FluButtonState extends State<FluButton> {
  @override
  Widget build(BuildContext context) => AnimatedContainer(
    height: widget.height,
    width: widget.width,
    margin: widget.margin,
    duration: widget.animationDuration ?? const Duration(milliseconds: 300),
    curve: widget.animationCurve ?? Curves.linear,
    // alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
      border: widget.border,
      borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.radius ?? FluConsts.defaultElSize),
      boxShadow: [if(widget.boxShadow != null) widget.boxShadow!]
    ),
    child: TextButton(
      onPressed: widget.onPressed != null ? () => {
        if(!widget.loading) {
          Flukit.selectionClickHaptic(),
          widget.onPressed!()
        }
      } : null,
      onLongPress: widget.onLongPress,
      style: TextButton.styleFrom(
        fixedSize: const Size(double.infinity, double.infinity),
        primary: widget.color,
        backgroundColor: widget.backgroundColor ?? Flukit.theme.data.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.radius ?? FluConsts.defaultElRadius)),
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 15)
      ),
      child: !widget.loading ? widget.child : Center(
        child: widget.loadingWidget ?? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(widget.color ?? Flukit.themePalette.dark),
          strokeWidth: 2
        )),
      )
    )
  );
}