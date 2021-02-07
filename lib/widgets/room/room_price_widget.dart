import 'package:chautari/utilities/NepaliRupeeTextFormatter.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';

import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RoomPriceWidget extends StatelessWidget {
  const RoomPriceWidget({
    Key key,
    @required this.pricekey,
    @required this.controller,
  }) : super(key: key);

  final ValueKey pricekey;
  final AddRoomController controller;

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderTextField(
        key: pricekey,
        validator: (value) {
          if (value == null) {
            return "This field cannot be empty";
          } else if (int.parse(
                  value.isEmpty ? "0" : value.replaceAll(",", "")) <
              100) {
            return "value must be greater than 100";
          } else {
            return null;
          }
        },
        inputFormatters: [NumericTextFormatter()],
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        focusNode: controller.focusNodes.priceFocusNode,
        name: "price",
        onTap: () {
          print("price tapped");
          controller.focusNodes.priceFocusNode.requestFocus();
        },
        decoration: ChautariDecoration().outlinedBorderTextField(
            prefix: Text("Rs. "),
            labelText: "Price",
            helperText: "price per month"),
        onSaved: (newValue) {
          print(newValue);
          controller.apiModel.price = newValue.replaceAll(",", "");
        },
      ),
    );
  }
}
