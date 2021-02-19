import 'package:chautari/utilities/theme/colors.dart';
import 'package:flutter/material.dart';

class ChautariTextStyles {
  TextStyle listTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ChautariColors.whiteAndBlackcolor(),
  );

  TextStyle highlightedListTitle = TextStyle(
    fontSize: 16,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w600,
    color: ChautariColors.whiteAndBlackcolor(),
  );

  TextStyle normal = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ChautariColors.whiteAndBlackcolor(),
  );

  TextStyle listSubtitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: ChautariColors.whiteAndBlackcolor().withOpacity(0.8),
  );

  TextStyle highlightedlistSubtitle = TextStyle(
    fontSize: 13,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w500,
    color: ChautariColors.whiteAndBlackcolor().withOpacity(0.8),
  );

  TextStyle search = TextStyle(
    fontWeight: FontWeight.w600,
    color: ChautariColors.white.withOpacity(.6),
  );

  TextStyle withBigText = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 24,
    color: ChautariColors.whiteAndBlackcolor().withOpacity(0.8),
  );
}
