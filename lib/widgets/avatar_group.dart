import 'package:flutter/material.dart';
import '../flukit.dart';
import 'avatar.dart';

/// Creates a group of stacked avatar, linear array of `FluAvatar` that are created on demand.
/// TODO: Build avatar group.
class FluAvatarGroup extends StatelessWidget {
  const FluAvatarGroup({
    super.key,
    required this.itemCount,
    this.visibleItemCount = 5,
    this.overlapSize = .65,
    this.itemBuilder,
    this.layout = FluAvatarGroupLayout.overlap,
    this.onTap,
  }) : assert(visibleItemCount <= itemCount);

  final int itemCount;
  final int visibleItemCount;
  final FluAvatar Function(int index)? itemBuilder;
  final double overlapSize;
  final FluAvatarGroupLayout layout;
  final void Function(int index)? onTap;

  double _getAvatarLeftPosition(int index, double size) =>
      index * (size * overlapSize);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    double avatarSize = 0.0;
    List<Widget> avatars = [];

    for (var i = 0; i < visibleItemCount; i++) {
      final FluAvatar avatar = itemBuilder?.call(i) ??
          FluAvatar(
            key: ObjectKey(i),
            outlined: true,
            outlineColor: colorScheme.background,
          );
      avatars.add(Positioned(
          left: _getAvatarLeftPosition(i, avatar.size),
          child: _buildAvatar(i, avatar)));

      if (avatarSize == 0) avatarSize = avatar.size;
    }

    return SizedBox(
      height: avatarSize,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        fit: StackFit.expand,
        children: [
          ...avatars,
          if ((itemCount - visibleItemCount) > 0)
            Positioned(
              left: _getAvatarLeftPosition(avatars.length, avatarSize),
              child: _buildAvatar(
                -1,
                FluAvatar(
                    label: '+ ${itemCount - visibleItemCount}',
                    size: avatarSize),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAvatar(int index, Widget child) => GestureDetector(
        onTap: () => onTap?.call(index),
        child: child,
      );
}

enum FluAvatarGroupLayout { overlap, triangle, square }
