import 'package:flutter/material.dart';
import 'package:flukit_icons/flukit_icons.dart';

import '../utils/flu_utils.dart';
import 'glass.dart';
import 'loader.dart';

/// Create a button
class FluButton extends StatelessWidget {
  const FluButton({
    required this.child,
    this.onPressed,
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
    this.alignment,
    this.splashColor,
    this.border,
    this.splashFactory,
    super.key,
  });

  /// Create a button with icon content
  const factory FluButton.icon(
    FluIcons icon, {
    double iconSize,
    double iconStrokeWidth,
    FluIconStyles iconStyle,
    VoidCallback? onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsets padding,
    EdgeInsets margin,
    double elevation,
    bool filled,
    bool flat,
    bool loading,
    bool replaceContentOnLoading,
    String? loadingText,
    BorderRadius? borderRadius,
    double? cornerRadius,
    Widget? loader,
    Color? loaderOverlayColor,
    Color? loaderColor,
    double? size,
    List<BoxShadow>? boxShadow,
    Alignment? alignment,
    Color? splashColor,
    BorderSide? border,
    InteractiveInkFeatureFactory? splashFactory,
  }) = _FluIconButton;

  /// Create a button with text content
  /// You can also add an icon before or after the text using [prefixIcon] and [suffixIcon].
  /// Control icons sizes with [iconSize], [prefixIconSize] and [suffixIconSize].
  /// use [iconStyle] to choose your icon style. refer to [https://github.com/charles9904/flukit_icons] to learn more.
  /// [spacing] determine the space available between text and icon.
  const factory FluButton.text(
    String text, {
    FluIcons? prefixIcon,
    FluIcons? suffixIcon,
    double iconSize,
    double iconStrokeWidth,
    double? prefixIconSize,
    double? suffixIconSize,
    FluIconStyles iconStyle,
    double gap,
    VoidCallback? onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsets padding,
    EdgeInsets margin,
    double elevation,
    bool filled,
    bool flat,
    bool loading,
    bool replaceContentOnLoading,
    String? loadingText,
    BorderRadius? borderRadius,
    double? cornerRadius,
    Widget? loader,
    Color? loaderOverlayColor,
    Color? loaderColor,
    double? height,
    double? width,
    bool block,
    bool expand,
    List<BoxShadow>? boxShadow,
    TextStyle? textStyle,
    Alignment? alignment,
    Color? splashColor,
    BorderSide? border,
    InteractiveInkFeatureFactory? splashFactory,
  }) = _FluTextButton;

  final AlignmentGeometry? alignment;
  final Color? backgroundColor;
  final bool block;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Widget child;
  final double? cornerRadius;
  final double elevation;
  final bool expand;
  final bool filled;
  final bool flat;
  final Color? foregroundColor;
  final double? height;
  final Widget? loader;
  final Color? loaderColor;
  final Color? loaderOverlayColor;
  final bool loading;
  final String? loadingText;
  final EdgeInsets margin;
  final VoidCallback? onPressed;
  final EdgeInsets padding;
  final bool replaceContentOnLoading;
  final double? width;
  final Color? splashColor;
  final BorderSide? border;
  final InteractiveInkFeatureFactory? splashFactory;

  Widget _getChild(BuildContext context) {
    return child;
  }

