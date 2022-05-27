import 'package:flukit/src/models/flu_models.dart';
import 'package:get/get.dart';
import 'authScreenController.dart';

class FluOtpScreenController extends FluAuthScreenController {
  /// control if the user can ask for a new code or not
  final RxBool _canAsk = true.obs;

  /// code ask loading state 
  final RxBool _askLoading = false.obs;

  /// Time to wait before asking otp
  final RxInt _waitingTime = 0.obs;

  FluOtpScreenController({
    required List<FluAuthScreenStep> initialSteps,
  }) : super(initialSteps: initialSteps);

  /// Getters
  bool get canAsk => _canAsk.value;
  bool get askLoading => _askLoading.value;
  int get waitingTime => _waitingTime.value;

  /// Setters
  set canAsk(bool state) => _canAsk.value = state;
  set askLoading(bool state) => _askLoading.value = state;
  set waitingTime(int value) => _waitingTime.value = value;
}