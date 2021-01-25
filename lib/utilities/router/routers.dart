import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/view/add_property/add_property.dart';
import 'package:chautari/view/explore/explore_view.dart';
import 'package:chautari/view/login/login_view.dart';
import 'package:chautari/view/tab/tab_view.dart';
import 'package:get/get.dart';

class Routers {
  List<GetPage> _routers;

  Routers() {
    _routers = [
      GetPage(name: RouteName.tab, page: () => Tabbar()),
      GetPage(name: RouteName.roomsList, page: () => Exploreview()),
      GetPage(name: RouteName.login, page: () => LoginView()),
      GetPage(name: RouteName.addPropery, page: () => AddProperty())
    ];
  }

  List<GetPage> get routers => _routers;
}
