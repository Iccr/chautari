import 'dart:convert';
import 'dart:io';

import 'package:chautari/model/room_model.dart';
import 'package:chautari/services/room_service.dart';
import 'package:chautari/view/explore/filter_controller.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class ExploreController extends GetxController {
  AuthController auth = Get.find();
  RoomService _service;
  SearchViewModel searchModel;

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
  var _models = <RoomModel>[].obs;
  List<RoomModel> get models => _models.value;

  RxInt filterCount = 0.obs;

  get length => models.length;

  @override
  void onInit() {
    super.onInit();
    _service = Get.find();
    this._isLoading = _service.isLoading;
    this._models = _service.rooms;

    _setupFirebase();
    _setupSearchViewModel();
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
    registerNotification();
    configLocalNotification();
  }

  _setupSearchViewModel() {
    try {
      searchModel = Get.find();
    } catch (e) {
      searchModel = Get.put(SearchViewModel());
    }
    searchModel.totalFilterCount.stream.listen((event) {
      this.filterCount.value = event;
    });
  }

  search({String address}) async {
    this._isLoading = _service.isLoading;
    this._models = _service.rooms;
    searchModel.reset();
    _service.searchAddress(address: address);
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