  @override
  Widget build(BuildContext context) {
    final VoidCallback? onPressed = this.onPressed != null
        ? () {
            Flu.lightImpactHaptic();
            this.onPressed?.call();
          }
        : this.onPressed;
    final bool hasCustomSize =
        expand || block || height != null || width != null;

    final ButtonStyle buttonStyle = ButtonStyle(
      fixedSize: MaterialStatePropertyAll(
          hasCustomSize ? const Size(double.infinity, double.infinity) : null),
      backgroundColor: MaterialStatePropertyAll(backgroundColor),
      foregroundColor: MaterialStatePropertyAll(foregroundColor),
      overlayColor: MaterialStatePropertyAll(splashColor),
      padding: MaterialStatePropertyAll(padding),
      elevation: MaterialStatePropertyAll(boxShadow == null ? elevation : null),
      shape: borderRadius != null || cornerRadius != null || border != null
          ? MaterialStatePropertyAll(
              RoundedRectangleBorder(
                side: border ?? BorderSide.none,
                borderRadius:
                    borderRadius ?? BorderRadius.circular(cornerRadius ?? 99),
              ),
            )
          : null,
      alignment: alignment,
      splashFactory: splashFactory,
    );
    final Color defaultForegroundColor = _getButtonForegroundColor(
        context.colorScheme,
        disabled: onPressed == null,
        flat: flat,
        filled: filled);
    final Color defaultOverlayColor = _getButtonOverlayColor(
        context.colorScheme,
        disabled: onPressed == null,
        flat: flat,
        filled: filled);

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
      child = _getChild(context);
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

class _FluIconButton extends FluButton {
  const _FluIconButton(
    this.icon, {
    this.iconSize = 20,
    this.iconStrokeWidth = 1.5,
    this.iconStyle = FluIconStyles.twotone,
    super.onPressed,
    super.backgroundColor,
    super.foregroundColor,
    super.padding = EdgeInsets.zero,
    super.margin = EdgeInsets.zero,
    super.elevation = 0.0,
    super.filled = false,
    super.flat = false,
    super.loading = false,
    super.replaceContentOnLoading = true,
    super.loadingText,
    super.borderRadius,
    super.cornerRadius,
    super.loader,
    super.loaderOverlayColor,
    super.loaderColor,
    this.size,
    super.boxShadow,
    super.alignment,
    super.splashColor,
    super.border,
    super.splashFactory,
  }) : super(child: const SizedBox(), height: size, width: size);

  final FluIcons icon;
  final double iconSize;
  final double iconStrokeWidth;
  final FluIconStyles iconStyle;
  final double? size;

  @override
  Widget _getChild(BuildContext context) {
    return FluIcon(
      icon,
      size: iconSize,
      style: iconStyle,
      strokeWidth: iconStrokeWidth,
      color: foregroundColor ??
          _getButtonForegroundColor(context.colorScheme,
              flat: flat, filled: filled, disabled: onPressed == null),
    );
  }
}

class _FluTextButton extends FluButton {
  const _FluTextButton(
    this.text, {
    super.onPressed,
    super.backgroundColor,
    super.foregroundColor,
    super.padding = EdgeInsets.zero,
    super.margin = EdgeInsets.zero,
    super.elevation = 0.0,
    super.filled = false,
    super.flat = false,
    super.loading = false,
    super.replaceContentOnLoading = true,
    super.loadingText,
    super.borderRadius,
    super.cornerRadius,
    super.loader,
    super.loaderOverlayColor,
    super.loaderColor,
    super.height,
    super.width,
    super.block = false,
    super.expand = false,
    super.boxShadow,
    super.alignment,
    super.splashColor,
    super.border,
    this.iconSize = 20,
    this.iconStyle = FluIconStyles.twotone,
    this.gap = 6.0,
    this.textStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconSize,
    this.suffixIconSize,
    this.iconStrokeWidth = 1.5,
    super.splashFactory,
  }) : super(child: const SizedBox());

  final double gap;
  final double iconSize;
  final double iconStrokeWidth;
  final FluIconStyles iconStyle;
  final FluIcons? prefixIcon;
  final double? prefixIconSize;
  final FluIcons? suffixIcon;
  final double? suffixIconSize;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget _getChild(BuildContext context) {
    Color foregroundColor = this.foregroundColor ??
        _getButtonForegroundColor(context.colorScheme,
            flat: flat, filled: filled, disabled: onPressed == null);

    Widget textWidget = Text(
      text,
      style: context.textTheme.bodyMedium
          ?.copyWith(color: foregroundColor, fontWeight: FontWeight.w600)
          .merge(textStyle),
    );

    if (prefixIcon != null || suffixIcon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (prefixIcon != null)
            _buildIcon(prefixIcon!, foregroundColor, prefixIconSize),
          textWidget,
          if (suffixIcon != null)
            _buildIcon(suffixIcon!, foregroundColor, suffixIconSize),
        ],
      );
    }

    return textWidget;
  }

  Widget _buildIcon(FluIcons icon, Color color, double? size) => FluIcon(
        icon,
        style: iconStyle,
        size: size ?? iconSize,
        strokeWidth: iconStrokeWidth,
        color: color,
        margin: EdgeInsets.only(
            right: prefixIcon != null ? gap : 0,
            left: suffixIcon != null ? gap : 0),
      );
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
