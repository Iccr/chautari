import 'package:chautari/utilities/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class KeyboardAction {
  KeyboardActionsConfig keyboardActionConfig(
      BuildContext context, List<FocusNode> focusNodes) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: ChautariColors.black.withOpacity(0.3),
      nextFocus: false,
      actions:
          focusNodes.map((e) => KeyboardActionsItem(focusNode: e)).toList(),
    );
  }
}
