import 'package:chautari/repository/appinfo_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SplashController extends GetxController {
  String error;
  var loaded = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _fetchAppInfo();
  }

  _fetchAppInfo() async {
    var models = await AppinfoRepository().fetchAppInfo();
    if ((models.errors ?? []).isEmpty) {
      this.loaded = true;
      Get.put(models, tag: "appinfomodels");
      Get.offNamed("/tabs");
    } else {
      error = models.errors.first?.value ?? "";
    }
  }
}
