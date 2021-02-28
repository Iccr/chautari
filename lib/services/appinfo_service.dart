import 'package:chautari/model/app_info.dart';
import 'package:chautari/repository/appinfo_repository.dart';
import 'package:get/get.dart';

class AppInfoService extends GetxService {
  var _appInfo = AppinfoModel().obs;
  var isLoading = false.obs;
  var error = "".obs;
  var success = false.obs;
  AppinfoModel get appInfo => _appInfo.value;

  Future<AppInfoService> init() async {
    return this;
  }

  fetchAppInfo() async {
    isLoading.value = true;
    var model = await AppinfoRepository().fetchAppInfo();

    isLoading.value = false;
    if (model.errors?.isEmpty ?? false) {
      this._appInfo.value = model.data;
      this.success.value = true;
    } else {
      this.error.value = model.errors?.first?.value;
      this.success.value = false;
    }
  }
}
