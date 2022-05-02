import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';

class FluAuthScreenStepModel {
  final FluImageType? imageType;
  final String image;
  final String title, desc, inputHint, buttonLabel;
  final FluIconModel? buttonIcon;
  final bool Function(String value, FluAuthScreenController controller)? inputValidator;
  final void Function(String value, FluAuthScreenController controller)? onInputValueChanged;
  final String Function(FluAuthScreenController controller)? onError;

  FluAuthScreenStepModel({
    required this.title,
    required this.desc,
    required this.inputHint,
    required this.buttonLabel,
    required this.image,
    this.imageType,
    this.buttonIcon,
    this.inputValidator,
    this.onInputValueChanged,
    this.onError
  });
}