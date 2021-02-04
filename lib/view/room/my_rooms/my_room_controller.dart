import 'package:chautari/model/rooms_model.dart';
import 'package:chautari/repository/rooms_repository.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:get/get.dart';

class MyRoomsController extends GetxController {
  final AuthController auth = Get.find();
  bool isLoading = false;
  String error;
  List<RoomsModel> models;

  get length => models.length;
  @override
  onInit() {
    if (auth.user.isLoggedIn) {
      _fetchMyRooms();
    }
  }

  _fetchMyRooms() async {
    isLoading = true;
    var models = await RoomsRepository().fetchMyRooms();
    isLoading = false;
    if (models.errors?.isEmpty ?? false) {
      this.error = models.errors?.first?.value;
    } else {
      this.models = models.rooms;
    }
    update();
  }
}
