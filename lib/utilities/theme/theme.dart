import 'package:chautari/utilities/theme/colors.dart';
import 'package:flutter/material.dart';

extension AppTheme on ThemeData {
  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        headline4: TextStyle(
            fontFamily: "Poppins", fontSize: 33.0, fontWeight: FontWeight.bold),
        headline5: TextStyle(
            fontFamily: "Poppins", fontSize: 23.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(
            fontSize: 19.0, fontFamily: "Poppins", fontWeight: FontWeight.bold),
        bodyText2: TextStyle(
            fontSize: 13.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: ChautariColors.white.withOpacity(0.8)),
        bodyText1: TextStyle(
            fontSize: 15.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: ChautariColors.white.withOpacity(0.9)),
      ),
    );
  }

  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Poppins',
      primarySwatch: ChautariColors.primaryColor(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        headline4: TextStyle(
            fontFamily: "Poppins", fontSize: 33.0, fontWeight: FontWeight.bold),
        headline5: TextStyle(
            fontFamily: "Poppins", fontSize: 23.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(
            fontSize: 19.0, fontFamily: "Poppins", fontWeight: FontWeight.bold),
        bodyText2: TextStyle(
            fontSize: 13.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: ChautariColors.black.withOpacity(0.8)),
        bodyText1: TextStyle(
            fontSize: 15.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: ChautariColors.black.withOpacity(0.9)),
      ),
    );
  }
}
