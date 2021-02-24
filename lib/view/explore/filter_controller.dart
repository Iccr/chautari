import 'package:chautari/model/room_model.dart';
import 'package:chautari/services/appinfo_service.dart';
import 'package:chautari/services/room_service.dart';

import 'package:chautari/utilities/NepaliRupeeTextFormatter.dart';
import 'package:chautari/utilities/api_service.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/view/room/form_keys.dart';
import 'package:chautari/view/room/room_form_focusnode.dart';
import 'package:get/get.dart';

class FilterRoomController extends GetxController {
  RoomFormKeys formKeys = RoomFormKeys();
  RoomFocusNodes focusNodes = RoomFocusNodes();
  AppInfoService appInfoService = Get.find();

  RoomService roomService;

  var params = {
    "type": null,
    "number_of_room_lower": null,
    "district_name": null,
    "water": null,
    "price_lower": null,
    "price_upper": null
  }.obs;

  var updateNewImages = false.obs;

  @override
  void onInit() {
    super.onInit();
    roomService = Get.find();
  }
}
