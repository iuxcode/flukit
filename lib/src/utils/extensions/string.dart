import 'package:flukit/flukit.dart';

extension FluString on String {
  String toAvatarFormat() => Flu.textToAvatarFormat(this);
}
