part of 'index.dart';

/// The visual properties that most `FluButton` have in common.
///
/// Buttons and their themes have a `FluButtonStyle` property which defines the visual
/// properties whose default values are to be overridden. The default values are
/// defined by the individual button widgets and are typically based on overall
/// theme's [ThemeData.colorScheme] and [ThemeData.textTheme].
///
/// TODO: Add State based properties using [MaterialStateProperty]

@immutable
class FluButtonStyle {
  const FluButtonStyle({
    this.height,
    this.width,
    this.minWidth,
    this.maxWidth,
    this.cornerRadius,
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
    this.block = false,
    this.square = false,
    this.iconSize = 22,
    this.iconStrokewidth = 1.5,
  });

  /// Defining styles
  static FluButtonStyle flat = FluButtonStyle(
    background: Colors.transparent,
    color: Flu.theme().accentText,
  );

  static FluButtonStyle primary = FluButtonStyle(
    height: Flu.appSettings.defaultElSize,
    cornerRadius: Flu.appSettings.defaultElRadius,
    background: Flu.theme().primary,
    color: Flu.theme().light,
    padding: const EdgeInsets.symmetric(horizontal: 20),
  );

  /// The alignment of the button's child.
  /// Typically buttons are sized to be just big enough to contain the child and its padding.
  /// If the button's size is constrained to a fixed size, for example by enclosing it with a [SizedBox],
  /// this property defines how the child is aligned within the available space.
  /// Always defaults to [Alignment.center].
  final Alignment? alignment;

  /// Button animation curve.
  final Curve? animationCurve;

  /// Button animation duration.
  final Duration? animationDuration;

  /// The button's background fill color.
  final Color? background;

  /// Change the width of the button to the possible total determined by the parent element
  final bool block;

  /// If non-null, it define a border to draw above the background [color].
  final Border? border;

  /// If non-null, the corners of this button are rounded by this [BorderRadius].
  final BorderRadius? borderRadius;

  /// If non-null, it define a shadow cast by this button behind the button.
  final BoxShadow? boxShadow;

  /// Change the color of the button and some of its sub components like icons or texts for [FluButton.text] for example
  final Color? color;

  /// Round all button corner with the value defined.
  /// Useful when you just want to round all corners.
  final double? cornerRadius;

  /// Button height
  /// If [square] set to true, it will be the same as the [width] property.
  final double? height;

  /// With some buttons, you can change the icon size.
  /// for example with [FluButton.text], [FluButton.icon]
  final double iconSize;

  /// With some buttons, you can change the icon strokewidth.
  /// for example with [FluButton.text], [FluButton.icon].
  /// check [FluIcon] to knwow more about the strokewidth property.
  final double iconStrokewidth;

  /// With some buttons, you can change the icon style.
  /// for example with [FluButton.text], [FluButton.icon].
  /// check [FluIcon] to knwow more about the style property.
  final FluIconStyles iconStyle;

  /// Change the state of the button to loading.
  /// the content change and display an loading indicator.
  final bool loading;

  /// Define your custom loading indicator.
  final Widget? loadingWidget;

  /// Empty space to surround the button.
  final EdgeInsets? margin;

  /// The maximum width that satisfies the button constraints.
  final double? maxWidth;

  /// The minimum width that satisfies the button constraints.
  final double? minWidth;

  /// The padding between the button's boundary and its child.
  final EdgeInsets? padding;

  /// If true, the button width or height are linked in order to have a square.
  final bool square;

  /// Button width
  /// If [square] set to true, it will be the same as the [height] property.
  final double? width;

  FluButtonStyle copyWith({
    double? height,
    double? width,
    double? minWidth,
    double? maxWidth,
    double? cornerRadius,
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
    bool? block,
    bool? square,
  }) =>
      FluButtonStyle(
        height: height ?? this.height,
        width: width ?? this.width,
        minWidth: minWidth ?? this.minWidth,
        maxWidth: maxWidth ?? this.maxWidth,
        cornerRadius: cornerRadius ?? this.cornerRadius,
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
        block: block ?? this.block,
        square: square ?? this.square,
        iconSize: iconSize ?? this.iconSize,
        iconStrokewidth: iconStrokewidth ?? this.iconStrokewidth,
      );

  FluButtonStyle merge(FluButtonStyle? newStyle) => FluButtonStyle(
        height: newStyle?.height ?? height,
        width: newStyle?.width ?? width,
        minWidth: newStyle?.minWidth ?? minWidth,
        maxWidth: newStyle?.maxWidth ?? maxWidth,
        cornerRadius: newStyle?.cornerRadius ?? cornerRadius,
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
        block: newStyle?.block ?? block,
        square: newStyle?.square ?? square,
        iconSize: newStyle?.iconSize ?? iconSize,
        iconStrokewidth: newStyle?.iconStrokewidth ?? iconStrokewidth,
      );
}
