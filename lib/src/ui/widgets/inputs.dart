import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A `Flukit` styled [TextField].
///
/// This is a convenience widget that wraps a [TextField] widget in a
/// [Container] for more styling options.
class FluTextField extends StatefulWidget {
  const FluTextField({
    required this.hint,
    super.key,
    this.inputController,
    this.focusNode,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.expand = false,
    this.textStyle,
    this.selectionControls,
    this.onTap,
    this.height,
    this.margin = EdgeInsets.zero,
    this.padding,
    this.fillColor,
    this.boxShadow,
    this.borderWidth,
    this.prefixIcon,
    this.suffixIcon,
    this.iconColor,
    this.iconSize = 20,
    this.iconStrokeWidth = 1.6,
    this.iconStyle = FluIconStyles.twotone,
    this.textAlign = TextAlign.start,
    this.textAlignVertical = TextAlignVertical.center,
    this.keyboardType,
    this.color,
    this.cursorColor,
    this.cursorHeight,
    this.cursorWidth = 2.0,
    this.hintStyle,
    this.borderColor,
    this.borderRadius,
    this.cornerRadius,
    this.hintColor,
    this.inputAction = TextInputAction.done,
    this.maxlines,
    this.obscureText = false,
    this.maxHeight,
    this.prefix,
    this.suffix,
    this.onFieldSubmitted,
    this.autofocus = false,
    this.maxLength,
    this.maxLengthEnforcement,
  });

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final double? borderWidth;
  final List<BoxShadow>? boxShadow;
  final Color? color;
  final double? cornerRadius;
  final Color? cursorColor;
  final double? cursorHeight;
  final double cursorWidth;
  final bool expand;
  final Color? fillColor;
  final FocusNode? focusNode;
  final double? height;
  final String hint;
  final Color? iconColor;
  final double iconSize;
  final double iconStrokeWidth;
  final FluIconStyles iconStyle;
  final TextInputAction inputAction;
  final TextEditingController? inputController;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Color? hintColor;
  final TextStyle? hintStyle;
  final EdgeInsets margin;
  final double? maxHeight;
  final int? maxlines;
  final bool obscureText;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final TextSelectionControls? selectionControls;
  final FluIcons? prefixIcon, suffixIcon;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final TextStyle? textStyle;
  final Widget? suffix;
  final Widget? prefix;
  final void Function(String)? onFieldSubmitted;
  final bool autofocus;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;

  @override
  State<FluTextField> createState() => _FluTextFieldState();
}

class _FluTextFieldState<T extends FluTextField> extends State<T> {
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    super.initState();
  }

  InputDecoration get _decoration => InputDecoration(
        border: InputBorder.none,
        hintText: widget.hint,
        hintStyle: _defaultTextStyle
            .copyWith(
              color: widget.hintColor ?? context.colorScheme.onSurfaceVariant,
            )
            .merge(widget.hintStyle),
        errorStyle: const TextStyle(height: 0, color: Colors.transparent),
        prefixIcon: widget.prefix ?? _icon(widget.prefixIcon),
        suffixIcon: widget.suffix ?? _icon(widget.suffixIcon),
        contentPadding: widget.padding ??
            (height == null
                    ? const EdgeInsets.symmetric(vertical: 20)
                    : EdgeInsets.zero)
                .copyWith(left: 15, right: 15),
      );

  TextStyle get _defaultTextStyle => context.textTheme.bodyMedium!
      .copyWith(color: widget.color ?? context.colorScheme.onSurfaceVariant)
      .merge(widget.textStyle);

  Color get _fillColor =>
      widget.fillColor ?? context.colorScheme.surfaceVariant;

  double? get height {
    if (widget.expand && widget.maxHeight == null) {
      return double.infinity;
    } else if (widget.maxHeight != null) {
      return null;
    }

    return widget.height ?? 55; // Flu.appSettings.defaultElSize;
  }

  Widget? _icon(FluIcons? icon) {
    if (icon != null) {
      return FluIcon(
        icon,
        color: widget.iconColor ?? context.colorScheme.onSurface,
        size: widget.iconSize,
        strokeWidth: widget.iconStrokeWidth,
        style: widget.iconStyle,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Widget field = Container(
      height: height,
      margin: widget.margin,
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _fillColor,
        boxShadow: widget.boxShadow,
        border: widget.borderWidth != null
            ? Border.all(
                color: widget.borderColor ??
                    context.colorScheme.background.withOpacity(.05),
                width: widget.borderWidth!,
              )
            : null,
        borderRadius: widget.borderRadius ??
            BorderRadius.circular(
              widget.cornerRadius ?? 99,
            ),
      ),
      child: TextFormField(
        maxLength: widget.maxLength,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        autofocus: widget.autofocus,
        controller: widget.inputController,
        focusNode: _focusNode,
        expands: height != null,
        maxLines: widget.maxlines,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        textInputAction: widget.inputAction,
        selectionControls: widget.selectionControls,
        style: _defaultTextStyle,
        cursorColor: widget.cursorColor ?? context.colorScheme.primary,
        cursorHeight: widget.cursorHeight,
        cursorWidth: widget.cursorWidth,
        decoration: _decoration,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        onFieldSubmitted: widget.onFieldSubmitted,
        obscureText: widget.obscureText,
        onTapOutside: (_) => _focusNode.unfocus(),
      ),
    );

    if (widget.maxHeight != null) {
      return Container(
        color: _fillColor,
        constraints: BoxConstraints(maxHeight: widget.maxHeight!),
        child: Scrollbar(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: field,
          ),
        ),
      );
    }

    return field;
  }
}
