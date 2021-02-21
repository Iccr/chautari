import 'dart:async';

import 'package:chautari/utilities/router/router_name.dart';
import 'package:get/get.dart';

class MiddleWare {
  StreamController isRoomMapViewInScreen = new StreamController.broadcast();

  observer(Routing routing) {
    this.isRoomMapViewInScreen.add(routing.current == RouteName.map);
  }
}

MiddleWare middleware = MiddleWare();
