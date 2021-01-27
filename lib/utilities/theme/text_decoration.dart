import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:flutter/material.dart';

class ChautariDecoration {
  InputDecoration outlinedBorderTextField(
      {String hintText,
      String helperText,
      String labelText,
      String errorText}) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ChautariColors.primary.withOpacity(0.5), width: 5.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ChautariColors.whiteAndBlackcolor().withOpacity(0.5)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ChautariColors.red.withOpacity(0.5),
        ),
      ),
      helperStyle: ChautariTextStyles().listSubtitle,
      hintText: hintText,
      helperText: helperText,
      labelText: labelText,
      errorText: errorText,
    );
  }
}
