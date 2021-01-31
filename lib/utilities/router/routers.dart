import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/view/room/add_room/add_room.dart';

import 'package:chautari/view/explore/explore_view.dart';
import 'package:chautari/view/login/login_view.dart';
import 'package:chautari/view/tab/tab_view.dart';
import 'package:chautari/widgets/map/map.dart';
import 'package:get/get.dart';

class ChautariRouters {
  List<GetPage> _routers;

  ChautariRouters() {
    _routers = [
      GetPage(name: RouteName.tab, page: () => Tabbar()),
      GetPage(name: RouteName.roomsList, page: () => Exploreview()),
      GetPage(name: RouteName.login, page: () => LoginView()),
      GetPage(name: RouteName.addPropery, page: () => AddROom()),
      GetPage(name: RouteName.map, page: () => MapView())
    ];
  }

  List<GetPage> get routers => _routers;
}
