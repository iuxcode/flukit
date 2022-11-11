import 'package:flukit/src/utils/flu_utils.dart';
import 'package:flutter/widgets.dart';

extension FluTextSpan on TextSpan {
  /// Replace all emojis in text with [Joypixels] emojis.
  TextSpan replaceEmojis() => Flu.replaceEmojis(this);
}
