import 'package:chautari/model/app_info.dart';
import 'package:chautari/repository/appinfo_repository.dart';
import 'package:get/get.dart';

class AppInfoService extends GetxService {
  var _appInfo = AppinfoModel().obs;
  var _isLoading = false.obs;
  var _error = "".obs;
  bool get isLoading => _isLoading.value;
  String get error => _error.value.isEmpty ? null : _error.value;
  AppinfoModel get appInfo => _appInfo.value;

  Future<AppInfoService> init() async {
    _fetchAppInfo();
    return this;
  }

  _fetchAppInfo() async {
    _isLoading.value = true;
    var model = await AppinfoRepository().fetchAppInfo();

    _isLoading.value = false;
    if (model.errors?.isEmpty ?? false) {
      this._error.value = model.errors?.first?.value;
    } else {
      this._appInfo.value = model.data;
    }
  }
}
