import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class RoomWaterRadioWidgets extends StatelessWidget {
  const RoomWaterRadioWidgets({
    Key key,
    @required this.waterKey,
    @required this.controller,
  }) : super(key: key);

  final ValueKey waterKey;
  final AddRoomController controller;

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderRadioGroup(
          key: waterKey,
          focusNode: controller.focusNodes.waterFocusNode,
          wrapSpacing: Get.width,
          validator: (value) {
            return value == null ? "This field cannot be empty" : null;
          },
          decoration: ChautariDecoration().outlinedBorderTextField(
            labelText: "Water",
            helperText: "Select one options",
          ),
          name: "water",
          options: controller.appInfo.waters
              .map(
                (element) => FormBuilderFieldOption(
                  value: element,
                  child: Text(element.name.capitalize),
                ),
              )
              .toList(),
          onSaved: (newValue) {
            print(newValue);
            controller.apiModel.water = newValue;
          }),
    );
  }
}
