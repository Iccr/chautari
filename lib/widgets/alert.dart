import 'package:chautari/utilities/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Alert {
  static show(
      {@required String message,
      String title = "Info",
      String textConfirm = "ok",
      String textCancel = "cancel",
      Function onConfirm,
      Function onCancel,
      Color confirmTextColor,
      barrierDismissible = true}) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      textConfirm: textConfirm,
      textCancel: textCancel,
      confirmTextColor: confirmTextColor ?? ChautariColors.blackAndWhitecolor(),
      onConfirm: onConfirm == null ? Get.back : onConfirm,
      onCancel: onCancel,
      barrierDismissible: onCancel != null,
    );
  }
}
