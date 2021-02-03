import 'package:flutter/material.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class AddRoomForm3 extends StatelessWidget {
  final AddRoomController controller = Get.find();
  final ValueKey typesKey;
  final ValueKey waterKey;

  AddRoomForm3({@required this.typesKey, @required this.waterKey});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // types
        TopDownPaddingWrapper(
          child: FormBuilderRadioGroup(
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
              options: controller.types
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
        ),

        // water
        TopDownPaddingWrapper(
          child: FormBuilderRadioGroup(
              key: waterKey,
              wrapSpacing: Get.width,
              validator: (value) {
                return value == null ? "This field cannot be empty" : null;
              },
              decoration: ChautariDecoration().outlinedBorderTextField(
                labelText: "Water",
                helperText: "Select one options",
              ),
              name: "water",
              options: controller.waters
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
        ),
      ],
    );
  }
}
