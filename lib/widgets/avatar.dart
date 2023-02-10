import 'package:flukit/widgets/badge.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

import '../flukit.dart';
import 'image.dart';

class FluAvatar extends StatelessWidget {
  const FluAvatar({
    super.key,
    this.image,
    this.label,
    this.icon,
    this.imageSource = ImageSources.network,
    this.defaultAvatarType = FluAvatarTypes.material3D,
    this.circle = false,
    this.size = 62,
    this.cornerRadius = 24,
    this.borderRadius,
    this.illustrationsAsDefault = true,
    this.badge = false,
    this.badgeSize = 8,
    this.badgeOffset = const Offset(5, 5),
    this.badgePosition = BadgePosition.topLeft,
    this.badgeColor,
    this.badgeForegroundColor,
    this.margin = EdgeInsets.zero,
    this.outlined = false,
    this.outlineColor,
    this.outlineThickness = 2,
  });

  /// Avatar image like a user profile photo.
  final String? image;

  /// Text to display when there is not an image.
  final String? label;

  /// Display icon instead of label or image.
  final FluIcons? icon;

  /// Image source.
  /// Can be from `asset`, `network` or `system`.
  final ImageSources imageSource;

  /// Set to true, if you want the avatar to be a circle
  final bool circle;

  /// Default avatars types
  final FluAvatarTypes defaultAvatarType;

  /// If non-null, the corners of this box are rounded by this [BorderRadius].
  final BorderRadius? borderRadius;

  /// Round all avatar corner with the value defined.
  final double cornerRadius;

  /// Avatar size.
  final double size;

  /// Set to true if you want avatars to be displayed instead of [label] when image is not set.
  final bool illustrationsAsDefault;

  /// Set to true if you want to display a badge
  final bool badge;

  /// Badge color
  final Color? badgeColor;

  /// Badge foreground color
  final Color? badgeForegroundColor;

  /// Badge size
  final double badgeSize;

  /// Badge position x, y coordinates
  final Offset badgeOffset;

  /// Badge positotion
  final BadgePosition badgePosition;

  /// Empty space to surround the avatar and [child].
  final EdgeInsets margin;

  /// set to true to enable outline
  final bool outlined;

  /// Outline color
  final Color? outlineColor;

  /// Outline thickness
  final double outlineThickness;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    String image = this.image ?? Flu.getAvatar(type: defaultAvatarType);
    bool circle = this.circle || defaultAvatarType == FluAvatarTypes.material3D;
    BoxShape shape = circle ? BoxShape.circle : BoxShape.rectangle;
    BorderRadius? borderRadius = !circle
        ? (this.borderRadius ?? BorderRadius.circular(cornerRadius))
        : null;
    Widget child;

    if ((label != null || icon != null) &&
        this.image == null &&
        !illustrationsAsDefault) {
      child = Container(
        height: size,
        width: size,
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          shape: shape,
          borderRadius: borderRadius,
        ),
        child: label != null
            ? Text(Flu.textToAvatarFormat(label ?? 'Flukit'),
                style: TextStyle(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold))
            : FluIcon(
                icon!,
                size: 20,
                color: colorScheme.onPrimaryContainer,
              ),
      );
    } else {
      child = FluImage(
        image,
        imageSource: this.image != null ? imageSource : ImageSources.asset,
        package: 'flukit',
        circle: circle,
        cornerRadius: cornerRadius,
        height: size,
        square: true,
      );
    }

    if (badge) {
      child = FluBadge(
        color: badgeColor,
        foregroundColor: badgeForegroundColor,
        size: badgeSize,
        offset: badgeOffset,
        position: badgePosition,
        child: child,
      );
    }

    if (margin != EdgeInsets.zero || outlined) {
      child = Container(
        margin: margin,
        decoration: BoxDecoration(
          shape: shape,
          borderRadius: borderRadius,
          border: outlined
              ? Border.all(
                  width: outlineThickness,
                  color: outlineColor ?? colorScheme.primaryContainer,
                )
              : null,
        ),
        child: child,
      );
    }

    return child;
  }
}
