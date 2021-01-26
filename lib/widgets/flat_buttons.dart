import 'package:chautari/model/menu_item.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:flutter/material.dart';

class ChautariWidget {
  static FlatButton getFlatButton(Widget child, Function onPressed) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: ChautariColors.blackAndWhitecolor(),
      onPressed: () async {
        onPressed();
      },
      child: child,
    );
  }

  static Widget getListTile(Function tap, MenuItem item) {
    List<Widget> _getContent() {
      return (item.subtitle == null)
          ? [
              Text(
                item.title,
                style: ChautariTextStyles().listTitle,
              ),
            ]
          : [
              Text(
                item.title,
                style: ChautariTextStyles().listTitle,
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                item.subtitle ?? "",
                style: ChautariTextStyles().listSubtitle,
              ),
            ];
    }

    return GestureDetector(
      onTap: () => {tap()},
      child: Container(
        padding: EdgeInsets.only(left: ChautariPadding.standard),
        height: 60,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _getContent(),
          ),
        ),
      ),
    );
  }
}
