import '../../widgets/image.dart';

class FluOnboardingScreenPageModel {
  final String image;
  final FluImageType? imageType;
  final String title, desc;

  FluOnboardingScreenPageModel({
    this.imageType,
    required this.image,
    required this.title,
    required this.desc,
  });
}