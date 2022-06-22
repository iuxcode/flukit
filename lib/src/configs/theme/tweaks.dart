import 'package:flutter/material.dart';

/// FlukitInterface allows any auxiliary package to be merged into the app constants
/// class through extensions
abstract class FluConstsInterface {
  FluConstsInterface();

  /// Font sizes
  double get verySmallFs => 12;
  double get smallFs => 13;
  double get bodyFs => 14;
  double get subtitleFs => 16;
  double get titleFs => 18;
  double get subHeadlineFs => 20;
  double get headlineFs => 22;
  double get extraHeadlineFs => 24;

  /// Font weights
  FontWeight get textExtraBold => FontWeight.w900; 
  FontWeight get textBold => FontWeight.bold;
  FontWeight get textSemibold => FontWeight.w600;
  FontWeight get textMedium => FontWeight.w500;
  FontWeight get textLight => FontWeight.w400;
  FontWeight get textNormal => FontWeight.normal;

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

  /// default animations
  Duration get defaultAnimationDuration => const Duration(milliseconds: 300);
  Curve get defaultAnimationCurve => Curves.easeInOut;

  /// default page transition duration and curve
  Duration get defaultPageAnimationDuration => const Duration(milliseconds: 300);
  Curve get defaultPageAnimationCurve => Curves.fastOutSlowIn;

  /// Bottom navigation
  double get bottomNavBarHeight => 85;
  double get bottomNavBarRadius => 28;
  double get bottomNavBarHMarginSize => 15;
  double get bottomNavBarBMarginSize => 0;
  double get bottomNavBarIndicatorHeight => 100;
  double get bottomNavBarElevation => 45;
  double get bottomNavBarNotchMargin => 10;
  double get bottomNavBarGapWidth => 45;

  String get backButtonHeroTag => '<backButton>';
  String get mainButtonHeroTag => '<mainButton>';
  String get titleTextHeroTag => '<titleText>';
  String get title2TextHeroTag => '<title2Text>';
  String get descriptionTextHeroTag => '<descriptionText>';
  String get brandTextHeroTag => '<brandText>';

  int get httpConnectTimeout => 35000;
  int get httpReceiveTimeout => 35000;
  int get httpSendTimeout => 35000;
}
class _FluConstsImpl extends FluConstsInterface {}

// ignore: non_constant_identifier_names
final FluConstsInterface FluConsts = _FluConstsImpl();