import 'package:chautari/model/menu_item.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:flutter/material.dart';

class ChautariList {
  List<MenuItem> items = [];
  final Function tap;
  ChautariList({this.items, this.tap});

  Widget getStandardList(
      {Color seperatorGradientBeginColor, Color seperatorGradientEndColor}) {
    return ListView.separated(
      separatorBuilder: (context, index) => getSeperator(
        beginColor: seperatorGradientBeginColor ?? ChautariColors.white,
        endColor: seperatorGradientEndColor ?? ChautariColors.primary,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item = items.elementAt(index);
        return getListTile(
          () => tap,
          item,
        );
      },
    );
  }

  Widget getSeperator({Color beginColor, Color endColor}) {
    return Container(
      margin: EdgeInsets.only(
        left: ChautariPadding.standard,
        right: ChautariPadding.standard,
      ),
      height: 0.6,
      child: Container(
        decoration: BoxDecoration(
          color: ChautariColors.primaryDarkAndWhite900color().withOpacity(0.5),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                beginColor ?? ChautariColors.whiteAndBlackcolor(),
                endColor ?? ChautariColors.blackAndWhitecolor()
              ]),
        ),
      ),
    );
  }

  Widget getListTile(Function tap, MenuItem item) {
    List<Widget> _getContent() {
      return [
        Text(
          item.title,
          style: ChautariTextStyles().listTitle,
        ),
        if (item.subtitle != null) ...[
          SizedBox(
            height: 2,
          ),
          Text(
            item.subtitle ?? "",
            style: ChautariTextStyles().listSubtitle,
          ),
        ]
      ];
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => {tap()},
      child: Container(
        padding: EdgeInsets.only(left: ChautariPadding.standard),
        height: 60,
        child: Container(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: _getContent(),
              ),
              if (item.selected ?? false) ...[
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.check,
                    size: 20,
                    color: ChautariColors.whiteAndBlackcolor(),
                  ),
                  onPressed: null,
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
