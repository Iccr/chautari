import 'dart:io';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/view/room/my_rooms/my_room.dart';
import 'package:chautari/view/room/update_room/update_room_controller.dart';
import 'package:chautari/widgets/room/Room_Image_widget.dart';
import 'package:chautari/widgets/room/number_of_room_widget.dart';
import 'package:chautari/widgets/room/room_amenity_checkbox_widget.dart';
import 'package:chautari/widgets/room/room_contact_number_widget.dart';
import 'package:chautari/widgets/room/room_contact_visibility_widget.dart';
import 'package:chautari/widgets/room/room_parking_checkbox_widget.dart';
import 'package:chautari/widgets/room/room_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class UpdateRoom extends StatelessWidget {
  UpdateRoomController controller = Get.put(UpdateRoomController());
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Update room"),
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(ChautariPadding.standard),
              height: Get.height,
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: [
                      NumberOfRoomWidget(
                        initialVaue: controller.room.numberOfRooms.toDouble(),
                        numberOfroomKey: controller.formKeys.numberOfRoomsKey,
                        focusNode: controller.focusNodes.numberOfRoomsFocusNode,
                        onSaved: (value) =>
                            controller.room.numberOfRooms = value.toInt(),
                      ),

                      // price
                      RoomPriceWidget(
                        initialValue: controller.price,
                        pricekey: controller.formKeys.parkingKey,
                        focusNode: controller.focusNodes.priceFocusNode,
                        onTap: () =>
                            controller.focusNodes.priceFocusNode.requestFocus(),
                        onSaved: (value) =>
                            controller.room.price = value.replaceAll(",", ""),
                      ),

                      // mobile visibility
                      ContactNumberVisibilityWidget(
                        contactVisibilityKey: controller.formKeys.contactKey,
                        initialValue: controller.contactNumberVisible.value,
                        focusNode: controller.focusNodes.contactSwitchFocusNode,
                        onChanged: (value) {
                          controller.room.phone_visibility = value;
                          controller.contactNumberVisible.value = value;
                        },
                      ),

                      // contact number
                      if (controller.contactNumberVisible.value) ...[
                        ContactNumberWidget(
                          initialValue: controller.room.phone,
                          contactKey: controller.formKeys.contactKey,
                          focusNode: controller.focusNodes.contactTextFocusNode,
                          onTap: () => controller
                              .focusNodes.contactTextFocusNode
                              .requestFocus(),
                          onSaved: (value) => controller.room.phone = value,
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
                          onSaved: (value) => controller.room.rawImages =
                              List<File>.from(value),
                          scrollController: scrollController),
                      RoomParkingCheckBoxWidget(
                        initialValue: controller.room.parkings
                            .map(
                              (element) => element,
                            )
                            .toList(),
                        parkingKey: controller.formKeys.parkingKey,
                        focusNode: controller.focusNodes.parkingFocusNode,
                        options: controller.appInfoService.appInfo.parkings
                            .map(
                              (element) => FormBuilderFieldOption(
                                value: element,
                                child: Text(element.name.capitalize),
                              ),
                            )
                            .toList(),
                        onSaved: (value) => controller.room.parkings = value,
                      ),

                      // amenity
                      RoomAmenityCheckBoxWidget(
                        amenityKey: controller.formKeys.amenityKey,
                        focusNode: controller.focusNodes.parkingFocusNode,
                        options: controller.appInfoService.appInfo.amenities
                            .map(
                              (element) => FormBuilderFieldOption(
                                value: element,
                                child: Text(element.name.capitalize),
                              ),
                            )
                            .toList(),
                        onSaved: (value) => controller.room.amenities = value,
                      ),

                      SizedBox(
                        height: ChautariPadding.huge * 3,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  ChautariRaisedButton(
                    title: "Update ",
                    onPressed: () => print("update"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
