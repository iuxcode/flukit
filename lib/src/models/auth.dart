import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

class FluAuthScreenStep {
  FluAuthScreenStep({
    required this.title,
    required this.desc,
    required this.buttonLabel,
    required this.image,
    this.imageType = FluImageSource.network,
    this.buttonIcon,
  });

  final FluIcons? buttonIcon;
  final String image, title, desc, buttonLabel;
  final FluImageSource imageType;
}

class FluAuthScreenInputStep extends FluAuthScreenStep {
  FluAuthScreenInputStep({
    required String title,
    required String desc,
    required String buttonLabel,
    required String image,
    required this.inputHint,
    FluImageSource? imageType,
    FluIcons? buttonIcon,
    this.inputValidator,
    this.onInputValueChanged,
    this.onError,
    this.inputHeight,
    this.inputRadius,
  }) : super(
          title: title,
          desc: desc,
          buttonLabel: buttonLabel,
          buttonIcon: buttonIcon,
          image: image,
          imageType: imageType ?? FluImageSource.network,
        );

  final bool Function(String value, FluAuthScreenController controller)?
      inputValidator;

  final void Function(String value, FluAuthScreenController controller)?
      onInputValueChanged;

  final String Function(FluAuthScreenController controller)? onError;
  final double? inputHeight;
  final String inputHint;
  final double? inputRadius;
}

class FluAuthScreenCustomStep extends FluAuthScreenStep {
  FluAuthScreenCustomStep(
      {required this.builder,
      this.onButtonPressed,
      required String title,
      required String desc,
      required String buttonLabel,
      required String image,
      FluIcons? buttonIcon})
      : super(
          title: title,
          desc: desc,
          buttonLabel: buttonLabel,
          buttonIcon: buttonIcon,
          image: image,
        );

  final Widget Function(
      BuildContext context,
      FluAuthScreenController controller,
      TextEditingController inputController) builder;

  final bool Function(FluAuthScreenController controller)? onButtonPressed;
}

class FluAuthData {
  FluAuthData();
}
