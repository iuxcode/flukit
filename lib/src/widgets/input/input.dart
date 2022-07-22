import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

export 'basic_text_field.dart';
export './basic_text_input_client.dart';
export 'replacements.dart';
export './text_editing_delta_history_manager.dart';
export './toggle_buttons_state_manager.dart';

/// Basic input field
class FluTextInput extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final FluTextInputStyle style;

  const FluTextInput({
    Key? key,
    required this.hintText,
    this.controller,
    this.focusNode,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.style = const FluTextInputStyle(),
  }) : super(key: key);

  @override
  State<FluTextInput> createState() => _FluTextInputState();
}

class _FluTextInputState extends State<FluTextInput> {
  late FocusNode focusNode;

  final FluTheme theme = Flukit.theme;
  final ThemeData themeData = Flukit.theme.data;

  @override
  void initState() {
    focusNode = widget.focusNode != null ? widget.focusNode! : FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.style.expand
            ? double.infinity
            : (widget.style.height ?? Flukit.appConsts.defaultElSize),
        margin: widget.style.margin,
        padding: widget.style.padding,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: widget.style.fillColor ?? theme.palette.accentBackground,
          boxShadow: widget.style.boxShadow,
          border: widget.style.borderWidth != null
              ? Border.all(
                  color: widget.style.borderColor ??
                      themeData.backgroundColor.withOpacity(.05),
                  width: widget.style.borderWidth!)
              : null,
          borderRadius: BorderRadius.circular(
              widget.style.radius ?? Flukit.appConsts.defaultElRadius),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.style.prefixIcon != null) icon(widget.style.prefixIcon),
            Expanded(
              child: TextFormField(
                controller: widget.controller,
                focusNode: focusNode,
                expands: true,
                maxLines: null,
                textAlign: widget.style.textAlign ?? TextAlign.center,
                textAlignVertical: widget.style.textAlignVertical,
                keyboardType: widget.style.keyboardType,
                textInputAction: widget.style.textInputAction,
                inputFormatters: widget.inputFormatters,
                style: themeData.textTheme.bodyText1!.copyWith(
                  color: widget.style.color ?? theme.palette.accentText,
                  fontWeight: Flukit.appConsts.textSemibold,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      widget.style.fillColor ?? theme.palette.accentBackground,
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: theme.data.textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: widget.style.hintColor ?? theme.palette.text),
                  errorStyle:
                      const TextStyle(height: 0, color: Colors.transparent),
                  // prefixIcon: widget.prefixIcon != null ? icon(widget.prefixIcon!) : null,
                  // suffixIcon: widget.suffixIcon != null ? icon(widget.suffixIcon!) : null,
                ),
                validator: widget.validator,
                onChanged: widget.onChanged,
              ),
            ),
            if (widget.style.suffixIcon != null) icon(widget.style.suffixIcon),
          ],
        ));
  }

  Widget icon(FluIconModel? icon) => GestureDetector(
        onTap: () {
          focusNode.requestFocus();
        },
        child: SizedBox(
          width: widget.style.iconSize,
          child: icon != null
              ? FluIcon(
                  icon: icon,
                  style: FluIconStyle(
                    color: widget.style.iconColor ?? theme.palette.accentText,
                    size: widget.style.iconSize,
                    strokeWidth: widget.style.iconStrokeWidth,
                  ),
                )
              : null,
        ),
      );
}

/// Input field with label
class FluTextInputWithLabel extends StatelessWidget {
  final TextEditingController controller;
  final String label, inputHint;
  final FluIconModel? icon;
  final bool isRequired;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final FluTextInputStyle style;

  const FluTextInputWithLabel({
    Key? key,
    required this.label,
    required this.inputHint,
    this.icon,
    this.isRequired = true,
    required this.controller,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: label.capitalize!),
                if (isRequired)
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Flukit.themePalette.danger,
                      fontWeight: Flukit.appConsts.textBold,
                    ),
                  )
              ],
              style: Flukit.textTheme.bodyText1!.copyWith(
                // fontSize: Flukit.appConsts.subtitleFs,
                fontWeight: Flukit.appConsts.textSemibold,
                color: Flukit.theme.textColor,
              ),
            ),
          ),
          FluOutline(
            thickness: .5,
            radius: Flukit.appConsts.defaultElRadius + 2,
            margin: const EdgeInsets.only(top: 10),
            boxShadow:
                Flukit.boxShadow(offset: const Offset(0, 0), opacity: .05),
            child: FluTextInput(
              controller: controller,
              hintText: inputHint,
              style: style,
              validator: (value) => (value == null || value.isEmpty)
                  ? 'This field is required.'
                  : null,
            ),
          )
        ]),
      );
}

/// Rich text input field
/// Must be wrapped with [FluToggleButtonsStateManager]
class FluRichTextInput extends StatefulWidget {
  final FluReplacementTextEditingController controller;
  final TextStyle textStyle;
  final FluTextInputStyle? style;
  final FocusNode focusNode;
  final void Function(List<TextEditingDelta> deltas)? onDeltasHistoryUpdate;

