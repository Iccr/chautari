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
  double noOfRoom = 1.0;
  Districts district;
  String address;
  Water water;
  String priceLower;
  String priceUpper;

  // initial value
  RoomType initialType;
  double intitialNoOfRoom = 1.0;
  Districts initialDistrict;
  String inititalAddress;
  Water initialWater;
  String initialPriceLower;
  String intialPriceUpper;

  RoomFormKeys formKeys = RoomFormKeys();

  var totalFilterCount = 0.obs;

  var shouldUpdate = false;

  setType(RoomType type) {
    this.type = type;
    // setTotalFilterCount();
  }

  reset() {
    this.type = null;
    this.noOfRoom = 1.0;
    this.district = null;
    this.address = null;
    this.water = null;
    this.priceLower = null;
    this.priceUpper = null;
    this.shouldUpdate = false;
    // setTotalFilterCount();
  }

  setWater(Water water) {
    this.water = water;
    this.shouldUpdate = true;
  }

  setNoOfRoom(double number) {
    this.noOfRoom = number;
    // setTotalFilterCount();
    this.shouldUpdate = true;
  }

  setDistrictName(Districts name) {
    this.district = name;
    this.shouldUpdate = true;
  }

  setAddress(String address) {
    this.address = address;
    this.shouldUpdate = true;
  }

  setPriceLower(String lower) {
    this.priceLower = lower;
    this.shouldUpdate = true;
  }

  setPriceUpper(String upper) {
    this.priceUpper = upper;
    this.shouldUpdate = true;
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
          "${searchModel.value.district.name}, province: ${searchModel.value.district.state}";
    }
  }

  search() {
    searchModel.value.setTotalFilterCount();
    var query = searchModel.value.getQuery();
    roomService.search(query);
    Get.back();
  }

  reset() async {
    searchModel.value.reset();
    searchModel.value.getQuery();

    // this.addressTextController.text = "";
    // formKeys.formKey.currentState.fields.forEach((key, value) {value.})
    // searchModel.value.formKeys.formKey.currentState
    // .patchValue({"noOfROoms": 1.0});
    searchModel.value.formKeys.formKey.currentState.reset();
    searchModel.value.setTotalFilterCount();
    this.districtTextController.text = "";
    this.addressTextController.text = "";

    print(this.searchModel.value.noOfRoom);

    // await Future.delayed(Duration(milliseconds: 2000));
    this.object.refresh();
  }

  @override
  void onReady() {
    if (searchModel.value.shouldUpdate) {
      print("update");
      // RoomType type;
      // double noOfRoom = 1.0;
      // Districts district;
      // String address;
      // Water water;
      // String priceLower;
      // String priceUpper;
      var state = searchModel.value.formKeys.formKey.currentState;
      state?.fields?.forEach((key, value) {
        print(key);
        state.patchValue({"noOfROoms": searchModel.value.noOfRoom});

        var districtName = "";
        if (searchModel.value.district != null) {
          districtName =
              "${searchModel.value.district.name}, province: ${searchModel.value.district.state}";
        }

        state.patchValue(
          {"district_field": districtName},
        );

        state.patchValue({"price_upper": searchModel.value.priceUpper});
        state.patchValue({"price_lower": searchModel.value.priceLower});
        state.patchValue({"Type": searchModel.value.type});
        state.patchValue({"water": searchModel.value.water});
      });
    }
    super.onReady();
  }
}
