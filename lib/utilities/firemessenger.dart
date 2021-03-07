import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Firemessenger {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Firemessenger() {
    _setupFirebase();
    registerNotification();
    configLocalNotification();
  }

  _setupFirebase() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        print("remote message $message");
      }

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
    });
  }

  void registerNotification() async {
    firebaseMessaging.requestPermission();
    await firebaseMessaging.getInitialMessage();
    FirebaseMessaging.onMessage.listen((remoteMessage) {
      print("remoteMessage: $remoteMessage");

      showNotification(remoteMessage.notification);
    });

    FirebaseMessaging.onBackgroundMessage((message) {
      print("remote message in on background message");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      print("remote message in on onMessageOpenedApp ");
    });
  }

  void configLocalNotification() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'com.chautari.basti',
      'Chautari Basti',
      'Chautari Basti',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    print(message);
//    print(message['body'].toString());
//    print(json.encode(message));
    var payload = {
      "title": message.title,
      "body": message.body,
    };

    await flutterLocalNotificationsPlugin.show(
        0, message.title, message.body, platformChannelSpecifics,
        payload: json.encode(payload));

//    await flutterLocalNotificationsPlugin.show(
//        0, 'plain title', 'plain body', platformChannelSpecifics,
//        payload: 'item x');
  }
}
