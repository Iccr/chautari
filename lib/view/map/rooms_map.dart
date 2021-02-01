import 'package:chautari/widgets/map/map.dart';
import 'package:flutter/material.dart';

class RoomsMap extends StatelessWidget {
  ChautariMapController mapController = ChautariMapController();
  @override
  Widget build(BuildContext context) {
    return Map(title: "Map", controller: mapController).getRoomsMap();
  }
}
