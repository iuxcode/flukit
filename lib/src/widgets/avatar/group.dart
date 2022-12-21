import 'package:flutter/material.dart';

import 'index.dart';

/// Creates a group of stacked avatar, linear array of `FluAvatar` that are created on demand.
/// TODO: Build avatar group.
class FluAvatarGroup extends StatelessWidget {
  const FluAvatarGroup({
    super.key,
    required this.itemCount,
    this.itemBuilder,
    this.visibleCount,
  });

  final int itemCount;
  final FluAvatar Function(int index)? itemBuilder;
  final int? visibleCount;

  List<Widget> _buildAvatars() {
    List<Widget> avatars = [];

    for (var i = 0; i < itemCount; i++) {
      avatars
          .add(itemBuilder?.call(i) ?? const FluAvatar(memojiAsDefault: true));
    }

    return avatars;
  }

  @override
  Widget build(BuildContext context) {
    late final List<Widget> avatars;
    late final int visibleCount;

    /// TODO: Review
    if (this.visibleCount != null && this.visibleCount! >= itemCount) {
      visibleCount =
          ((itemCount % 2) == 0 ? itemCount / 2 : (itemCount - 1) / 2).round();
    } else {
      visibleCount = 2;
    }

    avatars = _buildAvatars().getRange(0, visibleCount).toList();

    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        ...avatars.map((avatar) {
          final int index = avatars.indexOf(avatar);
          final double leftPos = index * ((avatar as FluAvatar).size * .85);

          return Positioned(left: leftPos, child: avatar);
        }).toList(),
        Positioned(
          left: avatars.length * (avatars.last as FluAvatar).size,
          child: FluAvatar(
            text: '+${itemCount - visibleCount}',
          ),
        ),
      ],
    );
  }
}
