import 'package:flukit/widgets/flu_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flukit_icons/flukit_icons.dart';

import '../utils/flu_utils.dart';

/// Create a button
class FluButton extends StatelessWidget {
  const FluButton({
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.elevation = 0.0,
    this.filled = false,
    this.flat = false,
    this.loading = false,
    this.borderRadius,
    this.cornerRadius,
    this.replaceContentOnLoading = true,
    this.loadingText,
    this.loader,
    this.loaderOverlayColor,
    this.loaderColor,
    this.height,
    this.width,
    this.block = false,
    this.expand = false,
    this.boxShadow,
    super.key,
  });

  /// Create a button with icon content
  factory FluButton.icon(FluIcons icon,
          {double iconSize = 20,
          double iconStrokeWidth = 1.5,
          FluIconStyles iconStyle = FluIconStyles.twotone,
          VoidCallback? onPressed,
          Color? backgroundColor,
          Color? foregroundColor,
          EdgeInsets padding = EdgeInsets.zero,
          EdgeInsets margin = EdgeInsets.zero,
          double elevation = 0.0,
          bool filled = false,
          bool flat = false,
          bool loading = false,
          bool replaceContentOnLoading = true,
          String? loadingText,
          BorderRadius? borderRadius,
          double? cornerRadius,
          Widget? loader,
          Color? loaderOverlayColor,
          Color? loaderColor,
          double? size,
          List<BoxShadow>? boxShadow}) =>
      FluButton(
        onPressed: onPressed,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: padding,
        margin: margin,
        elevation: elevation,
        filled: filled,
        flat: flat,
        loading: loading,
        borderRadius: borderRadius,
        cornerRadius: cornerRadius,
        replaceContentOnLoading: replaceContentOnLoading,
        loadingText: loadingText,
        loader: loader,
        loaderOverlayColor: loaderOverlayColor,
        loaderColor: loaderColor,
        height: size,
        width: size,
        boxShadow: boxShadow,
        child: FluIcon(
          icon,
          size: iconSize,
          style: iconStyle,
          strokewidth: iconStrokeWidth,
          color: _getButtonForegroundColor(Flu.colorScheme,
              flat: flat, filled: filled, disabled: onPressed == null),
        ),
      );

