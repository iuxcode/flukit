import 'dart:convert';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_number/phone_number.dart';

/// Add core utilities to [FluInterface]
extension CoreExt on FluInterface {
  /// As a rule, Flutter knows which widget to update,
  /// so this command is rarely needed. We can mention situations
  /// where you use const so that widgets are not updated with setState,
  /// but you want it to be forcefully updated when an event like
  /// language change happens. using context to make the widget dirty
  /// for performRebuild() is a viable solution.
  /// However, in situations where this is not possible, or at least,
  /// is not desired by the developer, the only solution for updating
  /// widgets that Flutter does not want to update is to use reassemble
  /// to forcibly rebuild all widgets. Attention: calling this function will
  /// reconstruct the application from the sketch, use this with caution.
  /// Your entire application will be rebuilt, and touch events will not
  /// work until the end of rendering.
  Future<void> forceAppUpdate() async {
    await engine.performReassemble();
  }

  ///The current [WidgetsBinding]
  WidgetsBinding get engine => WidgetsFlutterBinding.ensureInitialized();

  /// Phone number validator plugin
  PhoneNumberUtil get phoneNumber => PhoneNumberUtil();

  /// Provides a haptic feedback indication selection
  /// changing through discrete values.
  /// On iOS versions 10 and above, this uses a UISelectionFeedbackGenerator.
  /// This call has no effects on iOS versions below 10.
  /// On Android, this uses HapticFeedbackConstants.CLOCK_TICK.
  Future<void> triggerSelectionClickHaptic() async =>
      HapticFeedback.selectionClick();

  /// Provides vibration haptic feedback to the user for a short duration.
  /// On iOS devices that support haptic feedback, this uses the default system
  /// vibration value (kSystemSoundID_Vibrate).
  /// On Android, this uses the platform haptic feedback API to simulate
  /// a response to a long press (HapticFeedbackConstants.LONG_PRESS).
  Future<void> triggerVibrationHaptic() async => HapticFeedback.vibrate();

  /// Provides a haptic feedback corresponding
  /// a collision impact with a light mass.
  /// On iOS versions 10 and above, this uses a UIImpactFeedbackGenerator with
  /// UIImpactFeedbackStyleLight.
  /// This call has no effects on iOS versions below 10.
  /// On Android, this uses HapticFeedbackConstants.VIRTUAL_KEY.
  Future<void> triggerLightImpactHaptic() async => HapticFeedback.lightImpact();

  /// Provides a haptic feedback corresponding a collision impact
  /// with a medium mass.
  /// On iOS versions 10 and above, this uses a UIImpactFeedbackGenerator with
  /// UIImpactFeedbackStyleMedium.
  /// This call has no effects on iOS versions below 10.
  /// On Android, this uses HapticFeedbackConstants.KEYBOARD_TAP.
  Future<void> triggerMediumImpactHaptic() async =>
      HapticFeedback.mediumImpact();

  /// Provides a haptic feedback corresponding
  /// a collision impact with a heavy mass.
  /// On iOS versions 10 and above, this uses a
  /// UIImpactFeedbackGenerator with UIImpactFeedbackStyleHeavy.
  /// This call has no effects on iOS versions below 10.
  /// On Android, this uses HapticFeedbackConstants.CONTEXT_CLICK
  /// on API levels 23 and above.
  /// This call has no effects on Android API levels below 23.
  Future<void> triggerHeavyImpactHaptic() async => HapticFeedback.heavyImpact();

  /// Verify if the [value] is a correct
  /// phone number based on the selected region.
  Future<bool> validatePhoneNumber(String value, String countryCode) async =>
      phoneNumber
          .validate(value, regionCode: countryCode)
          .onError((error, stackTrace) => false);

  /// Verify if the [email] is correct.
  /// TODO validate email
  Future<bool> validateEmail(String email) async => throw UnimplementedError();

  /// Decodes base64 or base64url encoded bytes.
  Uint8List dataFromBase64String(String base64String) =>
      base64Decode(base64String);
}
