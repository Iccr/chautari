import 'package:chautari/model/menu_item.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProfileController extends GetxController {
  AuthController auth = Get.find();
  List<MenuItem> _loggedInMenu = [
    MenuItem(
        title: "List your property",
        index: 0,
        subtitle: "Earn money, rent your property in Chautari Basti"),
    MenuItem(
        title: "My properties ",
        index: 1,
        subtitle: "Manage Your properties in Chautari Basti"),
    // MenuItem(
    //     title: "My Subscriptions",
    //     index: 2,
    //     subtitle: "We will notify you when your preference is matched"),
    MenuItem(
        title: "Setting",
        index: 3,
        subtitle: "Customize looks and feel of Chautari Basti")
  ];

  List<MenuItem> _normalMenu = [
    MenuItem(
        title: "List your property",
        index: 0,
        subtitle: "Earn money, rent your property in Chautari Basti"),
    MenuItem(
        title: "My properties",
        index: 1,
        subtitle: "Manage Your properties in Chautari Basti"),
    MenuItem(
        title: "Setting",
        index: 3,
        subtitle: "Customize looks and feel of Chautari Basti")
  ];

  List<MenuItem> get menu => auth.isLoggedIn ? _loggedInMenu : _normalMenu;

  String get userInsightMessage =>
      "Log in to access chats, suscribtions and many more features.";

  selectedIndex(int index) {
    MenuItem selectedItem = menu.elementAt(index);
    print("selected item:${selectedItem.title}");

    switch (selectedItem.index) {
      case 0:
        print("go to ${RouteName.addRoom}");
        Get.toNamed(RouteName.addRoom);
        break;
      case 1:
        print("go to ${RouteName.myRooms}");
        Get.toNamed(RouteName.myRooms);
        break;
      case 2:
        break;
      case 3:
        print("go to ${RouteName.setting}");
        Get.toNamed(RouteName.setting);
        break;
      default:
    }
  }
}
