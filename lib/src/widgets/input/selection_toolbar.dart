import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef OffsetValue = void Function(int start, int end);

class FluTextSelectionControlsAction {
  final String label;
  final OffsetValue onTap;

  FluTextSelectionControlsAction(this.label, this.onTap);
}

class FluTextSelectionControls extends MaterialTextSelectionControls {
  // Padding between the toolbar and the anchor.
  static const double _kToolbarContentDistanceBelow = 20.0;
  static const double _kToolbarContentDistance = 8.0;

  /// Custom
  final List<FluTextSelectionControlsAction>? customActions;

  FluTextSelectionControls({this.customActions});

  /// Builder for material-style copy/paste text selection toolbar.
  @override
  Widget buildToolbar(
      BuildContext context,
      Rect globalEditableRegion,
      double textLineHeight,
      Offset selectionMidpoint,
      List<TextSelectionPoint> endpoints,
      TextSelectionDelegate delegate,
      ClipboardStatusNotifier? clipboardStatus,
      Offset? lastSecondaryTapDownPosition) {
    final TextSelectionPoint startTextSelectionPoint = endpoints[0];
    final TextSelectionPoint endTextSelectionPoint =
        endpoints.length > 1 ? endpoints[1] : endpoints[0];
    final Offset anchorAbove = Offset(
        globalEditableRegion.left + selectionMidpoint.dx,
        globalEditableRegion.top +
            startTextSelectionPoint.point.dy -
            textLineHeight -
            _kToolbarContentDistance);
    final Offset anchorBelow = Offset(
      globalEditableRegion.left + selectionMidpoint.dx,
      globalEditableRegion.top +
          endTextSelectionPoint.point.dy +
          _kToolbarContentDistanceBelow,
    );

    return FLuTextSelectionToolbar(
      anchorAbove: anchorAbove,
      anchorBelow: anchorBelow,
      clipboardStatus: clipboardStatus,
      handleCopy: canCopy(delegate)
          ? () => handleCopy(delegate, clipboardStatus)
          : null,
      handleCut: canCut(delegate) ? () => handleCut(delegate) : null,
      handlePaste: canPaste(delegate) ? () => handlePaste(delegate) : null,
      handleSelectAll:
          canSelectAll(delegate) ? () => handleSelectAll(delegate) : null,
      customActions: customActions?.map((action) {
            return FluTextSelectionToolbarItemData(
                label: action.label,
                onPressed: () {
                  action.onTap.call(delegate.textEditingValue.selection.start,
                      delegate.textEditingValue.selection.end);
                  /* delegate.textEditingValue = delegate.textEditingValue.copyWith(
          selection: TextSelection.collapsed(
            offset: delegate.textEditingValue.selection.baseOffset,
          ),
        ); */
                  delegate.hideToolbar();
                });
          }).toList() ??
          <FluTextSelectionToolbarItemData>[],
    );
  }
}

class FLuTextSelectionToolbar extends StatefulWidget {
  final Offset anchorAbove;
  final Offset anchorBelow;
  final ClipboardStatusNotifier? clipboardStatus;
  final VoidCallback? handleCopy;
  final VoidCallback? handleCut;
  final VoidCallback? handlePaste;
  final VoidCallback? handleSelectAll;

  /// Custom
  final List<FluTextSelectionToolbarItemData>? customActions;

  const FLuTextSelectionToolbar({
    Key? key,
    required this.anchorAbove,
    required this.anchorBelow,
    this.clipboardStatus,
    this.handleCopy,
    this.handleCut,
    this.handlePaste,
    this.handleSelectAll,

    /// Custom
    this.customActions,
  }) : super(key: key);

  @override
  FluTextSelectionToolbarState createState() => FluTextSelectionToolbarState();
}

class FluTextSelectionToolbarState extends State<FLuTextSelectionToolbar> {
  void _onChangedClipboardStatus() {
    setState(() {
      // Inform the widget that the value of clipboardStatus has changed.
    });
  }

  @override
  void initState() {
    super.initState();
    widget.clipboardStatus?.addListener(_onChangedClipboardStatus);
    widget.clipboardStatus?.update();
  }

  @override
  void didUpdateWidget(FLuTextSelectionToolbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.clipboardStatus != oldWidget.clipboardStatus) {
      widget.clipboardStatus?.addListener(_onChangedClipboardStatus);
      oldWidget.clipboardStatus?.removeListener(_onChangedClipboardStatus);
    }
    widget.clipboardStatus?.update();
  }

  @override
  void dispose() {
    super.dispose();
    if (!(widget.clipboardStatus?.disposed ?? false)) {
      widget.clipboardStatus?.removeListener(_onChangedClipboardStatus);
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    List<FluTextSelectionToolbarItemData> itemDatas =
        <FluTextSelectionToolbarItemData>[
      if (widget.handleCut != null)
        FluTextSelectionToolbarItemData(
          label: localizations.cutButtonLabel,
          onPressed: () => widget.handleCut?.call(),
        ),
      if (widget.handleCopy != null)
        FluTextSelectionToolbarItemData(
          label: localizations.copyButtonLabel,
          onPressed: () => widget.handleCopy?.call(),
        ),
      if (widget.handlePaste != null &&
          widget.clipboardStatus?.value == ClipboardStatus.pasteable)
        FluTextSelectionToolbarItemData(
          label: localizations.pasteButtonLabel,
          onPressed: () => widget.handlePaste?.call(),
        ),
      if (widget.handleSelectAll != null)
        FluTextSelectionToolbarItemData(
          label: localizations.selectAllButtonLabel,
          onPressed: () => widget.handleSelectAll?.call(),
        ),
    ];

    if (widget.customActions != null) itemDatas += widget.customActions!;

    int childIndex = 0;
    return TextSelectionToolbar(
      anchorAbove: widget.anchorAbove,
      anchorBelow: widget.anchorBelow,
      toolbarBuilder: (BuildContext context, Widget child) {
        return Card(child: child);
      },
      children: itemDatas.map((FluTextSelectionToolbarItemData itemData) {
        return TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(
              childIndex++, itemDatas.length),
          onPressed: itemData.onPressed,
          child: Text(itemData.label),
        );
      }).toList(),
    );
  }
}

class FluTextSelectionToolbarItemData {
  const FluTextSelectionToolbarItemData({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;
}
