import 'dart:async';

import 'package:chautari/repository/appinfo_repository.dart';
import 'package:chautari/utilities/constants.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SplashController extends GetxController {
  String error;
  var loaded = false;
  var timeEllapsed = false.obs;

  Timer _timer;

  @override
  void onInit() {
    super.onInit();
    _timer = Timer(Duration(seconds: 5), () {
      this.timeEllapsed.toggle();
      _timer.cancel();
    });
  }

  @override
  void onReady() {
    super.onReady();
    _fetchAppInfo();

    timeEllapsed.listen((value) {
      if (loaded && timeEllapsed.value) {
        Get.offNamed("/tabs");
      }
    });
  }

  _fetchAppInfo() async {
    var models = await AppinfoRepository().fetchAppInfo();
    if ((models.errors ?? []).isEmpty) {
      this.loaded = true;
      Get.put(models.data, tag: AppConstant.appinfomodelsKey);
    } else {
      error = models.errors.first?.value ?? "";
    }
  }
}
