import 'package:flutter/widgets.dart';

/// Signature for the callback that updates toggle button state when the user changes the selection
/// (including the cursor location).
typedef UpdateToggleButtonsStateOnSelectionChangedCallback = void Function(
    TextSelection selection);

/// Signature for the callback that updates toggle button state when the user
/// presses the toggle button.
typedef UpdateToggleButtonsStateOnButtonPressedCallback = void Function(
    int index);

/// The toggle buttons that can be selected.
enum FluToggleButtonsState {
  bold,
  italic,
  underline,
}

class FluToggleButtonsStateManager extends InheritedWidget {
  const FluToggleButtonsStateManager({
    super.key,
    required super.child,
    required Set<FluToggleButtonsState> isToggleButtonsSelected,
    required UpdateToggleButtonsStateOnButtonPressedCallback
        updateToggleButtonsStateOnButtonPressed,
    required UpdateToggleButtonsStateOnSelectionChangedCallback
        updateToggleButtonStateOnSelectionChanged,
  })  : _isToggleButtonsSelected = isToggleButtonsSelected,
        _updateToggleButtonsStateOnButtonPressed =
            updateToggleButtonsStateOnButtonPressed,
        _updateToggleButtonStateOnSelectionChanged =
            updateToggleButtonStateOnSelectionChanged;

  static FluToggleButtonsStateManager of(BuildContext context) {
    final FluToggleButtonsStateManager? result = context
        .dependOnInheritedWidgetOfExactType<FluToggleButtonsStateManager>();
    assert(result != null, 'No FluToggleButtonsStateManager found in context');
    return result!;
  }

  final Set<FluToggleButtonsState> _isToggleButtonsSelected;
  final UpdateToggleButtonsStateOnButtonPressedCallback
      _updateToggleButtonsStateOnButtonPressed;
  final UpdateToggleButtonsStateOnSelectionChangedCallback
      _updateToggleButtonStateOnSelectionChanged;

  Set<FluToggleButtonsState> get toggleButtonsState => _isToggleButtonsSelected;
  UpdateToggleButtonsStateOnButtonPressedCallback
      get updateToggleButtonsOnButtonPressed =>
          _updateToggleButtonsStateOnButtonPressed;
  UpdateToggleButtonsStateOnSelectionChangedCallback
      get updateToggleButtonsOnSelection =>
          _updateToggleButtonStateOnSelectionChanged;

  @override
  bool updateShouldNotify(FluToggleButtonsStateManager oldWidget) =>
      toggleButtonsState != oldWidget.toggleButtonsState;
}
