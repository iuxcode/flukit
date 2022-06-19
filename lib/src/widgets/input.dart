import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FluTextInput extends StatefulWidget {
  final String hintText;
  final FluIconModel? prefixIcon, suffixIcon;
  final List<BoxShadow>? boxShadow;
  final Color? borderColor, color, hintColor, fillColor, iconColor;
  final double? height, radius;
  final double borderWidth, iconSize, iconStrokeWidth;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final EdgeInsets margin, padding;
  final CrossAxisAlignment alignment;

  const FluTextInput({
    Key? key,
    required this.hintText,
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
    this.controller,
    this.focusNode,
    this.textAlign = TextAlign.center,
    this.textAlignVertical = TextAlignVertical.center,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.symmetric(horizontal: 15),
    this.height,
    this.alignment = CrossAxisAlignment.center,
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
      height: widget.height ?? Flukit.appConsts.defaultElSize,
      margin: widget.margin,
      padding: widget.padding,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: widget.fillColor ?? theme.palette.accentBackground,
        boxShadow: widget.boxShadow,
        border: Border.all(
          color: widget.borderColor ?? themeData.backgroundColor.withOpacity(.05),
          width: widget.borderWidth
        ),
        borderRadius: BorderRadius.circular(widget.radius ?? Flukit.appConsts.defaultElRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.prefixIcon != null) icon(widget.prefixIcon),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              focusNode: focusNode,
              expands: true,
              maxLines: null,
              textAlign: widget.textAlign,
              textAlignVertical: widget.textAlignVertical,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              inputFormatters: widget.inputFormatters,
              style: themeData.textTheme.bodyText1!.copyWith(
                color: widget.color ?? theme.palette.accentText,
                fontWeight: Flukit.appConsts.textSemibold,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: widget.fillColor ?? theme.palette.accentBackground,
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: theme.data.textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: widget.hintColor ?? theme.palette.text
                ),
                errorStyle: const TextStyle(height: 0, color: Colors.transparent),
                // prefixIcon: widget.prefixIcon != null ? icon(widget.prefixIcon!) : null,
                // suffixIcon: widget.suffixIcon != null ? icon(widget.suffixIcon!) : null,
              ),
              validator: widget.validator,
              onChanged: widget.onChanged,
            ),
          ),
          if(widget.suffixIcon != null) icon(widget.suffixIcon),
        ],
      )
    );
  }

  Widget icon(FluIconModel? icon) => GestureDetector(
    onTap: () {
      focusNode.requestFocus();
    },
    child: SizedBox(
      width: widget.iconSize,
      child: icon != null ? FluIcon(
        icon: icon,
        style: FluIconStyle(
          color: widget.iconColor ?? theme.palette.accentText,
          size: widget.iconSize,
          strokeWidth: widget.iconStrokeWidth,
        ),
      ) : null,
    ),
  );
}

class FluTextInputWithLabel extends StatelessWidget {
  final TextEditingController inputController;
  final String label, inputHint;
  final FluIconModel? inputIcon;
  final double? inputHeight;
  final bool required;

  const FluTextInputWithLabel({
    Key? key,
    required this.label,
    required this.inputHint,
    this.inputIcon,
    this.required = true,
    this.inputHeight,
    required this.inputController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: label.capitalize!),
            if(required) TextSpan(text: ' *', style: TextStyle(
              color: Flukit.themePalette.danger,
              fontWeight: Flukit.appConsts.textBold
            ))
          ],
          style: Flukit.textTheme.bodyText1!.copyWith(
            // fontSize: Flukit.appConsts.subtitleFs,
            fontWeight: Flukit.appConsts.textSemibold,
            color: Flukit.theme.textColor
          )
        )),
        FluOutline(
          strokeWidth: .5,
          radius: Flukit.appConsts.defaultElRadius + 2,
          margin: const EdgeInsets.only(top: 10),
          boxShadow: Flukit.boxShadow(
            offset: const Offset(0, 0),
            opacity: .05
          ),
          child: FluTextInput(
            controller: inputController,
            height: inputHeight,
            hintText: inputHint,
            prefixIcon: inputIcon,
            textAlign: TextAlign.start,
            fillColor: Flukit.theme.backgroundColor,
            validator: (value) => (value == null || value.isEmpty) ? 'This field is required.' : null,
          ),
        )
      ]
    ),
  );
}