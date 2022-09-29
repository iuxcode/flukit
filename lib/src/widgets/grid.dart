import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

enum FluGridType {
  normal,
  masonry,
}

/// Use [flutter_staggered_grid_view] to create scrollables, 2D array of widgets with a fixed number of tiles in the cross axis.
class FluGrid extends StatelessWidget {
  /// Grid type. Define a layout for the grid.
  /// It can be [normal], [masonry] or [Staggered]
  final FluGridType type;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final List<Widget> children;
  final int? itemCount;
  final Widget Function(BuildContext, int)? itemBuilder;
  final bool shrinkWrap;
  final bool reverse;
  final ScrollPhysics physics;

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
            'itemCount and itemBuilder can\'t be null when you are builing a masonry grid.');

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
