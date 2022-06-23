import 'package:flukit/flukit.dart';
import 'package:get/get.dart';
import 'package:phone_number/phone_number.dart';

class FluAuthScreenController extends GetxController {
  final List<FluAuthScreenStep> initialSteps;

  /// current step
  final RxInt _stepIndex = 0.obs;

  /// does form has error
  final RxBool _hasError = false.obs;

  /// control if the user can get back or not
  final RxBool _canGetBack = true.obs;

  /// control if the user can submit or not
  final RxBool _canSubmit = false.obs;

  /// loading state 
  final RxBool _loading = false.obs;

  /// country loading state 
  final RxBool _countriesLoading = false.obs;

  /// carrier country code
  final RxString _countryCode = 'tg'.obs;

  /// carrier region
  final Rxn<RegionInfo> _region = Rxn<RegionInfo>();

  /// previous input value
  final RxString _previousInputValue = ''.obs;

  /// screen steps
  final RxList<FluAuthScreenStep> _steps = <FluAuthScreenStep>[].obs;

  FluAuthScreenController({
    required this.initialSteps,
  });

  /// Getters
  int get stepIndex => _stepIndex.value;
  bool get hasError => _hasError.value;
  bool get canSubmit => _canSubmit.value;
  bool get canGetBack => _canGetBack.value;
  bool get loading => _loading.value;
  bool get countriesLoading => _countriesLoading.value;
  String get countryCode => _countryCode.value.toUpperCase();
  RegionInfo? get region => _region.value;
  String get previousInputValue => _previousInputValue.value;
  // ignore: invalid_use_of_protected_member
  List<FluAuthScreenStep> get steps => _steps.value;

  /// Setters
  set stepIndex(int value) => _stepIndex.value = value;
  set hasError(bool state) => _hasError.value = state;
  set canSubmit(bool state) => _canSubmit.value = state;
  set canGetBack(bool state) => _canGetBack.value = state;
  set loading(bool state) => _loading.value = state;
  set countriesLoading(bool state) => _countriesLoading.value = state;
  set previousInputValue(String value) => _previousInputValue.value = value;
  set steps(List<FluAuthScreenStep> value) => _steps.value = value;

  /// setRegion
  /// ** Reveive a coode as parameter and find the correct region.
  void setRegion(String code) async {
    List<RegionInfo> regions = await Flukit.phoneNumber.allSupportedRegions();
    int regionIndex = regions.indexWhere((r) => r.code == code);

    if(regionIndex >= 0) {
      _countryCode.value = code;
      _region.value = regions[regionIndex];
    }
  }
  
  /// **Get the correct carrier country code.
  void getCountryCode() async => _countryCode.value = await Flukit.phoneNumber.carrierRegionCode();

  @override
  void onInit() {
    steps = initialSteps;
    super.onInit();
  }

  @override
  void onReady() async {
    getCountryCode();
    setRegion(countryCode);
    super.onReady();
  }
}