  /// Create a button with text content
  /// You can also add an icon before or after the text using [prefixIcon] and [suffixIcon].
  /// Control icons sizes with [iconSize], [prefixIconSize] and [suffixIconSize].
  /// use [iconStyle] to choose your icon style. refer to [https://github.com/charles9904/flukit_icons] to learn more.
  /// [spacing] determine the space available between text and icon.
  factory FluButton.text(String text,
      {FluIcons? prefixIcon,
      FluIcons? suffixIcon,
      double iconSize = 20,
      double? prefixIconSize,
      double? suffixIconSize,
      FluIconStyles iconStyle = FluIconStyles.twotone,
      double gap = 6.0,
      VoidCallback? onPressed,
      Color? backgroundColor,
      Color? foregroundColor,
      EdgeInsets padding = EdgeInsets.zero,
      EdgeInsets margin = EdgeInsets.zero,
      double elevation = 0.0,
      bool filled = false,
      bool flat = false,
      bool loading = false,
      bool replaceContentOnLoading = true,
      String? loadingText,
      BorderRadius? borderRadius,
      double? cornerRadius,
      Widget? loader,
      Color? loaderOverlayColor,
      Color? loaderColor,
      double? height,
      double? width,
      bool block = false,
      bool expand = false,
      List<BoxShadow>? boxShadow,
      TextStyle? textStyle}) {
    Color foregroundColor = _getButtonForegroundColor(Flu.colorScheme,
        flat: flat, filled: filled, disabled: onPressed == null);
    Widget buildIcon(FluIcons icon, [double? size]) => FluIcon(
          icon,
          style: iconStyle,
          size: size ?? iconSize,
          color: foregroundColor,
          margin: EdgeInsets.only(
            right: prefixIcon != null ? gap : 0,
            left: suffixIcon != null ? gap : 0,
          ),
        );

    Widget textWidget = Text(text,
        style: Flu.textTheme.bodyMedium
            ?.copyWith(color: foregroundColor, fontWeight: FontWeight.w600)
            .merge(textStyle));

    return FluButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: padding,
      margin: margin,
      elevation: elevation,
      filled: filled,
      flat: flat,
      loading: loading,
      borderRadius: borderRadius,
      cornerRadius: cornerRadius,
      replaceContentOnLoading: replaceContentOnLoading,
      loadingText: loadingText,
      loader: loader,
      loaderOverlayColor: loaderOverlayColor,
      loaderColor: loaderColor,
      height: height,
      width: width,
      block: block,
      expand: expand,
      boxShadow: boxShadow,
      child: (prefixIcon != null || suffixIcon != null)
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (prefixIcon != null) buildIcon(prefixIcon, prefixIconSize),
                textWidget,
                if (suffixIcon != null) buildIcon(suffixIcon, suffixIconSize),
              ],
            )
          : textWidget,
    );
  }

  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Widget child;
  final double? cornerRadius;
  final double elevation;
  final bool filled;
  final bool flat;
  final Color? foregroundColor;
  final Widget? loader;
  final Color? loaderOverlayColor;
  final Color? loaderColor;
  final bool loading;
  final String? loadingText;
  final EdgeInsets margin;
  final VoidCallback? onPressed;
  final EdgeInsets padding;
  final bool replaceContentOnLoading;
  final double? height;
  final double? width;
  final bool block;
  final bool expand;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    final VoidCallback? onPressed = this.onPressed != null
        ? () {
            Flu.lightImpactHaptic();
            this.onPressed?.call();
          }
        : this.onPressed;
    final colorScheme = Flu.getColorSchemeOf(context);
    final bool hasCustomSize =
        expand || block || height != null || width != null;

    final ButtonStyle buttonStyle = ButtonStyle(
      fixedSize: MaterialStatePropertyAll(
          hasCustomSize ? const Size(double.infinity, double.infinity) : null),
      backgroundColor: MaterialStatePropertyAll(backgroundColor),
      foregroundColor: MaterialStatePropertyAll(foregroundColor),
      padding: MaterialStatePropertyAll(padding),
      elevation: MaterialStatePropertyAll(boxShadow == null ? elevation : null),
      shape: borderRadius != null || cornerRadius != null
          ? MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius:
                    borderRadius ?? BorderRadius.circular(cornerRadius!),
              ),
            )
          : null,
    );
    final Color defaultForegroundColor = _getButtonForegroundColor(colorScheme,
        disabled: onPressed == null, flat: flat, filled: filled);
    final Color defaultOverlayColor = _getButtonOverlayColor(colorScheme,
        disabled: onPressed == null, flat: flat, filled: filled);

    Widget loader = this.loader ??
        FluLoader(
          size: loadingText != null ? 14 : 18,
          strokeWidth: loadingText != null ? 1.5 : 2,
          color: loaderColor ?? foregroundColor ?? defaultForegroundColor,
          label: replaceContentOnLoading ? loadingText : null,
          labelStyle: TextStyle(color: foregroundColor),
        );
    Widget child;
    Widget button;

    if (loading && replaceContentOnLoading) {
      child = loader;
    } else {
      child = this.child;
    }

    if (loading && !replaceContentOnLoading) {
      child = Opacity(opacity: .45, child: child);
    }

    if (elevation > 0 && !flat && !filled) {
      button = ElevatedButton(
          onPressed: onPressed, style: buttonStyle, child: child);
    } else if (flat) {
      button =
          TextButton(onPressed: onPressed, style: buttonStyle, child: child);
    } else if (filled) {
      button = FilledButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: child,
      );
    } else {
      button = FilledButton.tonal(
        onPressed: onPressed,
        style: buttonStyle,
        child: child,
      );
    }

    if (loading && !replaceContentOnLoading) {
      button = Stack(alignment: AlignmentDirectional.center, children: [
        button,
        Positioned.fill(
          // Todo: Fix sizing issue
          child: FluGlass(
            borderRadius: borderRadius,
            cornerRadius: cornerRadius ?? 99,
            intensity: 1,
            child: Container(
              color: loaderOverlayColor ??
                  defaultOverlayColor.withOpacity(filled ? .15 : .55),
              child: loader,
            ),
          ),
        ),
      ]);
    }

    if (margin != EdgeInsets.zero || hasCustomSize || boxShadow != null) {
      BoxDecoration? decoration;

      if (boxShadow != null) {
        decoration = BoxDecoration(
          boxShadow: boxShadow,
          borderRadius:
              borderRadius ?? BorderRadius.circular(cornerRadius ?? 999),
        );
      }

      return Container(
        height: expand ? double.infinity : height,
        width: expand || block ? double.infinity : width,
        margin: margin,
        decoration: decoration,
        clipBehavior: decoration != null ? Clip.antiAlias : Clip.none,
        child: button,
      );
    }

    return button;
  }
}

/// Return background color according to M3 button specs
/// https://m3.material.io/components/buttons/specs
Color _getButtonOverlayColor(ColorScheme colorScheme,
    {required bool flat,
    required bool filled,
    required bool disabled,
    double elevation = 0.0}) {
  if (disabled) {
    return colorScheme.surface;
  } else if (elevation > 0 && !flat && !filled) {
    return colorScheme.background;
  } else if (flat) {
    return colorScheme.background;
  } else if (filled) {
    return colorScheme.primary;
  } else {
    return colorScheme.secondaryContainer;
  }
}

/// Return foreground color according to M3 button specs
/// https://m3.material.io/components/buttons/specs
Color _getButtonForegroundColor(ColorScheme colorScheme,
    {required bool flat,
    required bool filled,
    required bool disabled,
    double elevation = 0.0}) {
  if (disabled) {
    return colorScheme.onSurface;
  } else if (elevation > 0 && !flat && !filled) {
    return colorScheme.onBackground;
  } else if (flat) {
    return colorScheme.primary;
  } else if (filled) {
    return colorScheme.onPrimary;
  } else {
    return colorScheme.onSecondaryContainer;
  }
}
