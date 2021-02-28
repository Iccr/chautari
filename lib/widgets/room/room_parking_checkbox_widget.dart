import 'package:chautari/model/parkings.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RoomParkingCheckBoxWidget extends StatelessWidget {
  final FocusNode focusNode;
  final Function(List<Parking> value) onSaved;
  final ValueKey parkingKey;
  final List<FormBuilderFieldOption<Parking>> options;
  final List<Parking> initialValue;
  final Function(List<Parking> value) onChanged;
  const RoomParkingCheckBoxWidget(
      {Key key,
      @required this.focusNode,
      @required this.onSaved,
      @required this.parkingKey,
      @required this.options,
      this.onChanged,
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderCheckboxGroup<Parking>(
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
        onChanged: (value) {
          if (onChanged != null) {
            onChanged(value);
          }
        },
      ),
    );
  }
}
