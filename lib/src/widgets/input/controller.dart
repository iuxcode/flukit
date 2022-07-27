import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'replacements.dart';

/// The toggle buttons that can be selected.
enum FluInputStyleToggleButtons {
  bold,
  italic,
  underline,
}

/// Signature for the callback that updates text editing delta history when a new delta
/// is received.
typedef TextEditingDeltaHistoryUpdateCallback = void Function(
    List<TextEditingDelta> textEditingDeltas);

/// Signature for the callback that updates toggle button state when the user changes the selection
/// (including the cursor location).
typedef UpdateInputStyleButtonStateCallback = void Function(
    TextSelection selection);

/// Signature for the callback that updates toggle button state when the user
/// presses the toggle button.
typedef ToggleInputStyleButtonCallback = void Function(
    FluInputStyleToggleButtons button);

class FluRichTextFieldController extends GetxController {
  late FluReplacementTextEditingController inputController;
  final String? initialText;

  FluRichTextFieldController({this.initialText}) {
    inputController = FluReplacementTextEditingController(text: initialText);
  }

  final RxSet<FluInputStyleToggleButtons> _activeStyleButtons =
      <FluInputStyleToggleButtons>{}.obs;
  final RxList<TextEditingDelta> _textEditingDeltaHistory =
      <TextEditingDelta>[].obs;

  String get inputText => inputController.text;
  Set<FluInputStyleToggleButtons> get activeStyleButtons =>
      _activeStyleButtons.value;
  List<TextEditingDelta> get textEditingDeltaHistory =>
      _textEditingDeltaHistory.value;

  set inputText(String value) => inputController.text = value;
  set activeStyleButtons(Set<FluInputStyleToggleButtons> buttons) =>
      _activeStyleButtons.value = buttons;
  set textEditingDeltaHistory(List<TextEditingDelta> deltas) =>
      _textEditingDeltaHistory.value = deltas;

  void updateStyleButtonsState(TextSelection selection) {
    // When the selection changes we want to check the replacements at the new
    // selection. Enable/disable toggle buttons based on the replacements found
    // at the new selection.
    final List<TextStyle> replacementStyles =
        inputController.getReplacementsAtSelection(selection);
    final Set<FluInputStyleToggleButtons> hasChanged = {};

    if (replacementStyles.isEmpty) {
      activeStyleButtons = activeStyleButtons
        ..removeAll({
          FluInputStyleToggleButtons.bold,
          FluInputStyleToggleButtons.italic,
          FluInputStyleToggleButtons.underline
        });
    }

    for (final TextStyle style in replacementStyles) {
      // See [_updateToggleButtonsStateOnButtonPressed] for how
      // Bold, Italic and Underline are encoded into [style]
      if (style.fontWeight != null &&
          !hasChanged.contains(FluInputStyleToggleButtons.bold)) {
        activeStyleButtons = activeStyleButtons
          ..add(FluInputStyleToggleButtons.bold);
        hasChanged.add(FluInputStyleToggleButtons.bold);
      }

      if (style.fontStyle != null &&
          !hasChanged.contains(FluInputStyleToggleButtons.italic)) {
        activeStyleButtons = activeStyleButtons
          ..add(FluInputStyleToggleButtons.italic);
        hasChanged.add(FluInputStyleToggleButtons.italic);
      }

      if (style.decoration != null &&
          !hasChanged.contains(FluInputStyleToggleButtons.underline)) {
        activeStyleButtons = activeStyleButtons
          ..add(FluInputStyleToggleButtons.underline);
        hasChanged.add(FluInputStyleToggleButtons.underline);
      }
    }

    for (final TextStyle style in replacementStyles) {
      if (style.fontWeight == null &&
          !hasChanged.contains(FluInputStyleToggleButtons.bold)) {
        activeStyleButtons = activeStyleButtons
          ..remove(FluInputStyleToggleButtons.bold);
        hasChanged.add(FluInputStyleToggleButtons.bold);
      }

      if (style.fontStyle == null &&
          !hasChanged.contains(FluInputStyleToggleButtons.italic)) {
        activeStyleButtons = activeStyleButtons
          ..remove(FluInputStyleToggleButtons.italic);
        hasChanged.add(FluInputStyleToggleButtons.italic);
      }

      if (style.decoration == null &&
          !hasChanged.contains(FluInputStyleToggleButtons.underline)) {
        activeStyleButtons = activeStyleButtons
          ..remove(FluInputStyleToggleButtons.underline);
        hasChanged.add(FluInputStyleToggleButtons.underline);
      }
    }

    update();
  }

  void toggleStyleButton(FluInputStyleToggleButtons targetButton) {
    Map<FluInputStyleToggleButtons, TextStyle> attributeMap =
        const <FluInputStyleToggleButtons, TextStyle>{
      FluInputStyleToggleButtons.bold: TextStyle(fontWeight: FontWeight.bold),
      FluInputStyleToggleButtons.italic: TextStyle(fontStyle: FontStyle.italic),
      FluInputStyleToggleButtons.underline:
          TextStyle(decoration: TextDecoration.underline),
    };

    final TextRange replacementRange = TextRange(
      start: inputController.selection.start,
      end: inputController.selection.end,
    );

    if (activeStyleButtons.contains(targetButton)) {
      activeStyleButtons = activeStyleButtons..remove(targetButton);
    } else {
      activeStyleButtons = activeStyleButtons..add(targetButton);
    }

    if (activeStyleButtons.contains(targetButton)) {
      inputController.applyReplacement(
        FluTextEditingInlineSpanReplacement(
          replacementRange,
          (string, range) =>
              TextSpan(text: string, style: attributeMap[targetButton]),
          true,
        ),
      );
    } else {
      inputController.disableExpand(attributeMap[targetButton]!);
      inputController.removeReplacementsAtRange(
          replacementRange, attributeMap[targetButton]);
    }

    update();
  }
}
