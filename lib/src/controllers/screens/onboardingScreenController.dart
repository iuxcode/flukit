import 'package:get/get.dart';

class FluOnboardingScreenController extends GetxController {
  final Rx<int> _currentIndex = 0.obs;
  final RxBool _onLastPage = false.obs;

  int get currentIndex => _currentIndex.value;
  bool get onFirstPage => currentIndex == 0;
  bool get onLastPage => _onLastPage.value;

  set currentIndex(int index) => _currentIndex.value = index;
  set onLastPage(bool value) => _onLastPage.value = value;
}