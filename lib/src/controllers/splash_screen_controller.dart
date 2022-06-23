import 'package:get/get.dart';

class FluSplashScreenController extends GetxController {
  final void Function() onInitialized;

  FluSplashScreenController(this.onInitialized);

  @override
  void onReady() {
    onInitialized();
    super.onReady();
  }
}