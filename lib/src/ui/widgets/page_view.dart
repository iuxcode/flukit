import 'package:flutter/material.dart';

/// A scrollable list that works page by page.
/// Todo: Complete documentation
class PageViewNotifier extends StatefulWidget {
  const PageViewNotifier({
    required this.notifier,
    required this.child,
    required this.controller,
    super.key,
  });

  final ValueNotifier<double> notifier;
  final PageController? controller;
  final Widget child;

  @override
  State<PageViewNotifier> createState() => _PageViewNotifierState();
}

class _PageViewNotifierState extends State<PageViewNotifier> {
  late final PageController controller;
  late int previousPage;

  void _onScroll() {
    if (controller.page != null) {
      if (controller.page!.toInt() == controller.page) {
        previousPage = controller.page!.toInt();
      }
      widget.notifier.value = controller.page! - previousPage;
    }
  }

  @override
  void initState() {
    controller = widget.controller ?? PageController()
      ..addListener(_onScroll);
    previousPage = controller.initialPage;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
