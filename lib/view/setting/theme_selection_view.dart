import 'package:chautari/model/menu_item.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/view/setting/setting_controller.dart';
import 'package:chautari/widgets/chautari_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingController controller = Get.find();
    _setTheme(MenuItem item) {
      controller.setTheme(item);
    }

    return Material(
      child: Container(
        padding: EdgeInsets.only(
          top: ChautariPadding.standard,
          left: ChautariPadding.standard,
        ),
        height: 200,
        color: ChautariColors.primaryColor(),
        child: ListView.separated(
          separatorBuilder: (context, index) => ChautariList().getSeperator(
              beginColor: ChautariColors.white,
              endColor: ChautariColors.primary),
          itemCount: controller.themes.length,
          itemBuilder: (context, index) {
            var item = controller.themes.elementAt(index);
            return ChautariList().getListTile(
              () => _setTheme(item),
              item,
              trailing: (item?.selected ?? false)
                  ? IconButton(
                      icon: Icon(
                        Icons.check,
                        size: 20,
                        color: ChautariColors.whiteAndBlackcolor(),
                      ),
                      onPressed: null,
                    )
                  : null,
            );
          },
        ),
      ),
    );
  }
}
