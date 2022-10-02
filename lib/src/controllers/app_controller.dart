import 'package:flukit/src/models/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flukit/src/configs/theme/index.dart';

import '../configs/settings.dart';
import '../utils/flu_utils.dart';

class FluAppController extends GetMaterialController {
  final FluStorageService storageService = Flukit.secureStorage;

  final FluAppInformations infos;

  late FluSettingsInterface settings;

  final Rx<FluApiSettings> _apiSettings =
      FluApiSettings(baseUrl: 'http://localhost:8000').obs;
  final Rx<FluTheme> _fluTheme = FluTheme().obs;

  FluAppController({
    this.infos = const FluAppInformations(),
    FluApiSettings? apiSettings,
    FluSettingsInterface? settings,
  }) {
    if (apiSettings != null) {
      _apiSettings.value = apiSettings;
    }

    this.settings = settings ?? FluSettings;
    Get.isDarkMode;
  }

  FluTheme get fluTheme => _fluTheme.value;
  @override
  ThemeData get theme => fluTheme.theme;
  @override
  ThemeData get darkTheme => fluTheme.darkTheme;
  FluApiSettings get apiSettings => _apiSettings.value;

  void changeTheme(FluTheme value) {
    _fluTheme.value = value;
    update();
  }

  @override
  @deprecated
  void setTheme(ThemeData value) {}

  set apiSettings(FluApiSettings newSettings) {
    _apiSettings.value = newSettings;
    update();
  }

  Future<bool> firstTimeOpening() async {
    if (await storageService.containsKey(FluSecureStorageKeys.firstTimeOpening)) {
      try {
        String? state =
            await storageService.read(FluSecureStorageKeys.firstTimeOpening);

        return (state != null && state.toLowerCase() == 'true') ? true : false;
      } catch (e) {
        return Future.error(e);
      }
    } else {
      return false;
    }
  }

  Future<void> setFirstTimeOpeningState(bool state) async {
    try {
      await Flukit.secureStorage.write(FluSecureStorageItem(
          FluSecureStorageKeys.firstTimeOpening, state.toString()));
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<FluAuthorizationStates?> getAuthorizationState() async {
    try {
      if (await storageService
          .containsKey(FluSecureStorageKeys.authorizationState)) {
        String? state =
            await storageService.read(FluSecureStorageKeys.authorizationState);

        if (state != null) {
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
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> setAuthorizationState(FluAuthorizationStates state) async {
    try {
      await storageService.write(FluSecureStorageItem(
          FluSecureStorageKeys.authorizationState, state.toString()));
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String?> getAuthicationData() async {
    try {
      if (await storageService
          .containsKey(FluSecureStorageKeys.authenticationData)) {
        String? state =
            await storageService.read(FluSecureStorageKeys.authenticationData);

        return state;
      } else {
        return null;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> setAuthicationData(String data) async {
    try {
      await storageService.write(FluSecureStorageItem(
          FluSecureStorageKeys.authenticationData, data.toString()));
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String?> getApiRefreshToken() async {
    try {
      if (await storageService.containsKey(FluSecureStorageKeys.apiRefreshToken)) {
        String? state =
            await storageService.read(FluSecureStorageKeys.apiRefreshToken);

        return state;
      } else {
        return null;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> setApiRefreshToken(String data) async {
    try {
      await storageService.write(FluSecureStorageItem(
          FluSecureStorageKeys.apiRefreshToken, data.toString()));
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
}
