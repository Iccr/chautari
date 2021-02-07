import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/view/room/my_rooms/my_room.dart';
import 'package:chautari/widgets/room/Room_Image_widget.dart';
import 'package:chautari/widgets/room/number_of_room_widget.dart';
import 'package:chautari/widgets/room/room_amenity_checkbox_widget.dart';
import 'package:chautari/widgets/room/room_contact_number_widget.dart';
import 'package:chautari/widgets/room/room_contact_visibility_widget.dart';
import 'package:chautari/widgets/room/room_parking_checkbox_widget.dart';
import 'package:chautari/widgets/room/room_price_widget.dart';
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                NumberOfRoomWidget(controller: controller),

                // price
                RoomPriceWidget(
                    pricekey: controller.formKeys.priceKey,
                    controller: controller),

                // mobile visibility
                ContactNumberVisibilityWidget(controller: controller),

                // contact number
                if (controller.contactNumberVisible.value) ...[
                  ContactNumberWidget(
                      contactKey: controller.formKeys.contactKey,
                      controller: controller)
                ],

                // image
                RoomImageWidget(
                    controller: controller,
                    scrollController: _scrollController),

                RoomParkingCheckBoxWidget(
                    controller: controller,
                    parkingKey: controller.formKeys.parkingKey),

                // amenity
                RoomAmenityCheckBoxWidget(
                    controller: controller,
                    amenityKey: controller.formKeys.amenityKey),

                SizedBox(
                  height: ChautariPadding.standard * 5,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 0,
            left: 0,
            child: ChautariRaisedButton(
              title: "Update ",
              onPressed: () => print("update"),
            ),
          ),
        ],
      ),
    );
  }
}
