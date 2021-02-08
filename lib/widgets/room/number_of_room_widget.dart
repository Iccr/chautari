import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:intl/intl.dart';

class NumberOfRoomWidget extends StatelessWidget {
  final FocusNode focusNode;
  final Function(num value) onSaved;
  final ValueKey numberOfroomKey;
  final double initialVaue;

  const NumberOfRoomWidget({
    Key key,
    @required this.focusNode,
    @required this.onSaved,
    @required this.numberOfroomKey,
    this.initialVaue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderTouchSpin(
          key: numberOfroomKey,
          textStyle: ChautariTextStyles().withBigText,
          focusNode: focusNode,
          addIcon: Icon(
            Icons.add,
            color: ChautariColors.whiteAndBlackcolor().withOpacity(0.5),
          ),
          subtractIcon: Icon(
            Icons.remove,
            color: ChautariColors.whiteAndBlackcolor().withOpacity(0.5),
          ),
          name: "noOfROoms",
          min: 1,
          max: 20,
          initialValue: initialVaue,
          displayFormat: NumberFormat("##"),
          decoration: ChautariDecoration().outlinedBorderTextField(
              labelText: "Number of rooms",
              helperText: "Available number of rooms to rent"),
          onSaved: (newValue) => onSaved(newValue)),
    );
  }
}
