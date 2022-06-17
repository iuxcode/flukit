import 'package:flukit/src/configs/theme/tweaks.dart';
import 'package:flukit/src/utils/flu_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'outline.dart';

class FluStaggeredGridViewBuilder extends StatefulWidget {
  final String? title;
  final double spacing, itemRadius, itemHeight, itemStrokewidth;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final void Function(int) onItemTap;
  final List<Widget> suffixItems;
  final BoxShadow? itemBoxShadow;

  const FluStaggeredGridViewBuilder({
    Key? key,
    this.title,
    this.spacing = 10,
    this.itemRadius = 0,
    this.itemHeight = 250,
    required this.onItemTap,
    required this.itemCount,
    required this.itemBuilder,
    this.suffixItems = const [],
    this.itemBoxShadow,
    this.itemStrokewidth = 1
  }) : super(key: key);

  @override
  State<FluStaggeredGridViewBuilder> createState() => _FluStaggeredGridViewBuilderState();
}

class _FluStaggeredGridViewBuilderState extends State<FluStaggeredGridViewBuilder> {
  List<Widget> buildItems(BuildContext context) {
    List<Widget> items = [];

    for (var i = 0; i < widget.itemCount; i++) {
      items.add(GestureDetector(
        onTap: () => widget.onItemTap(i),
        child: FluOutline(
          strokeWidth: widget.itemStrokewidth,
          radius: widget.itemRadius + 2,
          boxShadow: widget.itemBoxShadow ?? Flukit.boxShadow(
            opacity: .1
          ),
          child: FluStaggeredGridViewBuilderBox(
            height: widget.itemHeight,
            radius: widget.itemRadius,
            padding: const EdgeInsets.all(2),
            child: widget.itemBuilder(context, i),
          )
        ),
      ));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) => StaggeredGrid.count(
    crossAxisCount: 2,
    mainAxisSpacing: widget.spacing,
    crossAxisSpacing: widget.spacing,
    children: <Widget>[
      if(widget.title != null) Hero(
        tag: '<StaggeredGridViewTitle>',
        child: FluStaggeredGridViewBuilderBox(
          height: null,
          margin: EdgeInsets.only(bottom: widget.spacing),
          shadow: const [],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 3,
                width: 45,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Flukit.theme.primaryColor
                ),
              ),
              Text(widget.title!, style: Flukit.textTheme.bodyText1!.copyWith(
                fontWeight: Flukit.appConsts.textLight
              )),
            ],
          )
        ),
      )
    ] +  buildItems(context) + widget.suffixItems
  );
}

class FluStaggeredGridViewBuilderBox extends StatelessWidget {
  final double? height;
  final double radius;
  final List<BoxShadow>? shadow;
  final EdgeInsets? margin, padding;
  final Widget child;

  const FluStaggeredGridViewBuilderBox({Key? key, this.height = 250, this.radius = 0, this.shadow, this.margin, this.padding, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    height: height,
    width: double.infinity,
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: Flukit.theme.backgroundColor,
      borderRadius: BorderRadius.circular(radius + 2),
      boxShadow: shadow ?? [Flukit.boxShadow(
        opacity: .035,
        color: Flukit.theme.primaryColor
      )]
    ),
    child: child,
  );
}
