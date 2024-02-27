import 'dart:math' as math;
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Provide UI utilities
extension UI on FluInterface {
  /// Hide the keyboard
  Future<void> hideKeyboard() async {
    await SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  /// Show the keyboard
  Future<void> showKeyboard() async {
    await SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  /// Get available avatars
  String getAvatar({FluAvatarTypes type = FluAvatarTypes.material3D, int? id}) {
    final getMaterial3DAvatars = type == FluAvatarTypes.material3D;
    int number;

    if (id != null) {
      number = id;
    } else {
      number = math.Random().nextInt(
        getMaterial3DAvatars ? 29 : 35,
      ); // 29 and 35 are the numbers of available avatars
    }

    if (getMaterial3DAvatars) {
      return 'assets/Images/Avatars/Material3D/3d_avatar_${number == 0 ? number + 1 : number}.png';
    }
    return 'assets/Images/Avatars/Memojis/avatar${number == 0 ? '' : '-$number'}.png';
  }

  /// Show a [FluModalBottomSheet]
  Future<void> showFluModalBottomSheet(
    BuildContext context, {
    required Widget child,
    EdgeInsets padding = EdgeInsets.zero,
    double? cornerRadius,
    double? maxHeight,
    Color? barrierColor,
    bool scrollable = true,
  }) async =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        // isDismissible: true,
        // enableDrag: true,
        elevation: 0,
        barrierColor: barrierColor,
        backgroundColor: Colors.transparent,
        builder: (context) => FluModalBottomSheet(
          scrollable: scrollable,
          maxHeight: maxHeight,
          cornerRadius: cornerRadius,
          padding: padding,
          child: child,
        ),
      );

  /// Show a [FluCountrySelector]
  Future<void> showCountrySelector(
    BuildContext context, {
    List<Country>? countries,
    List<Country> exclude = const [],
    String? title,
    String? description,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    EdgeInsets padding =
        const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
    void Function(Country)? onCountrySelected,
    double? maxHeight,
  }) async =>
      showFluModalBottomSheet(
        context,
        maxHeight: maxHeight,
        child: FluCountrySelector(
          title: title,
          description: description,
          titleStyle: titleStyle,
          descriptionStyle: descriptionStyle,
          padding: padding,
          countries: countries ?? Flu.countries,
          exclude: exclude,
          onCountrySelected: onCountrySelected,
        ),
      );
}

/// Avatar assets types
enum FluAvatarTypes {
  /// Use material design 3D avatars
  material3D,

  /// Use Memojis avatars
  memojis,
}
