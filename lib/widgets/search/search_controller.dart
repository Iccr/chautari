import 'package:chautari/model/app_info.dart';
import 'package:chautari/model/districts.dart';
import 'package:chautari/model/menu_item.dart';
import 'package:chautari/utilities/constants.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final AppinfoModel appinfo = Get.find(tag: AppConstant.appinfomodelsKey);
  var _districts = List<MenuItem>().obs;

  MenuItem selectedDistrict;

  List<MenuItem> get districtViewModel => _districts.value;

  @override
  void onInit() {
    super.onInit();
    var districts = appinfo.districts.map(
      (e) => MenuItem(title: e.name, subtitle: "province: ${e.state}"),
    );

    this._districts.assignAll(districts);
  }

  Districts onSelectedDistrict(MenuItem item) {
    var district = appinfo.districts.firstWhere(
      (element) => element.name.toLowerCase() == item.title.toLowerCase(),
    );

    return district;
  }
}
