import 'package:flutter/material.dart';

extension AppTheme on ThemeData {
  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: 'Poppins',
      // primarySwatch: Colors.indigo,
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        headline4: TextStyle(
            fontFamily: "Poppins", fontSize: 36.0, fontWeight: FontWeight.w500),
        headline6: TextStyle(
            fontSize: 36.0, fontFamily: "Poppins", fontWeight: FontWeight.w500),
        bodyText2: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.8)),
        bodyText1: TextStyle(
            fontSize: 16.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.9)),
      ),
    );
  }

  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Poppins',
      primarySwatch: Colors.teal,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        headline4: TextStyle(
            fontFamily: "Poppins", fontSize: 36.0, fontWeight: FontWeight.w500),
        headline6: TextStyle(
            fontSize: 36.0, fontFamily: "Poppins", fontWeight: FontWeight.w500),
        bodyText2: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.8)),
        bodyText1: TextStyle(
            fontSize: 16.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(0.9)),
      ),
    );
  }
}
