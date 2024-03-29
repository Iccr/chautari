import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      // final f = NumberFormat("##,##,###");
      // final number =
      //     int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      // final newString = f.format(number);
      final newString =
          NepaliRupeeFormatter().getDecoratedString(newValue.text);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}

class NepaliRupeeFormatter {
  String getDecoratedString(String text) {
    final f = NumberFormat("##,##,###");
    final number = int.parse(text.replaceAll(f.symbols.GROUP_SEP, ''));
    final newString = f.format(number);
    return newString;
  }
}
