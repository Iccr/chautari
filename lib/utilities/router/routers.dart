import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/view/explore/filter_view.dart';
import 'package:chautari/view/room/add_room/add_room.dart';

import 'package:chautari/view/explore/explore_view.dart';
import 'package:chautari/view/login/login_view.dart';
import 'package:chautari/view/room/my_rooms/my_room.dart';
import 'package:chautari/view/room/room_detail/room_detail.dart';
import 'package:chautari/view/room/room_location_map/room_location_map.dart';
import 'package:chautari/view/room/update_room/update_room.dart';
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
      GetPage(name: RouteName.addRoom, page: () => AddRoom()),
      GetPage(name: RouteName.map, page: () => MapView()),
      GetPage(name: RouteName.pickLocation, page: () => LocationPicker()),
      GetPage(name: RouteName.myRooms, page: () => MyRoom()),
      GetPage(name: RouteName.roomDetail, page: () => RoomDetail()),
      GetPage(name: RouteName.updateRoom, page: () => UpdateRoom()),
      GetPage(name: RouteName.filterRoom, page: () => FilterRoom()),
      GetPage(
          name: RouteName.showRoomLocationOnMap,
          page: () => ShowRoomLocationMap())
    ];
  }

  List<GetPage> get routers => _routers;
}
