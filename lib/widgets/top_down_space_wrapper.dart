import 'package:chautari/utilities/theme/padding.dart';
import 'package:flutter/material.dart';

class TopDownPaddingWrapper extends StatelessWidget {
  double top;
  double bottom;
  Widget child;
  TopDownPaddingWrapper({this.child, this.top, this.bottom}) {
    this.top = top ?? ChautariPadding.standard;
    this.bottom = bottom ?? ChautariPadding.small5;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(height: top),
      child,
      SizedBox(height: bottom),
    ]);
  }
}
