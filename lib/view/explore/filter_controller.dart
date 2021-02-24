import 'package:chautari/services/appinfo_service.dart';
import 'package:chautari/services/room_service.dart';

import 'package:chautari/view/room/form_keys.dart';
import 'package:chautari/view/room/room_form_focusnode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchViewModel {
  int type;
  int noOfRoom = 1;
  String districtName;
  String address;
  String water;
  String priceLower;
  String priceUpper;

  int totalFilter = 0;

  getQuery() {
    var query = Map<String, dynamic>();
    if (type != null) {
      query["type"] = type;
      totalFilter++;
    }
    query["number_of_room_lower"] = noOfRoom;

    if (districtName != null) {
      query["district_name"] = districtName;
      totalFilter++;
    }

    if (address != null) {
      query["address"] = address;
      totalFilter++;
    }

    if (water != null) {
      query["water"] = water;
      totalFilter++;
    }

    if (priceLower != null) {
      query["price_lower"] = priceLower;
      totalFilter++;
    }

    if (priceUpper != null) {
      query["price_upper"] = priceUpper;
      totalFilter++;
    }
    return query;
  }
}

class FilterRoomController extends GetxController {
  RoomFormKeys formKeys = RoomFormKeys();
  RoomFocusNodes focusNodes = RoomFocusNodes();
  AppInfoService appInfoService = Get.find();

  RoomService roomService;

  final TextEditingController districtTextController = TextEditingController();
  final TextEditingController addressTextController = TextEditingController();

  SearchViewModel searchModel = SearchViewModel();

  // RxMap<String, dynamic> params = {
  //   "type": -1,
  //   "number_of_room_lower": 1,
  //   "district_name": "",
  //   "water": "",
  //   "price_lower": "",
  //   "price_upper": ""
  // }.obs;

  var updateNewImages = false.obs;

  @override
  void onInit() {
    super.onInit();
    roomService = Get.find();
  }

  search() {
    var query = searchModel.getQuery();

    roomService.search(query);
    Get.back();
  }
}
