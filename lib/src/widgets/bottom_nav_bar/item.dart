import 'package:flukit_icons/flukit_icons.dart';

class FluBottomNavBarItem {
  final FluIcons icon;
  final FluIcons? activeIcon;
  final String label;

  FluBottomNavBarItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });
}
