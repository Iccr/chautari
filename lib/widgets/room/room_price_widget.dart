import 'package:chautari/utilities/NepaliRupeeTextFormatter.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';

import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RoomPriceWidget extends StatelessWidget {
  final FocusNode focusNode;

  final ValueKey pricekey;
  final Function(String value) onSaved;
  final Function onTap;
  final String price;
  final String initialValue;
  final String labelText;
  final String helperText;

  const RoomPriceWidget({
    Key key,
    @required this.pricekey,
    @required this.focusNode,
    @required this.onSaved,
    @required this.onTap,
    this.initialValue,
    this.labelText = "Price",
    this.helperText = "price per month",
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderTextField(
          initialValue: initialValue,
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
          focusNode: focusNode,
          name: "price",
          onTap: () => onTap(),
          decoration: ChautariDecoration().outlinedBorderTextField(
            prefix: Text("Rs. "),
            labelText: labelText,
            helperText: this.helperText,
          ),
          onSaved: (newValue) => onSaved(newValue)),
    );
  }
}
