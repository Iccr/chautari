import 'package:chautari/model/rooms_model.dart';
import 'package:chautari/repository/rooms_repository.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ExploreController extends GetxController {
  AuthController auth = Get.find();
  bool isLoading = false;
  String error;
  List<RoomsModel> models;

  get length => models.length;
  @override
  void onReady() {
    super.onReady();
    _fetchMyRooms();
  }

  _fetchMyRooms() async {
    isLoading = true;
    var models = await RoomsRepository().fetchMyRooms(auth.user.id);
    isLoading = false;
    if (models.errors?.isEmpty ?? false) {
      this.error = models.errors?.first?.value;
    } else {
      this.models = models.rooms;
    }
    update();
  }
}
