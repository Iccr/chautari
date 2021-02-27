import 'dart:async';

import 'package:chautari/services/appinfo_service.dart';
import 'package:chautari/services/room_service.dart';
import 'package:chautari/widgets/snack_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SplashController extends GetxController {
  AppInfoService appInfoService = Get.find();
  RoomService _roomService = Get.find();
  String error;
  var loaded = false;
  var timeEllapsed = false.obs;

  Timer _timer;

  @override
  void onInit() {
    super.onInit();
    _timer = Timer(Duration(seconds: 4), () {
      this.timeEllapsed.toggle();
      _timer.cancel();
    });
    ChautariSnackBar.context = Get.context;
  }

  @override
  void onReady() {
    super.onReady();
    _fetchAppInfo();

    timeEllapsed.listen((value) {
      Get.offNamed("/tabs");
    });

    listenAppInfoService();
    listenRoomService();
  }

  listenRoomService() {
    _roomService.success.listen((value) {
      if (!value) {
        showNoInternetError(_roomService.error);
      }
    });
    _roomService.fetchRooms();
  }

  listenAppInfoService() {
    appInfoService.success.listen((value) {
      if (!value) {
        showNoInternetError(appInfoService.error.value);
      }
    });
  }

  showNoInternetError(String message) {
    ChautariSnackBar.context = Get.context;
    ChautariSnackBar.showNoInternetMesage(message);
  }

  _fetchAppInfo() async {
    this.loaded = appInfoService.isLoading.value;
    appInfoService.fetchAppInfo();
  }
}
