import 'package:chautari/model/add_room_multipart_model.dart';
import 'package:chautari/model/room_model.dart';
import 'package:chautari/services/appinfo_service.dart';
import 'package:chautari/utilities/NepaliRupeeTextFormatter.dart';
import 'package:chautari/view/room/form_keys.dart';
import 'package:chautari/view/room/room_form_focusnode.dart';
import 'package:get/get.dart';

class UpdateRoomController extends GetxController {
  RoomFormKeys formKeys = RoomFormKeys();
  RoomFocusNodes focusNodes = RoomFocusNodes();
  RoomModel room;

  String get price =>
      NepaliRupeeFormatter().getDecoratedString(room.price ?? "");

  var contactNumberVisible = false.obs;
  AppInfoService appInfoService = Get.find();

  List<dynamic> get initialParkingValue => room.parkings
      .map(
        (element) => element,
      )
      .toList();

  @override
  void onInit() {
    super.onInit();
    room = Get.arguments;
    contactNumberVisible.value = room.phone_visibility;
  }
}
