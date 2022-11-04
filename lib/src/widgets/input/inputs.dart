import 'dart:math' as math;

import 'package:flukit/src/configs/theme/index.dart';
import 'package:flukit/src/utils/flu_utils.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'base_text_field.dart';
import 'controller.dart';

export 'controller.dart';
export 'replacements.dart';
export 'selection_toolbar.dart';

/// A [Flukit] styled [TextField].
///
/// This is a convenience widget that wraps a [TextField] widget in a
/// [Container] for more styling options.
class FluTextField extends StatefulWidget {
  const FluTextField({
    super.key,
    this.inputController,
    this.focusNode,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.expand = false,
    this.textStyle,
    this.toolbarOptions,
    this.selectionControls,
    this.onTap,
    this.height,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
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
    required this.label,
    this.labelStyle,
    this.borderColor,
    this.borderRadius,
    this.cornerRadius,
    this.labelColor,
    this.inputAction = TextInputAction.done,
    this.maxlines,
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
  final Color? iconColor;
  final double iconSize;
  final double iconStrokeWidth;
  final FluIconStyles iconStyle;
  final TextInputAction inputAction;
  final TextEditingController? inputController;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String label;
  final Color? labelColor;
  final TextStyle? labelStyle;
  final EdgeInsets margin;
  final int? maxlines;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final TextSelectionControls? selectionControls;
  final FluIcons? prefixIcon, suffixIcon;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final TextStyle? textStyle;
  final ToolbarOptions? toolbarOptions;

  @override
  State<FluTextField> createState() => _FluTextFieldState();
}

class _FluTextFieldState<T extends FluTextField> extends State<T> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = widget.focusNode ?? FocusNode();
  }

  InputDecoration get _decoration => InputDecoration(
        filled: false,
        border: InputBorder.none,
        hintText: widget.label,
        hintStyle: _theme.textTheme.bodyText1!
            .copyWith(
              fontWeight: FontWeight.w400,
              color: widget.labelColor ?? _theme.text,
            )
            .merge(widget.labelStyle),
        errorStyle: const TextStyle(height: 0, color: Colors.transparent),
        prefixIcon: _icon(widget.prefixIcon),
        suffixIcon: _icon(widget.suffixIcon),
        contentPadding: widget.padding,
      );

  TextStyle get _defaultTextStyle => _theme.textTheme.bodyText1!
      .copyWith(color: widget.color ?? _theme.text)
      .merge(widget.textStyle);

  Color get _fillColor => widget.fillColor ?? _theme.surfaceBackground;
  FluTheme get _theme => Flu.theme();

  Widget _icon(FluIcons? icon) {
    if (icon != null) {
      FluIcon(
        icon,
        color: widget.iconColor ?? _theme.accentText,
        size: widget.iconSize,
        strokewidth: widget.iconStrokeWidth,
        style: widget.iconStyle,
      );
    }

    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.expand
          ? double.infinity
          : (widget.height ?? Flu.appSettings.defaultElSize),
      margin: widget.margin,
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _fillColor,
        boxShadow: widget.boxShadow,
        border: widget.borderWidth != null
            ? Border.all(
                color: widget.borderColor ?? _theme.background.withOpacity(.05),
                width: widget.borderWidth!,
              )
            : null,
        borderRadius: widget.borderRadius ??
            BorderRadius.circular(
              widget.cornerRadius ?? Flu.appSettings.defaultElRadius,
            ),
      ),
      child: TextFormField(
        controller: widget.inputController,
        focusNode: _focusNode,
        expands: true,
        maxLines: widget.maxlines,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        textInputAction: widget.inputAction,
        toolbarOptions: widget.toolbarOptions,
        selectionControls: widget.selectionControls,
        style: _defaultTextStyle,
        cursorColor: widget.cursorColor ?? _theme.primary,
        cursorHeight: widget.cursorHeight,
        cursorWidth: widget.cursorWidth,
        decoration: _decoration,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
      ),
    );
  }
}

/// A [Flukit] rich [TextField].
/// Offer more options.
class FluRichTextField extends FluTextField {
  const FluRichTextField({
    super.key,
    super.inputController,
    super.focusNode,
    super.inputFormatters,
    super.validator,
    super.onChanged,
    super.expand = false,
    super.textStyle,
    super.toolbarOptions,
    super.selectionControls,
    super.onTap,
    super.height,
    super.margin,
    super.padding,
    super.fillColor,
    super.boxShadow,
    super.borderWidth,
    super.prefixIcon,
    super.suffixIcon,
    super.iconColor,
    super.iconSize,
    super.iconStrokeWidth,
    super.iconStyle,
    super.textAlign,
    super.textAlignVertical,
    super.keyboardType,
    super.color,
    super.cursorColor,
    super.cursorHeight,
    super.cursorWidth,
    required super.label,
    super.labelStyle,
    super.borderColor,
    super.borderRadius,
    super.cornerRadius,
    super.labelColor,
    this.controller,
    this.onDeltasHistoryUpdate,
    this.autoInsertController = false,
    super.inputAction = TextInputAction.newline,
    super.maxlines,
  });

  final bool autoInsertController;
  final FluRichTextFieldController? controller;
  final TextEditingDeltaHistoryUpdateCallback? onDeltasHistoryUpdate;

  @override
  State<FluTextField> createState() => _FluRichTextFieldState();
}

class _FluRichTextFieldState extends _FluTextFieldState<FluRichTextField> {
  late FluRichTextFieldController controller;

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      controller = widget.controller!;

      if (widget.autoInsertController) insertController();
    } else {
      controller = FluRichTextFieldController();
      insertController();
    }
  }

  void insertController() {
    controller = Get.put(controller,
        tag: 'FluRichTextField_${math.Random().nextInt(999999)}');
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (context) => FluBaseTextField(
        controller: controller.inputController,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        onDeltasHistoryUpdate: (textEditingDeltas) {
          widget.onDeltasHistoryUpdate?.call(textEditingDeltas);
        },
        onDeltaStyleStateChange: controller.updateStyleButtonsState,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        keyboardType: widget.keyboardType,
        textInputAction: widget.inputAction,
        inputFormatters: widget.inputFormatters,
        style: _defaultTextStyle,
        cursorColor: widget.cursorColor ?? _theme.primary,
        cursorHeight: widget.cursorHeight,
        cursorWidth: widget.cursorWidth,
        decoration: _decoration,
        maxLines: widget.maxlines,
        toolbarOptions: widget.toolbarOptions,
        selectionControls: widget.selectionControls,
        onTap: widget.onTap,
      ),
    );
  }
}
