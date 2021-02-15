import 'package:chautari/model/room_model.dart';
import 'package:chautari/services/fetch_room_service.dart';
import 'package:chautari/services/searc_room_service.dart';

import 'package:get/get.dart';

class ExploreController extends GetxController {
  FetchRoomService _service;
  SearchRoomService _searchService;

  var height = 45.0.obs;
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
    _service = Get.find();
    _searchService = SearchRoomService();
    this._isLoading = _service.isLoading;
    this._models = _service.rooms;
  }

  search({String address}) async {
    this._isLoading = _searchService.isLoading;
    this._models = _searchService.rooms;
    _searchService.search(address: address);
  }
}
