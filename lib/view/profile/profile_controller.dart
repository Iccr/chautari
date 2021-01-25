import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProfileController extends GetxController {
  AuthController auth = Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
  }

  goTo(index) {}

  List<MenuItem> _normalMenu = [
    MenuItem(
        title: "Add Rent",
        index: 0,
        subtitle: "Earn money, rent your property in Chautari Basti"),
    MenuItem(
        title: "My Rents",
        index: 1,
        subtitle: "See Your properties in Chautari Basti"),
    MenuItem(
        title: "My Subscriptions",
        index: 2,
        subtitle: "we will notify you when your preference is matched"),
    MenuItem(title: "chats", index: 3, subtitle: "Your chats history")
  ];

  List<MenuItem> _loggedInMenu = [
    MenuItem(title: "Add Rent", index: 0),
    MenuItem(title: "My Rents", index: 1),
  ];

  List<MenuItem> get menu => auth.isLoggedIn ? _loggedInMenu : _normalMenu;

  String get user_insight_message =>
      "Log in to access chats, suscribtions and many more features.";

  selectedIndex(int index) {
    MenuItem selectedItem = menu.elementAt(index);
    print("selected item:${selectedItem.title}");

    switch (selectedItem.index) {
      case 0:
        print("go to ${RouteName.addPropery}");
        Get.toNamed(RouteName.addPropery);
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      default:
    }
  }
}

class MenuItem {
  final String title;
  final int index;
  final String subtitle;
  MenuItem({this.title, this.index, this.subtitle});
}
