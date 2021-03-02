import 'package:chautari/services/analytics_service.dart';
import 'package:chautari/services/appinfo_service.dart';
import 'package:chautari/utilities/mapStyles.dart';

import 'package:chautari/utilities/router/routers.dart';
import 'package:chautari/utilities/theme/theme.dart';
import 'package:chautari/utilities/theme/theme_controller.dart';
import 'package:chautari/services/room_service.dart';
import 'package:chautari/view/login/auth_controller.dart';

import 'package:chautari/view/splash/splash_screen.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  await Firebase.initializeApp();
  await Get.putAsync(() => AnalyticsService().init());

  await Get.putAsync(() => MapStyles().init());
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
    AnalyticsService analyticsService = Get.find();
    return GetMaterialApp(
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analyticsService.analytics)
      ],
      debugShowCheckedModeBanner: false,
      title: 'Chautari Basti',
      routingCallback: (route) {
        // middleware.observer(route);
      },
      getPages: ChautariRouters().routers,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      home: SplashScreen(),
    );
  }
}
