import 'package:get/get.dart';

class FluOnboardingScreenController extends GetxController {
  final Rx<int> _currentIndex = 0.obs;
  final Rx<double> _pageOffset = 0.0.obs;

  int get currentIndex => _currentIndex.value;
  double get pageOffset => _pageOffset.value;

  set currentIndex(int index) => _currentIndex.value = index;
  set pageOffset(double offset) => _pageOffset.value = offset;
}