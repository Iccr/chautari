import 'package:chautari/view/login/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProfileController extends GetxController {
  AuthController auth = Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
  }

  List<String> _normalMenu = [
    "Add Rent",
    "My Rents",
    "My Subscriptions",
    "chats",
  ];

  List<String> _loggedInMenu = [
    "Add Rent",
    "My Rents",
  ];

  List<String> get menu => auth.isLoggedIn ? _loggedInMenu : _normalMenu;

  String get user_insight_message =>
      "Log in to access chats, suscribtions and many more features.";
}
