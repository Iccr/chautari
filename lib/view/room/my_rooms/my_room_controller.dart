import 'package:chautari/model/room_model.dart';
import 'package:chautari/services/fetch_my_room_service.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:get/get.dart';

class MyRoomsController extends GetxController {
  final AuthController auth = Get.find();
  FetchMyRoomService myRoomService;
  var isLoading = false.obs;
  String error;
  var models = List<RoomModel>().obs;

  get length => models.length;

  @override
  onInit() {
    try {
      myRoomService = Get.find();
    } catch (e) {
      myRoomService = Get.put(FetchMyRoomService());
    }
    if (auth.user.isLoggedIn) {
      _fetchMyRoom();
    }
  }

  _fetchMyRoom() {
    isLoading = myRoomService.isLoading;
    models = myRoomService.rooms;
    myRoomService.fetchMyRooms();
  }
}
