import 'package:flutter/material.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class AddRoomForm4 extends StatelessWidget {
  final AddRoomController controller = Get.find();

  final ValueKey parkingKey;
  final ValueKey amenityKey;

  AddRoomForm4({@required this.parkingKey, @required this.amenityKey});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
        key: controller.form4Key,
        autovalidateMode: controller.autovalidateForm4Mode,
        child: Column(
          children: [
            TopDownPaddingWrapper(
              child: FormBuilderCheckboxGroup(
                key: parkingKey,
                validator: (value) {
                  return value == null ? "This field cannot be empty" : null;
                },
                decoration: ChautariDecoration().outlinedBorderTextField(
                  labelText: "parkings",
                  helperText: "Select all availabe options",
                ),
                name: "parking",
                options: controller.parkings
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
            ),

            // amenity
            TopDownPaddingWrapper(
              child: FormBuilderCheckboxGroup(
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
                  options: controller.amenities
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
            ),
          ],
        ),
      ),
    );
  }
}
