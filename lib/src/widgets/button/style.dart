part of 'index.dart';

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
  Color? background;
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
    this.background,
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

  FluButtonStyle copyWith({
    double? height,
    double? width,
    double? minWidth,
    double? maxWidth,
    double? radius,
    EdgeInsets? margin,
    EdgeInsets? padding,
    Border? border,
    BorderRadius? borderRadius,
    Duration? animationDuration,
    Curve? animationCurve,
    BoxShadow? boxShadow,
    Color? color,
    Color? background,
    bool? loading,
    Widget? loadingWidget,
    Alignment? alignment,
    FluIconStyles? iconStyle,
    double? iconSize,
    double? iconStrokewidth,
    bool? expand,
  }) =>
      FluButtonStyle(
        height: height ?? this.height,
        width: width ?? this.width,
        minWidth: minWidth ?? this.minWidth,
        maxWidth: maxWidth ?? this.maxWidth,
        radius: radius ?? this.radius,
        margin: margin ?? this.margin,
        padding: padding ?? this.padding,
        boxShadow: boxShadow ?? this.boxShadow,
        background: background ?? this.background,
        border: border ?? this.border,
        borderRadius: borderRadius ?? this.borderRadius,
        color: color ?? this.color,
        animationDuration: animationDuration ?? this.animationDuration,
        animationCurve: animationCurve ?? this.animationCurve,
        loading: loading ?? this.loading,
        loadingWidget: loadingWidget ?? this.loadingWidget,
        alignment: alignment ?? this.alignment,
        iconStyle: iconStyle ?? this.iconStyle,
        expand: expand ?? this.expand,
        iconSize: iconSize ?? this.iconSize,
        iconStrokewidth: iconStrokewidth ?? this.iconStrokewidth,
      );

  FluButtonStyle merge(FluButtonStyle? newStyle) => FluButtonStyle(
        height: newStyle?.height ?? height,
        width: newStyle?.width ?? width,
        minWidth: newStyle?.minWidth ?? minWidth,
        maxWidth: newStyle?.maxWidth ?? maxWidth,
        radius: newStyle?.radius ?? radius,
        margin: newStyle?.margin ?? margin,
        padding: newStyle?.padding ?? padding,
        boxShadow: newStyle?.boxShadow ?? boxShadow,
        background: newStyle?.background ?? background,
        border: newStyle?.border ?? border,
        borderRadius: newStyle?.borderRadius ?? borderRadius,
        color: newStyle?.color ?? color,
        animationDuration: newStyle?.animationDuration ?? animationDuration,
        animationCurve: newStyle?.animationCurve ?? animationCurve,
        loading: newStyle?.loading ?? loading,
        loadingWidget: newStyle?.loadingWidget ?? loadingWidget,
        alignment: newStyle?.alignment ?? alignment,
        iconStyle: newStyle?.iconStyle ?? iconStyle,
        expand: newStyle?.expand ?? expand,
        iconSize: newStyle?.iconSize ?? iconSize,
        iconStrokewidth: newStyle?.iconStrokewidth ?? iconStrokewidth,
      );

  /// Defining styles
  static FluButtonStyle flat = FluButtonStyle(
    background: Colors.transparent,
    color: Flukit.theme().accentText,
  );

  static FluButtonStyle defaultt = FluButtonStyle(
    height: Flukit.appSettings.defaultElSize,
    radius: Flukit.appSettings.defaultElRadius,
    background: Flukit.theme().primary,
    color: Flukit.theme().light,
    padding: const EdgeInsets.symmetric(horizontal: 20),
  );
}
