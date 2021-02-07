import 'package:chautari/widgets/room/room_amenity_checkbox_widget.dart';
import 'package:chautari/widgets/room/room_parking_checkbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';
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
        key: controller.formKeys.form4Key,
        autovalidateMode: controller.autovalidateForm4Mode.value,
        child: Column(
          children: [
            RoomParkingCheckBoxWidget(
                controller: controller, parkingKey: parkingKey),

            // amenity
            RoomAmenityCheckBoxWidget(
                controller: controller, amenityKey: amenityKey),
          ],
        ),
      ),
    );
  }
}
