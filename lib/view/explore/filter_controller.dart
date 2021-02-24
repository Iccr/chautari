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
  var noOfRoom = 1.0.obs;
  Districts district;
  String address;
  Water water;
  String priceLower;
  String priceUpper;

  var totalFilterCount = 0.obs;

  setType(RoomType type) {
    this.type = type;
    setTotalFilterCount();
  }

  reset() {
    this.type = null;
    this.setNoOfRoom(1.0);
    this.district = null;
    this.address = null;
    this.water = null;
    this.priceLower = null;
    this.priceUpper = null;
    setTotalFilterCount();
    this.update();
  }

  setWater(Water water) {
    this.water = water;
  }

  setNoOfRoom(double number) {
    this.noOfRoom.value = number;
    setTotalFilterCount();
    this.update();
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

    if (district != null) {
      count++;
    }

    if (address != null && address.isNotEmpty) {
      count++;
    }

    if (water != null) {
      count++;
    }
    if (priceLower != null && priceLower.isNotEmpty) {
      count++;
    }

    if (priceUpper != null && priceUpper.isNotEmpty) {
      count++;
    }
    this.totalFilterCount.value = count;
  }

  getQuery() {
    var query = Map<String, dynamic>();
    if (type != null) {
      query["type"] = this.type.value;
    }

    query["number_of_room_lower"] = noOfRoom.toInt();

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
  var searchModel = SearchViewModel().obs;

  var updateNewImages = false.obs;
  var object = false.obs;

  @override
  void onInit() {
    super.onInit();
    roomService = Get.find();
    try {
      searchModel.value = Get.find();
    } catch (e) {
      searchModel.value = Get.put(SearchViewModel());
    }
    if (searchModel.value.district != null) {
      districtTextController.text =
          "${searchModel.value.district.name}, ${searchModel.value.district.state}";
    }
  }

  search() {
    var query = searchModel.value.getQuery();
    roomService.search(query);
    Get.back();
  }

  reset() {
    this.districtTextController.text = "";
    this.addressTextController.text = "";

    searchModel.value.reset();
  }
}
