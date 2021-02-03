import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/utilities/theme/text_style.dart';

import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class AddRoomForm1 extends StatelessWidget {
  final AddRoomController controller = Get.find();

  final GlobalKey<FormBuilderState> formKey;

  final ValueKey districtKey;
  final ValueKey addressKey;

  final Function openSearch;
  final Function openMap;
  AddRoomForm1(
      {@required this.formKey,
      @required this.districtKey,
      @required this.addressKey,
      @required this.openSearch,
      @required this.openMap});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: FormBuilder(
          key: formKey,
          autovalidateMode: controller.autovalidateForm1Mode,
          child: Column(
            children: [
              // district
              TopDownPaddingWrapper(
                child: FormBuilderTextField(
                  key: districtKey,
                  validator: FormBuilderValidators.required(context),
                  controller: controller.districtTextController,
                  focusNode: controller.districtFocusNode,
                  name: "district_field",
                  style: ChautariTextStyles().listSubtitle,
                  decoration: ChautariDecoration().outlinedBorderTextField(
                    helperText: "Select District",
                    labelText: "District",
                  ),
                  onTap: () {
                    openSearch();
                  },
                ),
              ),
              // map
              if (controller.lat != null && controller.long != null) ...[
                TopDownPaddingWrapper(
                    shouldHideBottomPadding: true,
                    child: Obx(
                      () => Text(
                        "Latitude: ${controller.lat}, Longitude: ${controller.long}",
                        textAlign: TextAlign.left,
                      ),
                    )),
              ],
              TopDownPaddingWrapper(
                shouldHideBottomPadding: true,
                child: Text.rich(
                  TextSpan(
                    style: ChautariTextStyles().listSubtitle,
                    children: [
                      TextSpan(
                        text: "People will be serching with this address.",
                        style: ChautariTextStyles().listSubtitle.copyWith(
                            color: ChautariColors.whiteAndPrimarycolor()
                                .withOpacity(0.8)),
                      ),
                      TextSpan(
                        text: "Try to make it as accurate as possible",
                        style: ChautariTextStyles().listSubtitle.copyWith(
                            color: ChautariColors.whiteAndPrimarycolor()
                                .withOpacity(0.8)),
                      ),
                    ],
                  ),
                ),
              ),

// address
              TopDownPaddingWrapper(
                shouldHideTopPadding: true,
                child: FormBuilderTextField(
                  key: addressKey,
                  focusNode: controller.addressFocusNode,
                  name: "map_field",
                  onSaved: (newValue) {
                    controller.apiModel.address = newValue;
                  },
                  validator: (value) {
                    return value == null || value.isEmpty
                        ? "This field cannot be empty"
                        : null;
                  },
                  style: ChautariTextStyles().listSubtitle,
                  decoration: ChautariDecoration().outlinedBorderTextField(
                      helperText: "local address name", labelText: "address"),
                  onTap: () => openMap(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