  const FluRichTextInput({
    Key? key,
    required this.controller,
    this.style,
    required this.textStyle,
    required this.focusNode,
    this.onDeltasHistoryUpdate,
  }) : super(key: key);

  @override
  State<FluRichTextInput> createState() => _FluRichTextInputState();
}

class _FluRichTextInputState extends State<FluRichTextInput> {
  final List<TextEditingDelta> _textEditingDeltaHistory = [];

  void _updateTextEditingDeltaHistory(
      List<TextEditingDelta> textEditingDeltas) {
    for (final TextEditingDelta delta in textEditingDeltas) {
      _textEditingDeltaHistory.add(delta);
    }

    widget.onDeltasHistoryUpdate?.call(_textEditingDeltaHistory);
    setState(() {});
  }

  /* List<Widget> _buildTextEditingDeltaHistoryViews(
      List<TextEditingDelta> textEditingDeltas) {
    List<Widget> textEditingDeltaViews = [];

    for (final TextEditingDelta delta in textEditingDeltas) {
      final TextEditingDeltaView deltaView;

      if (delta is TextEditingDeltaInsertion) {
        deltaView = TextEditingDeltaView(
          deltaType: 'Insertion',
          deltaText: delta.textInserted,
          deltaRange: TextRange.collapsed(delta.insertionOffset),
          newSelection: delta.selection,
          newComposing: delta.composing,
        );
      } else if (delta is TextEditingDeltaDeletion) {
        deltaView = TextEditingDeltaView(
          deltaType: 'Deletion',
          deltaText: delta.textDeleted,
          deltaRange: delta.deletedRange,
          newSelection: delta.selection,
          newComposing: delta.composing,
        );
      } else if (delta is TextEditingDeltaReplacement) {
        deltaView = TextEditingDeltaView(
          deltaType: 'Replacement',
          deltaText: delta.replacementText,
          deltaRange: delta.replacedRange,
          newSelection: delta.selection,
          newComposing: delta.composing,
        );
      } else if (delta is TextEditingDeltaNonTextUpdate) {
        deltaView = TextEditingDeltaView(
          deltaType: 'NonTextUpdate',
          deltaText: '',
          deltaRange: TextRange.empty,
          newSelection: delta.selection,
          newComposing: delta.composing,
        );
      } else {
        deltaView = const TextEditingDeltaView(
          deltaType: 'Error',
          deltaText: 'Error',
          deltaRange: TextRange.empty,
          newSelection: TextRange.empty,
          newComposing: TextRange.empty,
        );
      }

      textEditingDeltaViews.add(deltaView);
    }

    return textEditingDeltaViews.reversed.toList();
  } */

  @override
  Widget build(BuildContext context) => TextEditingDeltaHistoryManager(
        history: _textEditingDeltaHistory,
        updateHistoryOnInput: _updateTextEditingDeltaHistory,
        child: FluBasicTextField(
          controller: widget.controller,
          style: widget.style ?? const FluTextInputStyle(),
          textStyle: widget.textStyle,
          focusNode: widget.focusNode,
        ),
      );
}

/// Input style
class FluTextInputStyle {
  final FluIconModel? prefixIcon, suffixIcon;
  final List<BoxShadow>? boxShadow;
  final Color? borderColor, color, hintColor, fillColor, iconColor;
  final double? height, radius;
  final double? borderWidth, iconSize, iconStrokeWidth;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets? margin, padding;
  final CrossAxisAlignment? alignment;
  final bool expand;

  const FluTextInputStyle({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    this.iconColor,
    this.boxShadow,
    this.borderColor,
    this.color,
    this.hintColor,
    this.fillColor,
    this.iconStrokeWidth = 1.5,
    this.iconSize = 20,
    this.borderWidth = .8,
    this.radius,
    this.textAlign = TextAlign.center,
    this.textAlignVertical = TextAlignVertical.center,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.symmetric(horizontal: 15),
    this.height,
    this.alignment = CrossAxisAlignment.center,
    this.expand = false,
  });

  FluTextInputStyle copyWith({
    FluIconModel? prefixIcon,
    suffixIcon,
    List<BoxShadow>? boxShadow,
    Color? borderColor,
    Color? color,
    Color? hintColor,
    Color? fillColor,
    Color? iconColor,
    double? height,
    double? radius,
    double? borderWidth,
    double? iconSize,
    double? iconStrokeWidth,
    TextAlign? textAlign,
    TextAlignVertical? textAlignVertical,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    EdgeInsets? margin,
    EdgeInsets? padding,
    CrossAxisAlignment? alignment,
    bool? expand,
  }) =>
      FluTextInputStyle(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        iconColor: iconColor,
        boxShadow: boxShadow,
        borderColor: borderColor,
        color: color,
        hintColor: hintColor,
        fillColor: fillColor,
        iconStrokeWidth: iconStrokeWidth,
        iconSize: iconSize,
        borderWidth: borderWidth,
        radius: radius,
        textAlign: textAlign,
        textAlignVertical: textAlignVertical,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        margin: margin,
        padding: padding,
        height: height,
        alignment: alignment,
        expand: expand ?? false,
      );
}
