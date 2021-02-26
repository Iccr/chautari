import 'package:flutter/services.dart';

class ChautariMapStyles {
  String darkMapStyle;
  String lightMapStyle;

  Future<ChautariMapStyles> loadMapStyles() async {
    darkMapStyle =
        await rootBundle.loadString('assets/map_styles/map_night_mode.json');
    lightMapStyle =
        await rootBundle.loadString('assets/map_styles/map_light_mode.json');
    return this;
  }
}
