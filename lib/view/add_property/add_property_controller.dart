import 'package:chautari/model/app_info.dart';
import 'package:chautari/model/menu_item.dart';
import 'package:chautari/utilities/constants.dart';
import 'package:chautari/utilities/router/router_name.dart';

import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class AddPropertyController extends GetxController {
  final AppinfoModel appInfo = Get.find(tag: AppConstant.appinfomodelsKey);
  // list =>
  // single select => // district
  // multi select =>
  // amenities
  // parkings
  // waters

// district, type textfield, action picker, done

// address, textfield
  // lat, lng, type textfield, action map,
// price textfield
// number of rooms, textfield

// parkings, type textfield, action multi select picker, result tag list
// amenities, type textfield, action  multi select picker, result tag list
// available, boolean switch
// water, picker (probably date picker)
// preferences, multi select

// images, picker, preview

  var isValid = false;
  var address = "".obs;
  var addressError = "".obs;
  // var districtId = "".obs;
  // var lat = "".obs;
  // var long = "".obs;
  // var price = "".obs;
  // var numberOfRooms = "".obs;

  // var parkingIds = List<String>().obs;
  // var amenityIds = List<String>().obs;
  // var available = true.obs;
  // var waterId = "".obs;
  // var images = List<File>().obs;

  setAddress(String val) {
    if (val.length > 2) {
      address.value = val;
    } else {
      addressError.value = "Enter valid District";
    }
  }

  validateAddress() {}

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

    districtViewmodels.assignAll(
      _districts.map(
        (e) => MenuItem(title: e.name, subtitle: "${e.state}"),
      ),
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  submit() {}

  openMap() async {
    await Get.toNamed(RouteName.map);
  }
}
