import 'package:flukit/widgets/badge.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

import '../flukit.dart';
import 'image.dart';

class FluAvatar extends StatefulWidget {
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
    this.badge = false,
    this.badgeSize = 8,
    this.badgeCountLimit = 99,
    this.badgeCount,
    this.badgeOffset = const Offset(0, 0),
    this.badgePosition = BadgePosition.topLeft,
    this.badgeColor,
    this.badgeOutlineColor,
    this.badgeForegroundColor,
    this.badgeOutlined = false,
    this.badgeOutlineThickness = 2,
    this.margin = EdgeInsets.zero,
    this.outlined = false,
    this.outlineColor,
    this.outlineThickness = 2,
    this.package,
  });

  /// Set to true if you want to display a badge
  final bool badge;

  /// Badge color
  final Color? badgeColor;

  /// Badge count
  final int? badgeCount;

  /// Badge count limit
  final int badgeCountLimit;

  /// Badge foreground color
  final Color? badgeForegroundColor;

  /// Badge position x, y coordinates
  final Offset badgeOffset;

  /// Badge outline color
  final Color? badgeOutlineColor;

  /// Badge thickness
  final double badgeOutlineThickness;

  /// Is the badge outlined
  final bool badgeOutlined;

  /// Badge position
  final BadgePosition badgePosition;

  /// Badge size
  final double badgeSize;

  /// If non-null, the corners of this box are rounded by this [BorderRadius].
  final BorderRadius? borderRadius;

  /// Set to true, if you want the avatar to be a circle
  final bool circle;

  /// Round all avatar corner with the value defined.
  final double cornerRadius;

  /// Default avatars types
  final FluAvatarTypes defaultAvatarType;

  /// Display icon instead of label or image.
  final FluIcons? icon;

  /// Avatar image like a user profile photo.
  final String? image;

  /// Image source.
  /// Can be from `asset`, `network` or `system`.
  final ImageSources imageSource;

  /// Text to display when there is not an image.
  final String? label;

  /// Empty space to surround the avatar and [child].
  final EdgeInsets margin;

  /// Outline color
  final Color? outlineColor;

  /// Outline thickness
  final double outlineThickness;

  /// set to true to enable outline
  final bool outlined;

  /// The package argument must be non-null when displaying an image from a package and null otherwise.
  /// See the Assets in packages section for details.
  final String? package;

  /// Avatar size.
  final double size;

  @override
  State<FluAvatar> createState() => _FluAvatarState();
}

class _FluAvatarState extends State<FluAvatar> {
  late String defaultAvatar;

  @override
  void initState() {
    defaultAvatar = Flu.getAvatar(type: widget.defaultAvatarType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    bool circle =
        widget.circle || widget.defaultAvatarType == FluAvatarTypes.material3D;
    BoxShape shape = circle ? BoxShape.circle : BoxShape.rectangle;
    BorderRadius? borderRadius = !circle
        ? (widget.borderRadius ?? BorderRadius.circular(widget.cornerRadius))
        : null;
    Offset defaultBadgeOffset =
        circle ? const Offset(5, 5) : const Offset(0, 0);
    String image = widget.image ?? defaultAvatar;
    Widget child;

    if ((widget.label != null || widget.icon != null) && widget.image == null) {
      child = Container(
        height: widget.size,
        width: widget.size,
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          shape: shape,
          borderRadius: borderRadius,
        ),
        child: widget.label != null
            ? Text(
                Flu.textToAvatarFormat(widget.label ?? 'Flukit').toUpperCase(),
                style: TextStyle(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold))
            : FluIcon(
                widget.icon!,
                size: 20,
                strokewidth: 1.8,
                color: colorScheme.onPrimaryContainer,
              ),
      );
    } else {
      final mustLoadDefaultAvatar = widget.image != image;

      child = FluImage(
        image,
        imageSource:
            mustLoadDefaultAvatar ? ImageSources.asset : widget.imageSource,
        package: mustLoadDefaultAvatar ? 'flukit' : widget.package,
        circle: circle,
        cornerRadius: widget.cornerRadius,
        height: widget.size,
        square: true,
      );
    }

    if (widget.badge) {
      child = FluBadge(
        color: widget.badgeColor,
        foregroundColor: widget.badgeForegroundColor,
        size: widget.badgeSize,
        offset: widget.badgeOffset != const Offset(0, 0)
            ? widget.badgeOffset
            : defaultBadgeOffset,
        position: widget.badgePosition,
        count: widget.badgeCount,
        countLimit: widget.badgeCountLimit,
        outlined: widget.badgeOutlined,
        outlineThickness: widget.badgeOutlineThickness,
        outlineColor: widget.badgeOutlineColor,
        child: child,
      );
    }

    if (widget.margin != EdgeInsets.zero || widget.outlined) {
      child = Container(
        margin: widget.margin,
        decoration: BoxDecoration(
          shape: shape,
          borderRadius: borderRadius,
          border: widget.outlined
              ? Border.all(
                  width: widget.outlineThickness,
                  color: widget.outlineColor ?? colorScheme.primaryContainer,
                )
              : null,
        ),
        child: child,
      );
    }

    return child;
  }
}
