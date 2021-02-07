import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/widgets/room/Room_Image_widget.dart';
import 'package:chautari/widgets/room/number_of_room_widget.dart';
import 'package:chautari/widgets/room/room_contact_number_widget.dart';
import 'package:chautari/widgets/room/room_contact_visibility_widget.dart';
import 'package:chautari/widgets/room/room_price_widget.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import 'package:keyboard_actions/keyboard_actions.dart';

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
      () => KeyboardActions(
        disableScroll: false,
        overscroll: 50,
        config: controller.keyboardActionConfig(context),
        child: FormBuilder(
          key: formkey,
          autovalidateMode: controller.autovalidateForm2Mode.value,
          child: Column(
            children: [
              // number of rooms
              NumberOfRoomWidget(controller: controller),

              // price
              RoomPriceWidget(pricekey: pricekey, controller: controller),

              // mobile visibility
              ContactNumberVisibilityWidget(controller: controller),

              // contact number
              if (controller.contactNumberVisible.value) ...[
                ContactNumberWidget(
                    contactKey: contactKey, controller: controller)
              ],

              // image
              RoomImageWidget(
                  controller: controller, scrollController: scrollController),
            ],
          ),
        ),
      ),
    );
  }
}
