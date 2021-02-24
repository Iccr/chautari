import 'package:chautari/services/appinfo_service.dart';
import 'package:chautari/utilities/middleWare.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/utilities/router/routers.dart';
import 'package:chautari/utilities/theme/theme.dart';
import 'package:chautari/utilities/theme/theme_controller.dart';
import 'package:chautari/services/room_service.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:chautari/view/login/login_view.dart';
import 'package:chautari/view/map/rooms_map_controller.dart';
import 'package:chautari/view/splash/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message ${message.messageId}");
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
  enableVibration: true,
  playSound: true,
);

/// Initalize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  await GetStorage.init();
  await initServices();
  runApp(MyApp());
}

void initServices() async {
  print('starting services ...');

  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  ///
  // String host = defaultTargetPlatform == TargetPlatform.android
  //     ? '10.0.2.2:5002'
  //     : 'localhost:5002';

  //     FirebaseFunctions.instance
  // .useFunctionsEmulator(origin: 'http://localhost:5000')
  // .httpsCallable('myCloudFunction');

// Set the host as soon as possible.
  await Firebase.initializeApp();

  // FirebaseFirestore.instance.settings = Settings(host: host, sslEnabled: false);
  // FirebaseFunctions.instance
  //     .useFunctionsEmulator(origin: 'http://localhost:5001');
  // FirebaseAuth.instance.useEmulator('http://localhost:5000');

  await Get.putAsync(() => AppInfoService().init());
  await Get.putAsync(() => RoomService().init());

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

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
      routingCallback: (route) {
        // middleware.observer(route);
      },
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
