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

/// Basic input field
/// TODO Convert to StatefullWidget
class FluTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? inputController;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final FluTextFieldStyle style;
  final TextStyle? textStyle;
  final ToolbarOptions? toolbarOptions;
  final TextSelectionControls? selectionControls;
  final VoidCallback? onTap;

  const FluTextField(
      {super.key,
      this.inputController,
      this.focusNode,
      this.inputFormatters,
      this.validator,
      this.onChanged,
      this.style = const FluTextFieldStyle(),
      this.textStyle,
      this.toolbarOptions,
      this.selectionControls,
      this.onTap});

  FluTheme get _theme => Flukit.theme;
  ThemeData get _themeData => Flukit.theme.data;
  InputDecoration get inputDecoration => InputDecoration(
        filled: style.filled,
        fillColor: style.fillColor ?? _theme.palette.accentBackground,
        border: InputBorder.none,
        hintText: style.hintText,
        hintStyle: _theme.data.textTheme.bodyText1!
            .copyWith(
                fontWeight: FontWeight.w400,
                color: style.hintColor ?? _theme.palette.text)
            .merge(style.hintStyle),
        errorStyle: const TextStyle(height: 0, color: Colors.transparent),
        prefixIcon: style.prefixIcon,
        suffixIcon: style.suffixIcon,
        contentPadding: style.contentPadding,
      );
  TextStyle get defaultTextStyle => _themeData.textTheme.bodyText1!
      .copyWith(
        color: style.color ?? _theme.palette.text,
      )
      .merge(textStyle);

  void onIconTap(FocusNode focusNode) {
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode focus = focusNode ?? FocusNode();

    return Container(
        height: style.expand
            ? double.infinity
            : (style.height ?? Flukit.appConsts.defaultElSize),
        margin: style.margin,
        padding: style.padding,
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: style.fillColor ?? _theme.palette.accentBackground,
          boxShadow: style.boxShadow,
          border: style.borderWidth != null
              ? Border.all(
                  color: style.borderColor ??
                      _themeData.backgroundColor.withOpacity(.05),
                  width: style.borderWidth!)
              : null,
          borderRadius: BorderRadius.circular(
              style.radius ?? Flukit.appConsts.defaultElRadius),
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (style.fluPrefixIcon != null) icon(style.fluPrefixIcon, onIconTap),
            Expanded(
              child: TextFormField(
                controller: inputController,
                focusNode: focus,
                expands: true,
                maxLines: null,
                textAlign: style.textAlign ?? TextAlign.center,
                textAlignVertical: style.textAlignVertical,
                keyboardType: style.keyboardType,
                inputFormatters: inputFormatters,
                toolbarOptions: toolbarOptions,
                selectionControls: selectionControls,
                style: defaultTextStyle,
                cursorColor: style.cursorColor ?? _theme.primaryColor,
                cursorHeight: style.cursorHeight,
                cursorWidth: style.cursorWidth,
                decoration: inputDecoration,
                validator: validator,
                onChanged: onChanged,
                onTap: onTap,
              ),
            ),
            if (style.fluSuffixIcon != null) icon(style.fluSuffixIcon, onIconTap),
          ],
        ));
  }

  Widget icon(FluIcons? icon, void Function(FocusNode) onTap) => icon != null
      ? GestureDetector(
          onTap: () => onTap,
          child: FluIcon(
            icon,
            color: style.iconColor ?? _theme.palette.accentText,
            size: style.iconSize ?? 20,
            strokewidth: style.iconStrokeWidth ?? 1.5,
          ),
        )
      : Container();
}

class FluRichTextField extends FluTextField {
  FluRichTextFieldController controller;
  final TextEditingDeltaHistoryUpdateCallback? onDeltasHistoryUpdate;
  final bool autoInsertController;

  FluRichTextField({
    super.key,
    super.focusNode,
    super.inputFormatters,
    super.validator,
    super.onChanged,
    super.style,
    super.textStyle,
    super.toolbarOptions,
    super.selectionControls,
    super.onTap,
    required this.controller,
    this.onDeltasHistoryUpdate,
    this.autoInsertController = true,
  }) {
    if (autoInsertController) {
      controller = Get.put<FluRichTextFieldController>(controller,
          tag: 'FluRichTextField_${math.Random().nextInt(999999)}');
    }
  }

