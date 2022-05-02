import 'package:get/get.dart';

class FluTabScreenController extends GetxController {
  final RxDouble _currentIndex = 0.0.obs;

  double get currentIndex => _currentIndex.value;

  set currentIndex(double i) => _currentIndex.value = i;
}