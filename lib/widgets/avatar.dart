import 'package:flutter/material.dart';

import '../flukit.dart';
import '../utils/helpers/ui.dart';
import 'image.dart';

class FluAvatar extends StatelessWidget {
  const FluAvatar({
    super.key,
    this.image,
    this.label,
    this.imageSource = ImageSources.network,
    this.defaultAvatarType = FluAvatarTypes.material3D,
    this.circle = false,
    this.size = 45,
    this.cornerRadius = 18,
    this.borderRadius,
    this.illustrationsAsDefault = true,
  });

  /// Avatar image like a user profile photo.
  final String? image;

  /// Text to display when there is not an image.
  final String? label;

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

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    String image = this.image ?? Flu.getAvatar(type: defaultAvatarType);
    Widget child;

    if (label != null && this.image == null && !illustrationsAsDefault) {
      child = Container(
        height: size,
        width: size,
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colorScheme.primary,
          shape: circle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: !circle
              ? (borderRadius ?? BorderRadius.circular(cornerRadius))
              : null,
        ),
        child: Text(label ?? 'Flukit'),
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

    return child;
  }
}
