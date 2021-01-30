import 'dart:io';

import 'package:chautari/model/app_info.dart';
import 'package:chautari/model/menu_item.dart';
import 'package:chautari/utilities/constants.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class CreateRoomApiRequestModel {
  int district;
  String address;
  double lat;
  double long;
  String price;
  int noofROom;
  List<Parking> parking;
  List<Amenities> amenities;
  bool available = true;
  String water;
  List<File> images;
}

class AddPropertyController extends GetxController {
  final AppinfoModel appInfo = Get.find(tag: AppConstant.appinfomodelsKey);

  final CreateRoomApiRequestModel apiModel = CreateRoomApiRequestModel();

  var isValid = false;

  // observers
  var addressError = "".obs;
  var _lat = 1000.0.obs;
  var _long = 1000.0.obs;
  // observable keys
  var _formKey = GlobalKey<FormBuilderState>().obs;
  var districtViewmodels = List<MenuItem>().obs;
  var _autovalidateMode = AutovalidateMode.disabled.obs;

// getters
  GlobalKey<FormBuilderState> get formKey => _formKey.value;
  List<Districts> get _districts => appInfo.districts;
  List<Water> get waters => appInfo.waters;
  List<Amenities> get amenities => appInfo.amenities;
  List<Parking> get parkings => appInfo.parkings;
  AutovalidateMode get autovalidateMode => _autovalidateMode.value;

  double get lat => _lat.value == 1000.0 ? null : _lat.value;
  double get long => _long.value == 1000.0 ? null : _long.value;

  // properties

  final TextEditingController districtTextController = TextEditingController();
  final TextEditingController addressTextController = TextEditingController();
  //focus

  FocusNode districtFocusNode;
  FocusNode addressFocusNode;
  FocusNode priceFocusNode;

// items
  var listItems = [
    MenuItem(title: "District"),
    MenuItem(title: "Address/map"),
    MenuItem(title: "Parkings"),
    MenuItem(title: "amenities"),
    MenuItem(title: "water"),
    MenuItem(title: "number of rooms"),
    MenuItem(title: "preferences"),
    MenuItem(title: "images")
  ];

  // life cycles

  @override
  void onInit() {
    super.onInit();

    districtFocusNode = FocusNode();
    addressFocusNode = FocusNode();
    priceFocusNode = FocusNode();

    districtViewmodels.assignAll(
      _districts.map(
        (e) => MenuItem(title: e.name, subtitle: "${e.state}"),
      ),
    );
  }

  @override
  onClose() {
    super.onClose();
    // districtFocusNode.dispose();
    // addressFocusNode.dispose();
    // priceFocusNode.dispose();
  }

// setters

  setLatLng(double lat, double long) {
    _lat.value = lat;
    _long.value = long;
    apiModel.lat = lat;
    apiModel.long = long;
    addressFocusNode.requestFocus();
  }

// functions
  submit() {
    _autovalidateMode.value = AutovalidateMode.always;
    formKey.currentState.save();
    if (formKey.currentState.validate()) {
      // TODo:- api call

    } else {
      var firstWidget = formKey.currentState.fields.entries.firstWhere(
        (element) => element.value.hasError,
      );
      Scrollable.ensureVisible(firstWidget.value.context);
    }
  }

  openMap() async {
    if (lat == null && long == null) {
      addressFocusNode.unfocus();
      await Get.toNamed(RouteName.map);
    }
  }

  validateAddress() {}
}
