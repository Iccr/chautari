import 'dart:io';
import 'package:chautari/view/room/my_rooms/my_room.dart';
import 'package:chautari/view/room/update_room/update_room_controller.dart';
import 'package:chautari/widgets/room/Room_Image_widget.dart';
import 'package:chautari/widgets/room/number_of_room_widget.dart';
import 'package:chautari/widgets/room/room_contact_number_widget.dart';
import 'package:chautari/widgets/room/room_contact_visibility_widget.dart';
import 'package:chautari/widgets/room/room_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateRoom extends StatelessWidget {
  UpdateRoomController controller = Get.put(UpdateRoomController());
  ScrollController scrollController = ScrollController();
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
                NumberOfRoomWidget(
                  numberOfroomKey: controller.formKeys.numberOfRoomsKey,
                  focusNode: controller.focusNodes.numberOfRoomsFocusNode,
                  onSaved: (value) =>
                      controller.apiModel.numberOfRooms = value.toInt(),
                ),

                // price
                RoomPriceWidget(
                  pricekey: controller.formKeys.parkingKey,
                  focusNode: controller.focusNodes.priceFocusNode,
                  onTap: () =>
                      controller.focusNodes.priceFocusNode.requestFocus(),
                  onSaved: (value) =>
                      controller.apiModel.price = value.replaceAll(",", ""),
                ),

                // mobile visibility
                ContactNumberVisibilityWidget(
                  contactVisibilityKey: controller.formKeys.contactKey,
                  initialValue: controller.contactNumberVisible.value,
                  focusNode: controller.focusNodes.contactSwitchFocusNode,
                  onChanged: (value) =>
                      controller.contactNumberVisible.value = value,
                ),

                // contact number
                if (controller.contactNumberVisible.value) ...[
                  ContactNumberWidget(
                    contactKey: controller.formKeys.contactKey,
                    focusNode: controller.focusNodes.contactTextFocusNode,
                    onTap: () => controller.focusNodes.contactTextFocusNode
                        .requestFocus(),
                    onSaved: (value) =>
                        controller.apiModel.contactNumber = value,
                  )
                ],

                // image
                RoomImageWidget(
                    roomImageKey: controller.formKeys.imageKey,
                    focusNode: controller.focusNodes.imageFocusNode,
                    onChange: (value) => scrollController.animateTo(
                        scrollController.position.maxScrollExtent + 130,
                        duration: Duration(milliseconds: 100),
                        curve: Curves.easeInOut),
                    onSaved: (value) =>
                        controller.apiModel.images = List<File>.from(value),
                    scrollController: scrollController),
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
