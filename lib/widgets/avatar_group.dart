import 'package:flutter/material.dart';
import 'avatar.dart';

/// Creates a group of stacked avatar, linear array of `FluAvatar` that are created on demand.
/// TODO: Build avatar group.
class FluAvatarGroup extends StatelessWidget {
  const FluAvatarGroup({
    super.key,
    required this.itemCount,
    this.overlapSize = .65,
    this.itemBuilder,
    this.layout = FluAvatarGroupLayout.normal,
    this.onTap,
  });

  final int itemCount;
  final double overlapSize;
  final FluAvatar Function(int index)? itemBuilder;
  final FluAvatarGroupLayout layout;
  final void Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: LayoutBuilder(builder: (context, constraints) {
        List<Widget> avatars = [];
        double avatarsWidth = 0.0;

        for (var i = 0; i < itemCount; i++) {
          final FluAvatar avatar =
              itemBuilder?.call(i) ?? FluAvatar(key: ObjectKey(i));
          final double leftPos = i * (avatar.size * .65);
          print('$i -> $leftPos | ${avatar.size}');
          avatarsWidth += avatar.size - (avatar.size * overlapSize);
          avatars.add(avatar);
        }

        print('${constraints.maxWidth} | $avatarsWidth');

        return Stack(
          alignment: Alignment.centerLeft,
          fit: StackFit.expand,
          children: [
            ...avatars.map((avatar) {
              final int index = avatars.indexOf(avatar);
              final double leftPos = index * ((avatar as FluAvatar).size * .65);

              return Positioned(
                  left: leftPos, child: _buildAvatar(avatar, index));
            }).toList(),
            /* Positioned(
                left: avatars.length * (avatars.last as FluAvatar).size,
                child: _buildAvatar(
                    FluAvatar(label: '+${itemCount - visibleCount}'), -1),
              ), */
          ],
        );
      }),
    );
  }

  Widget _buildAvatar(Widget child, int index) => GestureDetector(
        onTap: () => onTap?.call(index),
        child: child,
      );
}

enum FluAvatarGroupLayout { normal, grouped }
