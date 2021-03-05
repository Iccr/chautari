import 'package:chautari/widgets/room/room_type_radio_widgets.dart';
import 'package:chautari/widgets/room/room_water_radio_widgets.dart';
import 'package:flutter/material.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
    return VisibilityDetector(
      key: GlobalKey(),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction == 1.0) {
          controller.setupPager(3);
        }
      },
      child: SingleChildScrollView(
        child: FormBuilder(
          key: formkey,
          autovalidateMode: controller.autovalidateForm3Mode.value,
          child: Column(
            children: [
              // types
              RoomTypesRadioWidget(
                typesKey: controller.formKeys.typesKey,
                focusNode: controller.focusNodes.typeFocusNode,
                options: controller.appInfoService.appInfo.types
                    .map(
                      (element) => FormBuilderFieldOption(
                        value: element,
                        child: Text(element.name.capitalizeFirst),
                      ),
                    )
                    .toList(),
                onSaved: (value) => controller.apiModel.type = value,
                onChanged: (value) => controller.apiModel.type = value,
              ),

              // water
              RoomWaterRadioWidgets(
                waterKey: waterKey,
                focusNode: controller.focusNodes.waterFocusNode,
                options: controller.appInfoService.appInfo.waters
                    .map(
                      (element) => FormBuilderFieldOption(
                        value: element,
                        child: Text(element.name.capitalizeFirst),
                      ),
                    )
                    .toList(),
                onSaved: (value) => controller.apiModel.water = value,
                onChanged: (value) => controller.apiModel.water = value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
