import 'package:chautari/model/room_model.dart';
import 'package:chautari/services/fetch_room_service.dart';

import 'package:get/get.dart';

class ExploreController extends GetxController {
  FetchRoomService service;

  var height = 40.0.obs;
  var duration = 150.obs;
  double get containerHeight => height.value;
  var isSearching = false.obs;
  var _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  String error;
  var _models = List<RoomModel>().obs;
  List<RoomModel> get models => _models.value;

  get length => models.length;
  @override
  void onInit() {
    super.onInit();
    service = Get.find();
    this._isLoading = service.isLoading;
    this._models = service.rooms;
  }
}
