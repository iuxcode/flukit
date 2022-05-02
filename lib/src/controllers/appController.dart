import 'package:get/get.dart';
import 'package:flukit/src/configs/theme/index.dart';

import '../utils/flu_utils.dart';

class FluAppController extends GetxController {
  final FluTheme? defaultTheme;
  final FluApiSettings? baseApiSettings;

  final RxBool _isDark = false.obs;
  final Rx<FluTheme> _theme = FluTheme().obs;
  final Rx<FluApiSettings> _apiSettings = FluApiSettings(baseUrl: 'http://localhost:8000').obs;

  FluAppController({
    this.defaultTheme,
    this.baseApiSettings
  });

  bool get isDark => _isDark.value;
  FluTheme get theme => _theme.value;
  FluApiSettings get apiSettings => _apiSettings.value;

  set isDark(bool value) => _isDark.value = value;
  set theme(FluTheme newTheme) => _theme.value = newTheme;

  @override
  void onInit() {
    if (defaultTheme != null) {
      _theme.value = defaultTheme!;
    }

    if (baseApiSettings != null) {
      _apiSettings.value = baseApiSettings!;
    }

    super.onInit();
  }
}