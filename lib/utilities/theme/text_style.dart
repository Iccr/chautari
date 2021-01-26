import 'package:chautari/utilities/theme/colors.dart';
import 'package:flutter/material.dart';

class ChautariTextStyles {
  TextStyle listTitle = TextStyle(
    fontWeight: FontWeight.w600,
    color: ChautariColors.whiteAndBlackcolor(),
  );
  TextStyle listSubtitle = TextStyle(
    fontWeight: FontWeight.w500,
    color: ChautariColors.whiteAndBlackcolor().withOpacity(0.8),
  );

  TextStyle search = TextStyle(
    fontWeight: FontWeight.w600,
    color: ChautariColors.white.withOpacity(.6),
  );
}
//   TextStyle(
//             fontSize: 15.0,
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.w500,
//             color: ChautariColors.white.withOpacity(0.9))
// }
