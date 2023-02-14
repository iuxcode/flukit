import 'package:flutter/material.dart';

extension FluDouble on num {
  /// add vertical space between widgets
  Widget get ph => SizedBox(height: toDouble());

  /// add horizontal space between widgets
  Widget get pw => SizedBox(width: toDouble());
}
