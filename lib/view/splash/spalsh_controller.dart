import 'dart:async';

import 'package:chautari/repository/appinfo_repository.dart';
import 'package:chautari/services/appinfo_service.dart';
import 'package:chautari/utilities/constants.dart';
import 'package:chautari/view/chats/loading.dart';
import 'package:chautari/widgets/snack_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SplashController extends GetxController {
  AppInfoService appInfoService = Get.find();
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
      if (loaded && timeEllapsed.value) {
        Get.offNamed("/tabs");
      }
    });

    appInfoService.success.listen((value) {
      if (!value) {
        error = appInfoService.error.value;
        ChautariSnackBar.context = Get.context;
        ChautariSnackBar.showNoInternetMesage(error);
      }
    });
  }

  _fetchAppInfo() async {
    this.loaded = appInfoService.isLoading.value;
    appInfoService.fetchAppInfo();
    // var models = ;
    // if ((models.errors ?? []).isEmpty) {
    //   this.loaded = true;
    //   Get.put(models.data, tag: AppConstant.appinfomodelsKey);
    // } else {
    //   error = models.errors.first?.value ?? "";
    // }
  }
}
