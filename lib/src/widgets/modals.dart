import 'package:flutter/material.dart';
import '../../flukit.dart';

class FluModalBottomSheet extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? radius;
  final double defaultRadius =  Flukit.screenSize.width * .085;

  FluModalBottomSheet({
    Key? key,
    required this.child,
    this.padding,
    this.radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: DraggableScrollableSheet(
        maxChildSize: .9,
        builder: (context, scrollController) => Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 4,
              width: Flukit.screenSize.width * .20,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Flukit.theme.backgroundColor.withOpacity(.65),
                borderRadius: BorderRadius.circular(10)
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Container(
                decoration: BoxDecoration(
                  color: Flukit.theme.backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius ?? defaultRadius),
                    topRight: Radius.circular(radius ?? defaultRadius)
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: padding ?? EdgeInsets.all(FluConsts.defaultPaddingSize),
                  child: child
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}