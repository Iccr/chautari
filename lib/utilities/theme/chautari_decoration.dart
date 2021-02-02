import 'package:chautari/utilities/theme/colors.dart';
import 'package:flutter/material.dart';

class ChautariDecoration {
  BoxShadow get standardBoxShadow => BoxShadow(
      color: ChautariColors.whiteAndBlackcolor().withOpacity(0.24),
      offset: Offset(0.0, 1), //(x,y)
      blurRadius: 1,
      spreadRadius: 0.5);
}
