import 'package:chautari/utilities/theme/padding.dart';
import 'package:flutter/material.dart';

class TopDownPaddingWrapper extends StatelessWidget {
  final bool shouldHideTopPadding;
  final bool shouldHideBottomPadding;
  Widget child;
  TopDownPaddingWrapper(
      {this.child,
      this.shouldHideTopPadding = false,
      this.shouldHideBottomPadding = false});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (shouldHideTopPadding) ...[SizedBox(height: ChautariPadding.standard)],
      child,
      SizedBox(height: ChautariPadding.standard),
    ]);
  }
}
