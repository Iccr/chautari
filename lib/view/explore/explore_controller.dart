import 'dart:convert';
import 'dart:io';

import 'package:chautari/model/room_model.dart';
import 'package:chautari/services/room_service.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class ExploreController extends GetxController {
  AuthController auth = Get.find();
  RoomService _service;

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  var height = 45.0.obs;
  var duration = 150.obs;
  double get containerHeight => height.value;
  var isSearching = false.obs;
  var _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  String error;
  var _models = List<RoomModel>().obs;
  List<RoomModel> get models => _models.value;

  get length => models.length;
  @override
  void onInit() {
    super.onInit();
    _service = Get.find();
    this._isLoading = _service.isLoading;
    this._models = _service.rooms;

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        print("remote message $message");
      }

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
    });
    registerNotification();
    configLocalNotification();
  }

  search({String address}) async {
    this._isLoading = _service.isLoading;
    this._models = _service.rooms;
    _service.search(address: address);
  }

  void registerNotification() async {
    firebaseMessaging.requestPermission();
    await firebaseMessaging.getInitialMessage();
    FirebaseMessaging.onMessage.listen((remoteMessage) {
      print("remoteMessage: $remoteMessage");

      showNotification(remoteMessage.notification);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      print("$remoteMessage");
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
      Platform.isAndroid
          ? 'com.dfa.flutterchatdemo'
          : 'com.duytq.flutterchatdemo',
      'Flutter chat demo',
      'your channel description',
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

    await flutterLocalNotificationsPlugin.show(0, message['title'].toString(),
        message['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));

//    await flutterLocalNotificationsPlugin.show(
//        0, 'plain title', 'plain body', platformChannelSpecifics,
//        payload: 'item x');
  }
}
