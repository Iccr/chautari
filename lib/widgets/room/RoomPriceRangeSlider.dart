import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RoomPriceRangeSliderWidget extends StatelessWidget {
  final FocusNode focusNode;

  final ValueKey priceRangekey;

  final Function(RangeValues value) onSaved;
  final Function onTap;
  final RangeValues initialValue;
  final double min;
  final double max;

  const RoomPriceRangeSliderWidget({
    Key key,
    @required this.priceRangekey,
    @required this.focusNode,
    @required this.onSaved,
    @required this.onTap,
    @required this.min,
    @required this.max,
    this.initialValue,
    // this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderRangeSlider(
          min: min,
          max: max,
          initialValue: initialValue,
          key: priceRangekey,
          // validator: (value) {},
          focusNode: focusNode,
          name: "price",
          onChanged: (value) => onTap(),
          decoration: ChautariDecoration().outlinedBorderTextField(
              prefix: Text("Rs. "),
              labelText: "Price",
              helperText: "Price per month"),
          onSaved: (newValue) => onSaved(newValue)),
    );
  }
}
