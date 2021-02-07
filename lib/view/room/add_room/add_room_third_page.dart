import 'package:chautari/widgets/room/room_type_radio_widgets.dart';
import 'package:chautari/widgets/room/room_water_radio_widgets.dart';
import 'package:flutter/material.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class AddRoomForm3 extends StatelessWidget {
  final AddRoomController controller = Get.find();
  final GlobalKey<FormBuilderState> formkey;
  final ValueKey typesKey;
  final ValueKey waterKey;

  AddRoomForm3(
      {@required this.formkey,
      @required this.typesKey,
      @required this.waterKey});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
        key: formkey,
        autovalidateMode: controller.autovalidateForm3Mode.value,
        child: Column(
          children: [
            // types
            RoomTypesRadioWidget(controller: controller, typesKey: typesKey),

            // water
            RoomWaterRadioWidgets(waterKey: waterKey, controller: controller),
          ],
        ),
      ),
    );
  }
}
