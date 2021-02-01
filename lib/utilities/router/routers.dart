import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/view/room/add_room/add_room.dart';

import 'package:chautari/view/explore/explore_view.dart';
import 'package:chautari/view/login/login_view.dart';
import 'package:chautari/view/room/my_rooms/my_room.dart';
import 'package:chautari/view/tab/tab_view.dart';
import 'package:chautari/widgets/location_picker.dart';
import 'package:chautari/widgets/map/map.dart';
import 'package:get/get.dart';

class ChautariRouters {
  List<GetPage> _routers;

  ChautariRouters() {
    _routers = [
      GetPage(name: RouteName.tab, page: () => Tabbar()),
      GetPage(name: RouteName.roomsList, page: () => Exploreview()),
      GetPage(name: RouteName.login, page: () => LoginView()),
      GetPage(name: RouteName.addPropery, page: () => AddRoom()),
      GetPage(name: RouteName.map, page: () => MapView()),
      GetPage(name: RouteName.pickLocation, page: () => LocationPicker()),
      GetPage(name: RouteName.myRooms, page: () => MyRoom())
    ];
  }

  List<GetPage> get routers => _routers;
}
