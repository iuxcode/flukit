import 'package:flutter/material.dart';

enum PhysicFeedbackIntensity {
  light,
  normal,
  medium,
  heavy,
}

/// FluInterface allows any auxiliary package to be merged into the app constants
/// class through extensions
abstract class FluSettingsInterface {
  FluSettingsInterface();

  /// Font sizes
  double get verySmallFs => 10;
  double get smallFs => 13;
  double get bodyFs => 14;
  double get subtitleFs => 16;
  double get titleFs => 18;
  double get subHeadlineFs => 20;
  double get headlineFs => 22;
  double get extraHeadlineFs => 24;

  /// base
  double get defaultPaddingSize => 30;
  double get defaultPageMaxWidthFactor => .85;
  double get defaultElSize => 68;
  double get defaultElRadius => 22;
  double get minElSize => 55;
  double get minElRadius => 18;
  double get defaultAppBarSize => defaultElSize;
  double get defaultAvatarSize => 57;
  double get defaultAvatarRadius => 24;

  /// Chip
  double get defaultChipHeight => 65;

  /// default page transition duration and curve
  Duration get defaultPageAnimationDuration =>
      const Duration(milliseconds: 300);
  Curve get defaultPageAnimationCurve => Curves.fastOutSlowIn;

  int get httpConnectTimeout => 35000;
  int get httpReceiveTimeout => 35000;
  int get httpSendTimeout => 35000;

  String? get emojiFont => null;

  bool get enablePhysicFeedback => true;
  PhysicFeedbackIntensity get physicFeedbackIntensity =>
      PhysicFeedbackIntensity.light;
}

class _FluSettingsImpl extends FluSettingsInterface {}

// ignore: non_constant_identifier_names
final FluSettingsInterface FluSettings = _FluSettingsImpl();
