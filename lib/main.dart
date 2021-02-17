import 'package:chautari/services/appinfo_service.dart';
import 'package:chautari/utilities/router/routers.dart';
import 'package:chautari/utilities/theme/theme.dart';
import 'package:chautari/utilities/theme/theme_controller.dart';
import 'package:chautari/services/room_service.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:chautari/view/login/login_view.dart';
import 'package:chautari/view/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
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

  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  await Firebase.initializeApp();
  await Get.putAsync(() => AppInfoService().init());
  await Get.putAsync(() => RoomService().init());

  print('All services started...');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final ThemeController themeController = Get.put(ThemeController());
  final AuthController loginController = Get.put(AuthController());

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
