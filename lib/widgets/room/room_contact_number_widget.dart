import 'package:chautari/utilities/theme/text_decoration.dart';

import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ContactNumberWidget extends StatelessWidget {
  const ContactNumberWidget({
    Key key,
    @required this.contactKey,
    @required this.controller,
  }) : super(key: key);

  final ValueKey contactKey;
  final AddRoomController controller;

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderTextField(
        key: contactKey,

        validator: (value) {
          if (value == null) {
            return "This field cannot be empty";
          } else
            return null;
        },
        // inputFormatters: [NumericTextFormatter()],
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        focusNode: controller.focusNodes.contactTextFocusNode,
        name: "contact",
        onTap: () {
          print("contact tapped");
          controller.focusNodes.contactTextFocusNode.requestFocus();
        },
        decoration: ChautariDecoration().outlinedBorderTextField(
            prefix: Text("+977-"),
            labelText: "Contact Number",
            helperText: "If vissible people can call to this number"),

        onSaved: (newValue) {
          controller.apiModel.contactNumber = newValue;
        },
      ),
    );
  }
}
