import 'package:chautari/model/app_info.dart';
import 'package:chautari/model/menu_item.dart';
import 'package:chautari/utilities/constants.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:flutter/widgets.dart';

import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class AddPropertyController extends GetxController {
  final AppinfoModel appInfo = Get.find(tag: AppConstant.appinfomodelsKey);

  var isValid = false;
  var address = "".obs;
  var addressError = "".obs;

//focus

  FocusNode districtFocusNode;
  FocusNode addressFocusNode;
  FocusNode priceFocusNode;

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

  List<Districts> get _districts => appInfo.districts;

  List<Water> get waters => appInfo.waters;
  List<Amenities> get amenities => appInfo.amenities;
  List<Parking> get parkings => appInfo.parkings;

  var districtViewmodels = List<MenuItem>().obs;

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
    districtFocusNode.dispose();
    addressFocusNode.dispose();
    priceFocusNode.dispose();
  }

  submit() {}

  openMap() async {
    await Get.toNamed(RouteName.map);
  }

  setAddress(String val) {
    if (val.length > 2) {
      address.value = val;
    } else {
      addressError.value = "Enter valid District";
    }
  }

  validateAddress() {}
}
