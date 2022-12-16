part of '../flu_utils.dart';

extension FluCore on FluInterface {
  /// Phone number validator plugin
  PhoneNumberUtil get phoneNumber => PhoneNumberUtil();

  /// Provides a haptic feedback indication selection changing through discrete values.
  /// On iOS versions 10 and above, this uses a UISelectionFeedbackGenerator. This call has no effects on iOS versions below 10.
  /// On Android, this uses HapticFeedbackConstants.CLOCK_TICK.
  void selectionClickHaptic() => HapticFeedback.selectionClick();

  /// Provides vibration haptic feedback to the user for a short duration.
  /// On iOS devices that support haptic feedback, this uses the default system vibration value (kSystemSoundID_Vibrate).
  /// On Android, this uses the platform haptic feedback API to simulate a response to a long press (HapticFeedbackConstants.LONG_PRESS).
  void vibrationHaptic() => HapticFeedback.vibrate();

  /// Provides a haptic feedback corresponding a collision impact with a light mass.
  /// On iOS versions 10 and above, this uses a UIImpactFeedbackGenerator with UIImpactFeedbackStyleLight. This call has no effects on iOS versions below 10.
  /// On Android, this uses HapticFeedbackConstants.VIRTUAL_KEY.
  void lightImpactHaptic() => HapticFeedback.lightImpact();

  /// Provides a haptic feedback corresponding a collision impact with a medium mass.
  /// On iOS versions 10 and above, this uses a UIImpactFeedbackGenerator with UIImpactFeedbackStyleMedium. This call has no effects on iOS versions below 10.
  /// On Android, this uses HapticFeedbackConstants.KEYBOARD_TAP.
  void mediumImpactHaptic() => HapticFeedback.mediumImpact();

  /// Provides a haptic feedback corresponding a collision impact with a heavy mass.
  /// On iOS versions 10 and above, this uses a UIImpactFeedbackGenerator with UIImpactFeedbackStyleHeavy. This call has no effects on iOS versions below 10.
  /// On Android, this uses HapticFeedbackConstants.CONTEXT_CLICK on API levels 23 and above. This call has no effects on Android API levels below 23.
  void heavyImpactHaptic() => HapticFeedback.heavyImpact();

  /// Provides a haptic feedback corresponding a collision impact with [PhysicFeedbackIntensity] mass.
  void physicFeedback() {
    if (Flu.appSettings.enablePhysicFeedback) {
      switch (Flu.appSettings.physicFeedbackIntensity) {
        case PhysicFeedbackIntensity.light:
          lightImpactHaptic();
          break;
        case PhysicFeedbackIntensity.normal:
          selectionClickHaptic();
          break;
        case PhysicFeedbackIntensity.medium:
          mediumImpactHaptic();
          break;
        case PhysicFeedbackIntensity.heavy:
          heavyImpactHaptic();
          break;
      }
    }
  }

  /// Verify if the [value] is a correct phone number based on the selected region.
  Future<bool> validatePhoneNumber(String value, String countryCode) async {
    return await phoneNumber.validate(value, countryCode);
    // .catchError((error, stackTrace) => Future.error('Invalid phone number'));
  }

  /// Verify if the [email] is correct.
  /// TODO validate email
  Future<bool> validateEmail(String email) async {
    return false;
  }

  Uint8List dataFromBase64String(String base64String) =>
      base64Decode(base64String);
}
