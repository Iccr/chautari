import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/view/room/add_room/add_room_fourth_page.dart';
import 'package:chautari/view/room/add_room/add_room_second_page.dart';
import 'package:chautari/view/room/add_room/add_room_third_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateRoom extends StatelessWidget {
  AddRoomController controller = Get.put(AddRoomController());
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update room"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AddRoomForm2(
                formkey: controller.formKeys.form2Key,
                contactKey: controller.formKeys.contactKey,
                pricekey: controller.formKeys.priceKey,
                numberkey: controller.formKeys.numberOfRoomsKey,
                scrollController: _scrollController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AddRoomForm3(
                formkey: controller.formKeys.form3Key,
                typesKey: controller.formKeys.typesKey,
                waterKey: controller.formKeys.waterKey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AddRoomForm4(
                parkingKey: controller.formKeys.parkingKey,
                amenityKey: controller.formKeys.amenityKey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
