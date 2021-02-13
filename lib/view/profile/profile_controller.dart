import 'package:chautari/model/menu_item.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProfileController extends GetxController {
  AuthController auth = Get.find();
  List<MenuItem> _loggedInMenu = [
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
        subtitle: "We will notify you when your preference is matched"),
    MenuItem(title: "chats", index: 3, subtitle: "Your chats history")
  ];

  List<MenuItem> _normalMenu = [
    MenuItem(
        title: "Add Rent",
        index: 0,
        subtitle: "Earn money, rent your property in Chautari Basti"),
    MenuItem(
        title: "My Rents",
        index: 1,
        subtitle: "See Your properties in Chautari Basti"),
  ];

  List<MenuItem> get menu =>
      auth.isLoggedIn.value ? _loggedInMenu : _normalMenu;

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
        print("got ot chat");
        Get.toNamed(RouteName.conversation);
        break;
      default:
    }
  }
}
