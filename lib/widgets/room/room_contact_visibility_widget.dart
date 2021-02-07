import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ContactNumberVisibilityWidget extends StatelessWidget {
  const ContactNumberVisibilityWidget({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final AddRoomController controller;

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderSwitch(
        initialValue: controller.contactNumberVisible.value,
        focusNode: controller.focusNodes.contactSwitchFocusNode,
        name: "contact number",
        title: Text(
          "Let people contact you via phone",
          style: ChautariTextStyles().listSubtitle,
        ),
        onChanged: (value) {
          print(value);
          controller.setContactNumbervisibility(value);
        },
        decoration: ChautariDecoration().outlinedBorderTextField(),
      ),
    );
  }
}
