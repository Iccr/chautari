import 'package:chautari/utilities/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Alert extends StatelessWidget {
  static show({
    @required String message,
    String title = "Alert",
    String textConfirm = "ok",
    String textCancel = "cancel",
    Function onConfirm,
    Function onCancel,
    Color confirmTextColor,
  }) {
    Get.defaultDialog(
      title: title,
      middleText:
          "your will not be able to get notification and other services",
      textConfirm: textConfirm,
      textCancel: textCancel,
      confirmTextColor: confirmTextColor ?? ChautariColors.blackAndWhitecolor(),
      onConfirm: () => onConfirm() ?? Get.back,
      onCancel: () => onCancel() ?? Get.back(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
