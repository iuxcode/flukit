part of '../flu_utils.dart';

extension FlukitCore on FlukitInterface {
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

  /// Verify if the [value] is a correct phone number based on the selected region.
  Future<bool> validatePhoneNumber(String value, String countryCode) async {
    return await phoneNumber.validate(value, countryCode);
    // .catchError((error, stackTrace) => Future.error('Invalid phone number'));
  }

  /// Verify if the [email] is correct.
  Future<bool> validateEmail(String email) async {
    return false;
  }

  /// format seconds to time
  String timeLeft(int value) {
    int h, m, s;

    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);

    String hourLeft = h.toString().length < 2 ? "0$h" : h.toString();
    String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();
    String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();

    return "$hourLeft : $minuteLeft : $secondsLeft";
  }

  Uint8List dataFromBase64String(String base64String) => base64Decode(base64String);
}