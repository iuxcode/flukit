import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

class FluTabScreenPage {
  String name;
  Widget content;
  FluIconModel icon;
  FluIconModel? filledIcon;

  FluTabScreenPage({
    required this.name,
    required this.icon,
    this.filledIcon,
    required this.content,
  });
}