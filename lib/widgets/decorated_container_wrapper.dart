import 'package:chautari/utilities/theme/chautari_decoration.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:flutter/material.dart';

class DecoratedContainerWrapper extends StatelessWidget {
  const DecoratedContainerWrapper({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ChautariPadding.small5),
      decoration: BoxDecoration(
        color: ChautariColors.blackWithOpacityAndWhitecolor(),
        borderRadius: BorderRadius.circular(
          ChautariPadding.small5,
        ),
        boxShadow: [ChautariDecoration().standardBoxShadow],
      ),
      child: child,
    );
  }
}
