import 'package:chautari/model/room_model.dart';
import 'package:get/get.dart';

class UpdateRoomService extends GetxController {
  var _rooms = RoomsModel().obs;
  var _isLoading = false.obs;
  var _error = "".obs;
  bool get isLoading => _isLoading.value;
  String get error => _error.value.isEmpty ? null : _error.value;
  RoomsModel get rooms => _rooms.value;

  @override
  onInit() {
    _updateRooms();
  }

  _updateRooms() async {
    // _isLoading.value = true;
    // var models = await RoomsRepository().fetchRooms();
    // Get.put(models, tag: AppConstant.roomsKey);
    // _isLoading.value = false;
    // if (models.errors?.isEmpty ?? false) {
    //   this._error.value = models.errors?.first?.value;
    // } else {
    //   this._room.value
    // }
    update();
  }
}
