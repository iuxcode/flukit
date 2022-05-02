import 'package:get/get.dart';

class FluOtpScreenController extends GetxController {
  /// does form has error
  final RxBool _hasError = false.obs;

  /// control if the user can ask for a new code or not
  final RxBool _canAsk = true.obs;

  /// control if the user can submit or not
  final RxBool _canSubmit = false.obs;

  /// loading state 
  final RxBool _loading = false.obs;

  /// code ask loading state 
  final RxBool _askLoading = false.obs;

  /// Time to wait before asking otp
  final RxInt _waitingTime = 0.obs;


  /// Getters
  bool get hasError => _hasError.value;
  bool get canAsk => _canAsk.value;
  bool get canSubmit => _canSubmit.value;
  bool get loading => _loading.value;
  bool get askLoading => _askLoading.value;
  int get waitingTime => _waitingTime.value;

  /// Setters
  set hasError(bool state) => _hasError.value = state;
  set canAsk(bool state) => _canAsk.value = state;
  set canSubmit(bool state) => _canSubmit.value = state;
  set loading(bool state) => _loading.value = state;
  set askLoading(bool state) => _askLoading.value = state;
  set waitingTime(int value) => _waitingTime.value = value;
}