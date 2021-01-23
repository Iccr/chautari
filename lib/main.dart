import 'package:chautari/view/explore/explore_view.dart';
import 'package:chautari/view/login/login_view.dart';
import 'package:chautari/view/room/list_room_view.dart';
import 'package:chautari/view/splash/splash_screen.dart';
import 'package:chautari/view/tab/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      getPages: [
        GetPage(name: "/tabs", page: () => Tabbar()),
        GetPage(name: "/rooms", page: () => Exploreview()),
        GetPage(name: "/login", page: () => LoginView())
      ],

      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline6: TextStyle(
              fontSize: 36.0,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500),
          bodyText2: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Poppins',
              color: Colors.black87,
              fontWeight: FontWeight.w500),
          bodyText1: TextStyle(
              fontSize: 16.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600),
        ),
      ),
      home: SplashScreen(),
      // home: MyHomePage(title: 'Chautari'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return LoginView();
  }
}
