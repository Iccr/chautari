import 'package:chautari/model/districts.dart';
import 'package:chautari/model/menu_item.dart';
import 'package:chautari/services/appinfo_service.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final AppInfoService appInfoService = Get.find();
  var _districts = <MenuItem>[].obs;

  MenuItem selectedDistrict;

  List<MenuItem> get districtViewModel => _districts.value;

  @override
  void onInit() {
    super.onInit();
    var districts = (appInfoService.appInfo.districts ?? []).map(
      (e) => MenuItem(title: e.name, subtitle: "province: ${e.state}"),
    );

    this._districts.assignAll(districts);
  }

  Districts onSelectedDistrict(MenuItem item) {
    var district = appInfoService.appInfo.districts.firstWhere(
      (element) => element.name.toLowerCase() == item.title.toLowerCase(),
    );

    return district;
  }
}
