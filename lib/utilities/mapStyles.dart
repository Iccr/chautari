import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MapStyles extends GetxService {
  String _darkMapStyle;
  String _lightMapStyle;

  String get style => Get.isDarkMode ? _darkMapStyle : _lightMapStyle;

  Future<MapStyles> init() async {
    _loadMapStyles();
    return this;
  }

  _loadMapStyles() async {
    _darkMapStyle =
        await rootBundle.loadString('assets/map_styles/map_night_mode.json');
    _lightMapStyle =
        await rootBundle.loadString('assets/map_styles/map_light_mode.json');
  }
}
