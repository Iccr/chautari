import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class RoomAmenityCheckBoxWidget extends StatelessWidget {
  const RoomAmenityCheckBoxWidget({
    Key key,
    @required this.controller,
    @required this.amenityKey,
  }) : super(key: key);

  final AddRoomController controller;
  final ValueKey amenityKey;

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderCheckboxGroup(
          focusNode: controller.focusNodes.amenitiesFocusNode,
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
          options: controller.appInfo.amenities
              .map(
                (element) => FormBuilderFieldOption(
                  value: element,
                  child: Text(element.name.capitalize),
                ),
              )
              .toList(),
          onSaved: (newValue) {
            print(newValue);
            controller.apiModel.amenities = newValue;
          }),
    );
  }
}
