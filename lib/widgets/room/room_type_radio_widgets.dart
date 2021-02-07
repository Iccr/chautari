import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class RoomTypesRadioWidget extends StatelessWidget {
  const RoomTypesRadioWidget({
    Key key,
    @required this.controller,
    @required this.typesKey,
  }) : super(key: key);

  final AddRoomController controller;
  final ValueKey typesKey;

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderRadioGroup(
          focusNode: controller.focusNodes.typeFocusNode,
          key: typesKey,
          wrapSpacing: Get.width,
          validator: (value) {
            return value == null ? "This field cannot be empty" : null;
          },
          decoration: ChautariDecoration().outlinedBorderTextField(
            labelText: "Type",
            helperText: "Select one options",
          ),
          name: "Type",
          options: controller.appInfo.types
              .map(
                (element) => FormBuilderFieldOption(
                  value: element,
                  child: Text(element.name.capitalize),
                ),
              )
              .toList(),
          onSaved: (newValue) {
            print(newValue);
            controller.apiModel.type = newValue;
          }),
    );
  }
}
