import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

enum FluGridType {
  normal,
  masonry,
}

/// Use [flutter_staggered_grid_view] to create scrollable,
/// 2D array of widgets with a fixed number of tiles in the cross axis.
class FluGrid extends StatelessWidget {
  const FluGrid({
    super.key,
    this.type = FluGridType.masonry,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
    this.children = const [],
    this.itemCount,
    this.itemBuilder,
    this.shrinkWrap = true,
    this.reverse = false,
    this.physics = const NeverScrollableScrollPhysics(),
  });

  final Widget Function(BuildContext, int)? itemBuilder;
  final List<Widget> children;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final int? itemCount;
  final double mainAxisSpacing;
  final ScrollPhysics physics;
  final bool reverse;
  final bool shrinkWrap;

  /// Grid type. Define a layout for the grid.
  /// It can be [normal], [masonry] or [Staggered]
  final FluGridType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case FluGridType.normal:
        return StaggeredGrid.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          children: children,
        );
      case FluGridType.masonry:
        assert(itemCount != null && itemBuilder != null,
            'itemCount and itemBuilder can\'t be null when you are building a masonry grid.');

        return MasonryGridView.count(
          shrinkWrap: shrinkWrap,
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          physics: physics,
          itemCount: itemCount,
          itemBuilder: itemBuilder!,
          reverse: reverse,
        );
    }
  }
}
