import 'package:get/get.dart';
import 'package:flukit/src/configs/theme/index.dart';

import '../utils/flu_utils.dart';

class FluAppController extends GetxController {
  final FluTheme? defaultTheme;
  final FluApiSettings? baseApiSettings;
  final storageService = Flukit.secureStorage; 

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

  Future<bool> firstTimeOpening() async {
    if(await storageService.containsKey(FluSecureStorageKeys.firstTimeOpening)) {
      try {
        String? state = await storageService.read(FluSecureStorageKeys.firstTimeOpening);

        return (state != null && state.toLowerCase() == 'true') ? true : false;
      } catch (e) {
        return Future.error(e);
      }
    }
    else {
      return false;
    }
  }
  Future<void> setFirstTimeOpeningState(bool state) async {
    try {
      await Flukit.secureStorage.write(FluSecureStorageItem(FluSecureStorageKeys.firstTimeOpening, state.toString()));
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<FluAuthorizationStates?> getAuthorizationState() async {
    try {
      if(await storageService.containsKey(FluSecureStorageKeys.authorizationState)) {
        String? state = await storageService.read(FluSecureStorageKeys.authorizationState);

        if(state != null) {
          FluAuthorizationStates newState;

          switch (state) {
            case 'FluAuthorizationStates.waitCode':
              newState = FluAuthorizationStates.waitCode;
              break;
            case 'FluAuthorizationStates.waitTerms':
              newState = FluAuthorizationStates.waitTerms;
              break;
            case 'FluAuthorizationStates.ready':
              newState = FluAuthorizationStates.ready;
              break;
            case 'FluAuthorizationStates.waitPhoneNumber':
            default:
              newState = FluAuthorizationStates.waitAuth;
              break;
          }

          return newState; 
        }
        else {
          return null;
        }
      }
      else {
        return null;
      }
    } catch (e) {
      return Future.error(e);
    }
  }
  Future<void> setAuthorizationState(FluAuthorizationStates state) async {
    try {
      await storageService.write(FluSecureStorageItem(FluSecureStorageKeys.authorizationState, state.toString()));
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String?> getAuthicationData() async {
    try {
      if(await storageService.containsKey(FluSecureStorageKeys.authenticationData)) {
        String? state = await storageService.read(FluSecureStorageKeys.authenticationData);

        return state;
      }
      else {
        return null;
      }
    } catch (e) {
      return Future.error(e);
    }
  }
  Future<void> setAuthicationData(String data) async {
    try {
      await storageService.write(FluSecureStorageItem(FluSecureStorageKeys.authenticationData, data.toString()));
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String?> getApiRefreshToken() async {
    try {
      if(await storageService.containsKey(FluSecureStorageKeys.apiRefreshToken)) {
        String? state = await storageService.read(FluSecureStorageKeys.apiRefreshToken);

        return state;
      }
      else {
        return null;
      }
    } catch (e) {
      return Future.error(e);
    }
  }
  Future<void> setApiRefreshToken(String data) async {
    try {
      await storageService.write(FluSecureStorageItem(FluSecureStorageKeys.apiRefreshToken, data.toString()));
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> clearApiRefreshToken() async {
    try {
      await storageService.delete(FluSecureStorageKeys.apiRefreshToken);
    } catch (e) {
      return Future.error(e);
    }
  }

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