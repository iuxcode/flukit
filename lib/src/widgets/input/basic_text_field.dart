import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../utils/flu_utils.dart';
import 'input.dart';

/// A basic text field. Defines the appearance of a basic text input client.
class FluBasicTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextStyle textStyle;
  final FluTextInputStyle style;
  final FocusNode focusNode;

  const FluBasicTextField({
    super.key,
    required this.controller,
    required this.style,
    required this.textStyle,
    required this.focusNode,
  });

  @override
  State<FluBasicTextField> createState() => _FluBasicTextFieldState();
}

class _FluBasicTextFieldState extends State<FluBasicTextField> {
  final GlobalKey<FluBasicTextInputClientState> textInputClientKey =
      GlobalKey<FluBasicTextInputClientState>();
  FluBasicTextInputClientState? get _textInputClient =>
      textInputClientKey.currentState;
  RenderEditable get _renderEditable => _textInputClient!.renderEditable;

  // For text selection gestures.
  // The viewport offset pixels of the [RenderEditable] at the last drag start.
  double _dragStartViewportOffset = 0.0;
  late DragStartDetails _startDetails;

  // For text selection.
  TextSelectionControls? _textSelectionControls;
  bool _showSelectionHandles = false;

  bool _shouldShowSelectionHandles(SelectionChangedCause? cause) {
    // When the text field is activated by something that doesn't trigger the
    // selection overlay, we shouldn't show the handles either.
    if (cause == SelectionChangedCause.keyboard) {
      return false;
    }

    if (cause == SelectionChangedCause.longPress ||
        cause == SelectionChangedCause.scribble) {
      return true;
    }

    if (widget.controller.text.isNotEmpty) {
      return true;
    }

    return false;
  }

  void _handleSelectionChanged(
      TextSelection selection, SelectionChangedCause? cause) {
    final bool willShowSelectionHandles = _shouldShowSelectionHandles(cause);
    if (willShowSelectionHandles != _showSelectionHandles) {
      setState(() {
        _showSelectionHandles = willShowSelectionHandles;
      });
    }
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final Offset startOffset = _renderEditable.maxLines == 1
        ? Offset(_renderEditable.offset.pixels - _dragStartViewportOffset, 0.0)
        : Offset(0.0, _renderEditable.offset.pixels - _dragStartViewportOffset);

    _renderEditable.selectPositionAt(
      from: _startDetails.globalPosition - startOffset,
      to: details.globalPosition,
      cause: SelectionChangedCause.drag,
    );
  }

  void _onDragStart(DragStartDetails details) {
    _startDetails = details;
    _dragStartViewportOffset = _renderEditable.offset.pixels;
  }

  @override
  Widget build(BuildContext context) {
    switch (Theme.of(this.context).platform) {
      case TargetPlatform.iOS:
        _textSelectionControls = cupertinoTextSelectionControls;
        break;
      case TargetPlatform.macOS:
        _textSelectionControls = cupertinoDesktopTextSelectionControls;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        _textSelectionControls = materialTextSelectionControls;
        break;
      case TargetPlatform.linux:
        _textSelectionControls = desktopTextSelectionControls;
        break;
      case TargetPlatform.windows:
        _textSelectionControls = desktopTextSelectionControls;
        break;
    }

    return FocusTrapArea(
      focusNode: widget.focusNode,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: (dragStartDetails) => _onDragStart(dragStartDetails),
        onPanUpdate: (dragUpdateDetails) => _onDragUpdate(dragUpdateDetails),
        onTap: () {
          _textInputClient!.requestKeyboard();
        },
        onTapDown: (tapDownDetails) {
          _renderEditable.handleTapDown(tapDownDetails);
          _renderEditable.selectPosition(cause: SelectionChangedCause.tap);
        },
        onLongPressMoveUpdate: (longPressMoveUpdateDetails) {
          switch (Theme.of(this.context).platform) {
            case TargetPlatform.iOS:
            case TargetPlatform.macOS:
              _renderEditable.selectPositionAt(
                from: longPressMoveUpdateDetails.globalPosition,
                cause: SelectionChangedCause.longPress,
              );
              break;
            case TargetPlatform.android:
            case TargetPlatform.fuchsia:
            case TargetPlatform.linux:
            case TargetPlatform.windows:
              _renderEditable.selectWordsInRange(
                from: longPressMoveUpdateDetails.globalPosition -
                    longPressMoveUpdateDetails.offsetFromOrigin,
                to: longPressMoveUpdateDetails.globalPosition,
                cause: SelectionChangedCause.longPress,
              );
              break;
          }
        },
        onLongPressEnd: (longPressEndDetails) =>
            _textInputClient!.showToolbar(),
        onHorizontalDragStart: (dragStartDetails) =>
            _onDragStart(dragStartDetails),
        onHorizontalDragUpdate: (dragUpdateDetails) =>
            _onDragUpdate(dragUpdateDetails),
        child: SizedBox(
          // height: widget.style.height,
          // width: MediaQuery.of(context).size.width,
          child: FluBasicTextInputClient(
            key: textInputClientKey,
            controller: widget.controller,
            style: widget.textStyle,
            focusNode: widget.focusNode,
            selectionControls: _textSelectionControls,
            onSelectionChanged: _handleSelectionChanged,
            showSelectionHandles: _showSelectionHandles,
          ),
        ),
      ),
    );
  }
}
