import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RoomParkingCheckBoxWidget extends StatelessWidget {
  final FocusNode focusNode;
  final Function(dynamic value) onSaved;
  final ValueKey parkingKey;
  final List<FormBuilderFieldOption<dynamic>> options;
  final List<dynamic> initialValue;
  const RoomParkingCheckBoxWidget(
      {Key key,
      @required this.focusNode,
      @required this.onSaved,
      @required this.parkingKey,
      @required this.options,
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderCheckboxGroup(
        initialValue: initialValue,
        focusNode: focusNode,
        key: parkingKey,
        validator: (value) {
          return value == null ? "This field cannot be empty" : null;
        },
        decoration: ChautariDecoration().outlinedBorderTextField(
          labelText: "parkings",
          helperText: "Select all availabe options",
        ),
        name: "parking",
        options: options,
        onSaved: (newValue) => onSaved(newValue),
      ),
    );
  }
}
