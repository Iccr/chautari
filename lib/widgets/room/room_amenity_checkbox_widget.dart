import 'package:chautari/model/amenity.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class RoomAmenityCheckBoxWidget extends StatelessWidget {
  final FocusNode focusNode;
  final Function(List<Amenities> values) onSaved;
  final List<FormBuilderFieldOption<Amenities>> options;
  final List<Amenities> initialValue;
  final Function(List<Amenities> value) onChanged;
  final ValueKey amenityKey;

  const RoomAmenityCheckBoxWidget({
    Key key,
    @required this.focusNode,
    @required this.amenityKey,
    @required this.onSaved,
    @required this.options,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderCheckboxGroup(
        initialValue: initialValue,
        focusNode: focusNode,
        key: amenityKey,
        validator: (value) {
          return value == null ? "This field cannot be empty" : null;
        },
        wrapAlignment: WrapAlignment.spaceBetween,
        wrapSpacing: Get.width,
        decoration: ChautariDecoration().outlinedBorderTextField(
          labelText: "Amenities",
          helperText: "Select all availabe options",
        ),
        name: "amenity",
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
