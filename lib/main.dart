import 'dart:io';

import 'package:chautari/services/appinfo_service.dart';
import 'package:chautari/utilities/router/routers.dart';
import 'package:chautari/utilities/socket.dart';
import 'package:chautari/utilities/theme/theme.dart';
import 'package:chautari/utilities/theme/theme_controller.dart';
import 'package:chautari/services/fetch_room_service.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:chautari/view/login/login_view.dart';
import 'package:chautari/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  await initServices();
  runApp(MyApp());
}

void initServices() async {
  print('starting services ...');
  Get.put(AuthController());
  await Get.putAsync(() => FetchRoomService().init());
  await Get.putAsync(() => AppInfoService().init());
  await Get.putAsync(() => PresenceService().init());
  await Get.putAsync(() => SocketController().init());
  print('All services started...');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final ThemeController themeController = Get.put(ThemeController());
  final AuthController loginController = Get.put(AuthController());
  final FetchRoomService fetchRoomsService = Get.put(FetchRoomService());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chautari Basti',
      getPages: ChautariRouters().routers,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      home: SplashScreen(),
      // home: MyHomePage(title: 'Chautari'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return LoginView();
  }
}
