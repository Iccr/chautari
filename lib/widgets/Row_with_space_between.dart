import 'package:chautari/utilities/theme/padding.dart';
import 'package:flutter/material.dart';

class RowSpaceBetween extends StatelessWidget {
  const RowSpaceBetween({
    Key key,
    @required this.keyValue,
    this.valueStyle,
    @required this.value,
  }) : super(key: key);

  final valueStyle;
  final String keyValue;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(keyValue),
            Spacer(),
            Spacer(),
            Text(
              value,
              textAlign: TextAlign.left,
              style: valueStyle,
            ),
          ],
        ),
        SizedBox(
          height: ChautariPadding.standard,
        )
      ],
    );
  }
}
