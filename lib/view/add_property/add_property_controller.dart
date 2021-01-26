import 'package:chautari/model/app_info.dart';
import 'package:chautari/model/menu_item.dart';
import 'package:chautari/utilities/constants.dart';
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

// district, type textfield, action picker
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
  List<Parking> get _parkings => appInfo.parkings;
  List<Waters> get _waters => appInfo.waters;
  List<Amenities> get _amenities => appInfo.amenities;

  var districtViewmodels = List<MenuItem>().obs;
  var parkingViewModels = List<MenuItem>().obs;
  var waterViewModels = List<MenuItem>().obs;
  var amenitiesViewModels = List<MenuItem>().obs;

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
}
