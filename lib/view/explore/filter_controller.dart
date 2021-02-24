import 'package:chautari/services/appinfo_service.dart';
import 'package:chautari/services/room_service.dart';

import 'package:chautari/view/room/form_keys.dart';
import 'package:chautari/view/room/room_form_focusnode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterRoomController extends GetxController {
  RoomFormKeys formKeys = RoomFormKeys();
  RoomFocusNodes focusNodes = RoomFocusNodes();
  AppInfoService appInfoService = Get.find();

  RoomService roomService;

  final TextEditingController districtTextController = TextEditingController();
  final TextEditingController addressTextController = TextEditingController();

  RxMap<String, dynamic> params = {
    "type": "",
    "number_of_room_lower": "",
    "district_name": "",
    "water": "",
    "price_lower": "",
    "price_upper": ""
  }.obs;

  var updateNewImages = false.obs;

  @override
  void onInit() {
    super.onInit();
    roomService = Get.find();
  }
}