  @override
  Widget build(BuildContext context) => GetBuilder(
      init: controller,
      builder: (context) => FluBaseTextField(
            controller: controller.inputController,
            focusNode: focusNode,
            onChanged: onChanged,
            onDeltasHistoryUpdate: (textEditingDeltas) {
              onDeltasHistoryUpdate?.call(textEditingDeltas);
            },
            onDeltaStyleStateChange: controller.updateStyleButtonsState,
            textAlign: style.textAlign ?? TextAlign.center,
            textAlignVertical: style.textAlignVertical,
            keyboardType: style.keyboardType,
            textInputAction: style.textInputAction ?? TextInputAction.newline,
            inputFormatters: inputFormatters,
            style: defaultTextStyle,
            cursorColor: style.cursorColor ?? _theme.primaryColor,
            cursorHeight: style.cursorHeight,
            cursorWidth: style.cursorWidth,
            decoration: inputDecoration,
            maxLines: style.maxLines,
            toolbarOptions: toolbarOptions,
            selectionControls: selectionControls,
            onTap: onTap,
          ));
}

class FluTextFieldStyle extends InputDecoration {
  const FluTextFieldStyle({
    super.icon,
    super.iconColor,
    super.label,
    super.labelText,
    super.labelStyle,
    super.floatingLabelStyle,
    super.helperText,
    super.helperStyle,
    super.helperMaxLines,
    super.hintText,
    super.hintStyle,
    super.hintTextDirection,
    super.hintMaxLines,
    super.errorText,
    super.errorStyle,
    super.errorMaxLines,
    super.floatingLabelBehavior,
    super.floatingLabelAlignment,
    super.isCollapsed,
    super.isDense,
    super.contentPadding,
    super.prefixIcon,
    super.prefixIconConstraints,
    super.prefix,
    super.prefixText,
    super.prefixStyle,
    super.prefixIconColor,
    super.suffixIcon,
    super.suffix,
    super.suffixText,
    super.suffixStyle,
    super.suffixIconColor,
    super.suffixIconConstraints,
    super.counter,
    super.counterText,
    super.counterStyle,
    super.filled,
    super.fillColor,
    super.focusColor,
    super.hoverColor,
    super.errorBorder,
    super.focusedBorder,
    super.focusedErrorBorder,
    super.disabledBorder,
    super.enabledBorder,
    super.border,
    super.enabled,
    super.semanticCounterText,
    super.alignLabelWithHint,
    super.constraints,
    this.fluPrefixIcon,
    this.fluSuffixIcon,
    this.boxShadow,
    this.expand = false,
    this.borderColor,
    this.color,
    this.hintColor,
    this.cursorHeight,
    this.cursorWidth = 2.0,
    this.cursorColor,
    this.selectionColor,
    this.iconStrokeWidth = 1.5,
    this.iconSize = 20,
    this.borderWidth = .8,
    this.height,
    this.radius,
    this.margin,
    this.padding,
    this.textAlign,
    this.textAlignVertical,
    this.keyboardType,
    this.textInputAction,
    this.maxLines,
  });

  final FluIcons? fluPrefixIcon;
  final FluIcons? fluSuffixIcon;
  final List<BoxShadow>? boxShadow;
  final bool expand;
  final double? height, radius, borderWidth, iconSize, iconStrokeWidth, cursorHeight;
  final double cursorWidth;
  final Color? borderColor, color, hintColor, cursorColor, selectionColor;
  final EdgeInsets? margin, padding;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;

