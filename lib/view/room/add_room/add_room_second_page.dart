import 'dart:io';

import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/widgets/room/Room_Image_widget.dart';
import 'package:chautari/widgets/room/number_of_room_widget.dart';
import 'package:chautari/widgets/room/room_contact_number_widget.dart';
import 'package:chautari/widgets/room/room_contact_visibility_widget.dart';
import 'package:chautari/widgets/room/room_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AddRoomForm2 extends StatelessWidget {
  final AddRoomController controller = Get.find();
  final GlobalKey<FormBuilderState> formkey;
  final ValueKey contactKey;
  final ValueKey pricekey;
  final ValueKey numberkey;
  final ScrollController scrollController;

  AddRoomForm2({
    @required this.formkey,
    @required this.scrollController,
    @required this.contactKey,
    @required this.pricekey,
    @required this.numberkey,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => VisibilityDetector(
        key: GlobalKey(),
        onVisibilityChanged: (VisibilityInfo info) {
          if (info.visibleFraction == 1.0) {
            controller.setupPager(2);
          }
        },
        child: KeyboardActions(
          disableScroll: false,
          overscroll: 50,
          config: controller.keyboardActionConfig,
          child: FormBuilder(
            key: formkey,
            autovalidateMode: controller.autovalidateForm2Mode.value,
            child: Column(
              children: [
                // number of rooms
                NumberOfRoomWidget(
                  numberOfroomKey: controller.formKeys.numberOfRoomsKey,
                  focusNode: controller.focusNodes.numberOfRoomsFocusNode,
                  onSaved: (value) =>
                      controller.apiModel.numberOfRooms = value.toInt(),
                ),

                // price
                RoomPriceWidget(
                  pricekey: pricekey,
                  focusNode: controller.focusNodes.priceFocusNode,
                  onTap: () =>
                      controller.focusNodes.priceFocusNode.requestFocus(),
                  onSaved: (value) => {
                    controller.apiModel.price = value.replaceAll(",", ""),
                    print(controller.apiModel)
                  },
                ),

                // mobile visibility
                ContactNumberVisibilityWidget(
                  contactVisibilityKey:
                      controller.formKeys.contactVisibilityKey,
                  initialValue: controller.contactNumberVisible.value,
                  focusNode: controller.focusNodes.contactSwitchFocusNode,
                  onChanged: (value) => {
                    controller.apiModel.contactNumbervisibile = value,
                    controller.setContactNumbervisibility(value),
                  },
                ),

                // contact number
                if (controller.contactNumberVisible.value) ...[
                  ContactNumberWidget(
                    contactKey: contactKey,
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
        ),
      ),
    );
  }
}
