import 'package:chautari/utilities/theme/colors.dart';
import 'package:flutter/material.dart';

class ChautariWidget {
  static FlatButton getFlatButton(Widget child, Function onPressed) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: ChautariColors().blackAndWhitecolor(),
      onPressed: () async {
        onPressed();
      },
      child: child,
    );
  }
}