  @override
  InputDecoration copyWith({
    Widget? icon,
    Color? iconColor,
    Widget? label,
    String? labelText,
    TextStyle? labelStyle,
    TextStyle? floatingLabelStyle,
    String? helperText,
    TextStyle? helperStyle,
    int? helperMaxLines,
    String? hintText,
    TextStyle? hintStyle,
    TextDirection? hintTextDirection,
    int? hintMaxLines,
    String? errorText,
    TextStyle? errorStyle,
    int? errorMaxLines,
    FloatingLabelBehavior? floatingLabelBehavior,
    FloatingLabelAlignment? floatingLabelAlignment,
    bool? isCollapsed,
    bool? isDense,
    EdgeInsetsGeometry? contentPadding,
    Widget? prefixIcon,
    Widget? prefix,
    String? prefixText,
    BoxConstraints? prefixIconConstraints,
    TextStyle? prefixStyle,
    Color? prefixIconColor,
    Widget? suffixIcon,
    Widget? suffix,
    String? suffixText,
    TextStyle? suffixStyle,
    Color? suffixIconColor,
    BoxConstraints? suffixIconConstraints,
    Widget? counter,
    String? counterText,
    TextStyle? counterStyle,
    bool? filled,
    Color? fillColor,
    Color? focusColor,
    Color? hoverColor,
    InputBorder? errorBorder,
    InputBorder? focusedBorder,
    InputBorder? focusedErrorBorder,
    InputBorder? disabledBorder,
    InputBorder? enabledBorder,
    InputBorder? border,
    bool? enabled,
    String? semanticCounterText,
    bool? alignLabelWithHint,
    BoxConstraints? constraints,
    FluIcons? fluPrefixIcon,
    FluIcons? fluSuffixIcon,
    List<BoxShadow>? boxShadow,
    bool? expand,
    double? height,
    radius,
    borderWidth,
    iconSize,
    iconStrokeWidth,
    cursorHeight,
    cursorWidth,
    Color? borderColor,
    color,
    hintColor,
    cursorColor,
    selectionColor,
    EdgeInsets? margin,
    padding,
    TextAlign? textAlign,
    TextAlignVertical? textAlignVertical,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    int? maxLines,
  }) {
    return FluTextFieldStyle(
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
      label: label ?? this.label,
      labelText: labelText ?? this.labelText,
      labelStyle: labelStyle ?? this.labelStyle,
      floatingLabelStyle: floatingLabelStyle ?? this.floatingLabelStyle,
      helperText: helperText ?? this.helperText,
      helperStyle: helperStyle ?? this.helperStyle,
      helperMaxLines: helperMaxLines ?? this.helperMaxLines,
      hintText: hintText ?? this.hintText,
      hintStyle: hintStyle ?? this.hintStyle,
      hintTextDirection: hintTextDirection ?? this.hintTextDirection,
      hintMaxLines: hintMaxLines ?? this.hintMaxLines,
      errorText: errorText ?? this.errorText,
      errorStyle: errorStyle ?? this.errorStyle,
      errorMaxLines: errorMaxLines ?? this.errorMaxLines,
      floatingLabelBehavior: floatingLabelBehavior ?? this.floatingLabelBehavior,
      floatingLabelAlignment: floatingLabelAlignment ?? this.floatingLabelAlignment,
      isCollapsed: isCollapsed ?? this.isCollapsed,
      isDense: isDense ?? this.isDense,
      contentPadding: contentPadding ?? this.contentPadding,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      prefix: prefix ?? this.prefix,
      prefixText: prefixText ?? this.prefixText,
      prefixStyle: prefixStyle ?? this.prefixStyle,
      prefixIconColor: prefixIconColor ?? this.prefixIconColor,
      prefixIconConstraints: prefixIconConstraints ?? this.prefixIconConstraints,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      suffix: suffix ?? this.suffix,
      suffixText: suffixText ?? this.suffixText,
      suffixStyle: suffixStyle ?? this.suffixStyle,
      suffixIconColor: suffixIconColor ?? this.suffixIconColor,
      suffixIconConstraints: suffixIconConstraints ?? this.suffixIconConstraints,
      counter: counter ?? this.counter,
      counterText: counterText ?? this.counterText,
      counterStyle: counterStyle ?? this.counterStyle,
      filled: filled ?? this.filled,
      fillColor: fillColor ?? this.fillColor,
      focusColor: focusColor ?? this.focusColor,
      hoverColor: hoverColor ?? this.hoverColor,
      errorBorder: errorBorder ?? this.errorBorder,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      focusedErrorBorder: focusedErrorBorder ?? this.focusedErrorBorder,
      disabledBorder: disabledBorder ?? this.disabledBorder,
      enabledBorder: enabledBorder ?? this.enabledBorder,
      border: border ?? this.border,
      enabled: enabled ?? this.enabled,
      semanticCounterText: semanticCounterText ?? this.semanticCounterText,
      alignLabelWithHint: alignLabelWithHint ?? this.alignLabelWithHint,
      constraints: constraints ?? this.constraints,
      fluPrefixIcon: fluPrefixIcon ?? this.fluPrefixIcon,
      fluSuffixIcon: fluPrefixIcon ?? this.fluPrefixIcon,
      boxShadow: boxShadow ?? this.boxShadow,
      expand: expand ?? this.expand,
      height: height ?? this.height,
      radius: radius ?? this.radius,
      borderWidth: borderWidth ?? this.borderWidth,
      iconSize: iconSize ?? this.iconSize,
      iconStrokeWidth: iconStrokeWidth ?? this.iconStrokeWidth,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      borderColor: borderColor ?? this.borderColor,
      color: color ?? this.color,
      hintColor: hintColor ?? this.hintColor,
      cursorColor: cursorColor ?? this.cursorColor,
      selectionColor: selectionColor ?? this.selectionColor,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      textAlign: textAlign ?? this.textAlign,
      textAlignVertical: textAlignVertical ?? this.textAlignVertical,
      keyboardType: keyboardType ?? this.keyboardType,
      textInputAction: textInputAction ?? this.textInputAction,
      maxLines: maxLines ?? this.maxLines,
    );
  }
}
