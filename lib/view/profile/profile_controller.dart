import 'package:chautari/model/login_model.dart';
import 'package:chautari/view/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProfileController extends GetxController {
  final LoginController loginController = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
  }

  bool get isLoggedIn => loginController.isLoggedIn;

  UserModel get user => loginController.user;

  String get image => loginController.user.imageurl;
}
