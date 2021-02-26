import 'package:chautari/model/water.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class RoomWaterRadioWidgets extends StatelessWidget {
  final FocusNode focusNode;
  final Function(dynamic value) onSaved;
  final List<FormBuilderFieldOption<dynamic>> options;
  final Water initialiValue;
  final Function(dynamic value) onChanged;
  final ValueKey waterKey;
  const RoomWaterRadioWidgets(
      {Key key,
      @required this.focusNode,
      @required this.onSaved,
      @required this.options,
      @required this.waterKey,
      this.initialiValue,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderRadioGroup(
        initialValue: initialiValue,
        key: waterKey,
        focusNode: focusNode,
        wrapSpacing: Get.width,
        validator: (value) {
          return value == null ? "This field cannot be empty" : null;
        },
        decoration: ChautariDecoration().outlinedBorderTextField(
          labelText: "Water",
          helperText: "Select one options",
        ),
        name: "water",
        options: options,
        onSaved: (newValue) => onSaved(newValue),
        onChanged: (value) {
          if (onChanged != null) {
            onChanged(value);
          }
        },
      ),
    );
  }
}
