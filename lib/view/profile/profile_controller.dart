import 'package:chautari/view/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProfileController extends GetxController {
  LoginController loginController = Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
  }

  bool isLoggedIn() {
    return loginController.isLoggedIn;
  }
}
