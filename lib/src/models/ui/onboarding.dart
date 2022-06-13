import '../../widgets/image.dart';

class FluOnboardingScreenPage {
  final String image;
  final FluImageType? imageType;
  final String title, desc;

  FluOnboardingScreenPage({
    this.imageType,
    required this.image,
    required this.title,
    required this.desc,
  });
}