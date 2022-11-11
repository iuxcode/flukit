import 'package:flukit/src/utils/flu_utils.dart';

extension FluDouble on double {
  /// A number format for compact representations, e.g. "1.2M" instead of "1,200,000".
  String get toCompact => Flu.numberToCompactFormat(toDouble());
}
