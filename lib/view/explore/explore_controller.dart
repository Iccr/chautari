import 'package:chautari/model/rooms_model.dart';
import 'package:chautari/repository/rooms_repository.dart';
import 'package:chautari/utilities/constants.dart';

import 'package:get/get.dart';

class ExploreController extends GetxController {
  var _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  String error;
  List<RoomsModel> models;

  get length => models.length;
  @override
  void onReady() {
    super.onReady();
    fetchRooms();
  }

  fetchRooms() async {
    _isLoading.value = true;
    var models = await RoomsRepository().fetchRooms();
    Get.put(models, tag: AppConstant.roomsKey);
    _isLoading.value = false;
    if (models.errors?.isEmpty ?? false) {
      this.error = models.errors?.first?.value;
    } else {
      this.models = models.rooms;
    }
    update();
  }
}
