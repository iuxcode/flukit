import 'package:flukit_icons/flukit_icons.dart';

import '../../widgets/image.dart';

class FluOnboardingScreenPage {
  final String? image;
  final FluImageType? imageType;
  final String title, desc;
  final String? buttonText;
  final FluIconModel? buttonIcon;

  FluOnboardingScreenPage({
    this.imageType,
    this.image,
    required this.title,
    required this.desc,
    this.buttonText,
    this.buttonIcon,
  });
}