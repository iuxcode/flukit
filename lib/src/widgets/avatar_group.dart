import 'package:flutter/material.dart';
import '../utils.dart';
import 'avatar.dart';

/// Creates a group of stacked avatar
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

  final FluAvatar Function(int index)? itemBuilder;
  final void Function(int index)? onTap;
  final int itemCount;
  final FluAvatarGroupLayout layout;
  final double overlapSize;
  final int visibleItemCount;

  double _getAvatarLeftPosition(int index, double size) =>
      index * (size * overlapSize);

  Widget _buildAvatar(int index, Widget child) => GestureDetector(
        onTap: () => onTap?.call(index),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    double avatarSize = 0.0;
    List<Widget> avatars = [];

    for (var i = 0; i < visibleItemCount; i++) {
      final FluAvatar avatar = itemBuilder?.call(i) ??
          FluAvatar(
            key: ObjectKey(i),
            outlined: true,
            outlineColor: [context.colorScheme.background],
          );
      avatars.add(Positioned(
          left: _getAvatarLeftPosition(i, avatar.size),
          child: _buildAvatar(i, avatar)));

      if (avatarSize == 0) {
        avatarSize =
            avatar.size + (avatar.outlined ? avatar.outlineThickness : 0);
      }
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
}

enum FluAvatarGroupLayout { overlap, triangle, square }
