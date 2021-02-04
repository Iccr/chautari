import 'package:chautari/model/rooms_model.dart';

import 'package:chautari/view/explore/fetch_room_service.dart';

import 'package:get/get.dart';

class ExploreController extends GetxController {
  FetchRoomService service;
  var _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  String error;
  var _models = List<RoomsModel>().obs;
  List<RoomsModel> get models => _models.value;

  get length => models.length;
  @override
  void onInit() {
    super.onInit();
    service = Get.find();
    this._isLoading.value = service.isLoading;
    this._models.assignAll(this.service.rooms);
  }
}
