import 'package:chautari/model/room_model.dart';
import 'package:chautari/services/room_service.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:get/get.dart';

class MyRoomsController extends GetxController {
  final AuthController auth = Get.find();
  RoomService roomService;
  var isLoading = false.obs;
  String error;
  var models = List<RoomModel>().obs;

  get length => models.length;

  @override
  onInit() {
    try {
      roomService = Get.find();
    } catch (e) {
      roomService = Get.put(RoomService());
    }
    if (auth.user.isLoggedIn) {
      _fetchMyRoom();
    }
  }

  _fetchMyRoom() {
    isLoading = roomService.isLoading;
    models = roomService.myRooms;
    roomService.fetchMyRooms();
  }
}
