import 'package:flukit/src/configs/theme/index.dart';
import 'package:flukit/src/utils/flu_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'input.dart';

/// A basic text field. Defines the appearance of a basic text input client.
class FluBasicTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextStyle textStyle;
  final FluTextInputStyle style;
  final FocusNode focusNode;
  final ValueChanged<String>? onChanged;

  const FluBasicTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.style = const FluTextInputStyle(),
    required this.textStyle,
    required this.focusNode,
    this.onChanged,
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

  FluTheme get theme => Flukit.theme;
  ThemeData get themeData => Flukit.theme.data;

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

  InputDecoration _getEffectiveDecoration() {
    final ThemeData themeData = Theme.of(context);
    final InputDecoration effectiveDecoration = InputDecoration(
      hintText: widget.hintText,
      hintStyle: theme.data.textTheme.bodyText1!.copyWith(
        fontWeight: FontWeight.w400,
        color: widget.style.hintColor ?? theme.palette.text,
      ),
      contentPadding: widget.style.contentPadding,
      border: InputBorder.none,
      filled: true,
      fillColor: widget.style.fillColor ?? theme.palette.accentBackground,
    ).applyDefaults(themeData.inputDecorationTheme);

    return effectiveDecoration;
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

    Widget child = AnimatedBuilder(
      animation:
          Listenable.merge(<Listenable>[widget.focusNode, widget.controller]),
      builder: (BuildContext context, Widget? child) {
        return InputDecorator(
          decoration: _getEffectiveDecoration(),
          baseStyle: widget.textStyle,
          textAlign: widget.style.textAlign,
          textAlignVertical: widget.style.textAlignVertical,
          // isHovering: _isHovering,
          isFocused: widget.focusNode.hasFocus,
          isEmpty: widget.controller.value.text.isEmpty,
          expands: widget.style.expand,
          child: FluBasicTextInputClient(
            key: textInputClientKey,
            controller: widget.controller,
            textStyle: widget.textStyle,
            style: widget.style,
            focusNode: widget.focusNode,
            selectionControls: _textSelectionControls,
            onSelectionChanged: _handleSelectionChanged,
            showSelectionHandles: _showSelectionHandles,
            onChanged: widget.onChanged,
          ),
        );
      },
    );

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
        child: child,
      ),
    );
  }
}
