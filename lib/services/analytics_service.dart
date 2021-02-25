import 'package:chautari/model/app_info.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

class AnalyticsService extends GetxService {
  var _appInfo = AppinfoModel().obs;
  var _isLoading = false.obs;
  var _error = "".obs;

  FirebaseAnalytics analytics;

  bool get isLoading => _isLoading.value;
  String get error => _error.value.isEmpty ? null : _error.value;
  AppinfoModel get appInfo => _appInfo.value;

  Future<AnalyticsService> init() async {
    analytics = FirebaseAnalytics();
    return this;
  }
}

class AnalyticsName {
  // firebase recombended events
  static String login = "login";
  static String search = "search";
  static String share = "share";
}
