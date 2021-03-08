import 'dart:async';

import 'package:chautari/services/app_update.dart';
import 'package:chautari/services/appinfo_service.dart';
import 'package:chautari/services/room_service.dart';
import 'package:chautari/widgets/snack_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:package_info/package_info.dart';

class SplashController extends GetxController {
  AppInfoService appInfoService = Get.find();
  RoomService _roomService = Get.find();
  AppUpdateService appUpdateService = Get.find();
  String error;
  var isLoading = false;
  var appInfoLoaded = false.obs;
  var roomLoaded = false.obs;
  var timeEllapsed = false.obs;

  var appName = "".obs;
  var version = "".obs;
  var buildNumber = "".obs;

  var versionlabel = "".obs;

  int waitDuration = 10;

  Timer _timer;

  @override
  void onInit() async {
    super.onInit();
    _timer = Timer(Duration(seconds: waitDuration), () {
      this.timeEllapsed.toggle();
      _timer.cancel();
    });
    ChautariSnackBar.context = Get.context;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appName.value = packageInfo.appName;
    version.value = packageInfo.version;
    buildNumber.value = packageInfo.buildNumber;

    setVersionText();
  }

  @override
  void onReady() async {
    super.onReady();

    this.isLoading = true;

    timeEllapsed.listen((value) {
      proceed();
    });

    await Future.wait([
      _roomService.fetchRooms(),
      appInfoService.fetchAppInfo(),
    ]);
    var config = appInfoService.appInfo.config;
    var serverVersion =
        GetPlatform.isAndroid ? config.androidVersion : config.iosVersion;
    appUpdateService.setInfo(
        version: this.version.value,
        serverVersion: serverVersion,
        forceUPdate: config.forceUpdate);

    this.isLoading = false;
    proceed();
  }

  proceed() {
    if (!this.isLoading) {
      Get.offNamed("/tabs");
    }
  }

  setVersionText() {
    if (version.isNotEmpty) {
      var name = appName.isEmpty ? "Chautari Basti" : appName.value;
      this.versionlabel.value =
          appName + " V" + version.value + ":" + buildNumber.value;
    }
  }

  showNoInternetError(String message) {
    ChautariSnackBar.context = Get.context;
    ChautariSnackBar.showNoInternetMesage(message);
  }
}
