import 'package:chautari/services/appinfo_service.dart';
import 'package:chautari/services/room_service.dart';

import 'package:chautari/view/room/form_keys.dart';
import 'package:chautari/view/room/room_form_focusnode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchViewModel extends GetxController {
  int type;
  int noOfRoom = 1;
  String districtName;
  String address;
  String water;
  String priceLower;
  String priceUpper;

  RxInt totalFilter = 1.obs;

  setType(int type) {
    this.type = type;
    setTotalFilterCount();
  }

  setWater(String water) {
    this.water = water;
  }

  setNoOfRoom(int number) {
    this.noOfRoom = number;
    setTotalFilterCount();
  }

  setDistrictName(String name) {
    this.districtName = name;
    setTotalFilterCount();
  }

  setAddress(String address) {
    this.address = address;
    setTotalFilterCount();
  }

  setPriceLower(String lower) {
    this.priceLower = lower;
    setTotalFilterCount();
  }

  setPriceUpper(String upper) {
    this.priceUpper = upper;
    setTotalFilterCount();
  }

  setTotalFilterCount() {
    int count = 0;
    if (type != null) {
      count++;
    }
    if (noOfRoom != 1) {
      count++;
    }

    if (districtName != null && districtName.isNotEmpty) {
      count++;
    }

    if (address != null && address.isNotEmpty) {
      count++;
    }

    if (water != null && water.isNotEmpty) {
      count++;
    }
    if (priceLower != null && priceLower.isNotEmpty) {
      count++;
    }

    if (priceUpper != null && priceUpper.isNotEmpty) {
      count++;
    }
    this.totalFilter.value = count;
  }

  getQuery() {
    var query = Map<String, dynamic>();
    if (type != null) {
      query["type"] = type;
    }
    query["number_of_room_lower"] = noOfRoom;

    if (districtName != null && districtName.isNotEmpty) {
      query["district_name"] = districtName;
    }

    if (address != null && address.isNotEmpty) {
      query["address"] = address;
    }

    if (water != null && water.isNotEmpty) {
      query["water"] = water;
    }

    if (priceLower != null && priceLower.isNotEmpty) {
      query["price_lower"] = priceLower;
    }

    if (priceUpper != null && priceUpper.isNotEmpty) {
      query["price_upper"] = priceUpper;
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
