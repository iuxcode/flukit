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
      // alignment: Alignment.center,
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
    style = FluButtonStyle.flat.merge(FluButtonStyle(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
    ).merge(style));
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
  FluButtonStyle get style => FluButtonStyle.main.merge(widget.style);

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    height: style.height ?? Flukit.appConsts.defaultElSize,
    width: style.expand ? double.infinity : style.width,
    margin: style.margin,
    duration: style.animationDuration ?? const Duration(milliseconds: 300),
    curve: style.animationCurve ?? Curves.linear,
    // alignment: widget.style?.alignment ?? Alignment.center,
    constraints: BoxConstraints(
      minWidth: style.minWidth ?? 0.0,
      maxWidth: style.maxWidth ?? double.infinity,
    ),
    decoration: BoxDecoration(
      border: style.border,
      borderRadius: style.borderRadius ?? BorderRadius.circular(style.radius ?? Flukit.appConsts.defaultElRadius),
      boxShadow: [
        if(style.boxShadow != null) style.boxShadow!
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
        primary: style.color,
        backgroundColor: style.backgroundColor ?? Flukit.theme.data.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: style.borderRadius ?? BorderRadius.circular(style.radius ?? Flukit.appConsts.defaultElRadius
        )),
        padding: style.padding ?? const EdgeInsets.symmetric(horizontal: 15),
        alignment: widget.style?.alignment ?? Alignment.center
      ),
      child: !isLoading ? widget.child : Center(
        child: style.loadingWidget ?? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(style.color ?? Flukit.themePalette.dark),
          strokeWidth: 2
        )),
      )
    )
  );
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
  FluIconStyle? iconStyle;
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
    this.iconStyle,
    this.expand = false
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
    padding: const EdgeInsets.symmetric(
      horizontal: 20
    )
  );
}