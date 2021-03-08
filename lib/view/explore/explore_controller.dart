import 'package:chautari/model/room_model.dart';
import 'package:chautari/services/app_update.dart';
import 'package:chautari/services/room_service.dart';
import 'package:chautari/utilities/firemessenger.dart';
import 'package:chautari/view/explore/filter_controller.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:chautari/widgets/alert.dart';
import 'package:get/get.dart';

class ExploreController extends GetxController {
  AuthController auth = Get.find();
  AppUpdateService appUpdateService = Get.find();

  RoomService _service;
  SearchViewModel searchModel;

  Firemessenger messenger = Firemessenger();

  var height = 45.0.obs;
  var duration = 150.obs;
  double get containerHeight => height.value;
  var isSearching = false.obs;
  var _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  String error;
  var _models = <RoomModel>[].obs;
  List<RoomModel> get models => _models.value;

  RxInt filterCount = 0.obs;

  get length => models.length;

  @override
  void onInit() {
    super.onInit();
    _service = Get.find();
    this._isLoading = _service.isLoading;
    this._models = _service.rooms;

    _setupSearchViewModel();
  }

  @override
  onReady() {
    super.onReady();
    checkAppUpdate();
  }

  checkAppUpdate() {
    if (appUpdateService.shouldUPdate) {
      Alert.show(
          title: "Hurray..",
          message:
              "Chautari basti just got better. Please update to the latest version",
          textConfirm: "Update  ",
          onConfirm: () {
            appUpdateService.update();
          },
          textCancel: null,
          onCancel: null);
    }
  }

  _setupSearchViewModel() {
    try {
      searchModel = Get.find();
    } catch (e) {
      searchModel = Get.put(SearchViewModel());
    }
    searchModel.totalFilterCount.stream.listen((event) {
      this.filterCount.value = event;
    });
  }

  search({String address}) async {
    this._isLoading = _service.isLoading;
    this._models = _service.rooms;
    searchModel.reset();
    _service.searchAddress(address: address);
  }
}
