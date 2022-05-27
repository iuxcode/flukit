import 'package:get/get.dart';

class FluOnboardingScreenController extends GetxController {
  final Rx<int> _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  set currentIndex(int index) => _currentIndex.value = index;
}