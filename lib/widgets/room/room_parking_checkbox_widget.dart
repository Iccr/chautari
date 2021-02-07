import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class RoomParkingCheckBoxWidget extends StatelessWidget {
  const RoomParkingCheckBoxWidget({
    Key key,
    @required this.controller,
    @required this.parkingKey,
  }) : super(key: key);

  final AddRoomController controller;
  final ValueKey parkingKey;

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderCheckboxGroup(
        focusNode: controller.focusNodes.parkingFocusNode,
        key: parkingKey,
        validator: (value) {
          return value == null ? "This field cannot be empty" : null;
        },
        decoration: ChautariDecoration().outlinedBorderTextField(
          labelText: "parkings",
          helperText: "Select all availabe options",
        ),
        name: "parking",
        options: controller.appInfo.parkings
            .map(
              (element) => FormBuilderFieldOption(
                value: element,
                child: Text(element.name.capitalize),
              ),
            )
            .toList(),
        onChanged: (value) {
          print("parking value $value");
        },
        onSaved: (newValue) {
          print(newValue);
          controller.apiModel.parkings = newValue;
        },
      ),
    );
  }
}
