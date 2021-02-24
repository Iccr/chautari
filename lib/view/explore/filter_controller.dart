import 'package:chautari/model/districts.dart';
import 'package:chautari/model/type.dart';
import 'package:chautari/model/water.dart';
import 'package:chautari/services/appinfo_service.dart';
import 'package:chautari/services/room_service.dart';

import 'package:chautari/view/room/form_keys.dart';
import 'package:chautari/view/room/room_form_focusnode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchViewModel extends GetxController {
  RoomType type;
  double noOfRoom = 1;
  Districts district;
  String address;
  Water water;
  String priceLower;
  String priceUpper;

  RxInt totalFilter = 1.obs;

  setType(RoomType type) {
    this.type = type;
    setTotalFilterCount();
  }

  setWater(Water water) {
    this.water = water;
  }

  setNoOfRoom(double number) {
    this.noOfRoom = number;
    setTotalFilterCount();
  }

  setDistrictName(Districts name) {
    this.district = name;
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
      query["type"] = this.type.value;
    }
    query["number_of_room_lower"] = noOfRoom;

    if (district != null) {
      query["district_name"] = district.name;
    }

    if (address != null && address.isNotEmpty) {
      query["address"] = address;
    }

    if (water != null) {
      query["water"] = water.value;
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
