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
    "type": -1,
    "number_of_room_lower": 1,
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

  search() {
    var query = Map<String, dynamic>();
    if (params["type"] != -1) {
      query["type"] = params["type"];
    }
    query["number_of_room_lower"] = params["number_of_room_lower"];
    if (!params["district_name"].isEmpty) {
      query["district_name"] = params["district_name"];
    }
    if (!params["water"].isEmpty) {
      query["water"] = params["districwatert_name"];
    }

    if (!params["price_lower"].isEmpty) {
      query["price_lower"] = params["price_lower"];
    }

    if (!params["price_upper"].isEmpty) {
      query["price_upper"] = params["price_upper"];
    }

    roomService.search(query);
  }
}
