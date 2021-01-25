import 'package:chautari/model/login_model.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/view/login/login_view.dart';
import 'package:chautari/view/profile/avatar_component.dart';
import 'package:chautari/view/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProfileView extends StatelessWidget {
  AlertDialog dialogue;

  @override
  Widget build(BuildContext context) {
    const double padding = 15;
    _goTOLogin() {
      showCupertinoModalBottomSheet(
        expand: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => LoginView(),
      );
    }

    _goToMyProperties() {
      print("go to my properties");
    }

    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (c) => SafeArea(
        child: Scaffold(
          body: Container(
            child: ListView(children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: padding, left: padding),
                  height: c.isLoggedIn ? 60 : 0,
                  child: UserInfoView(
                    user: c.user,
                  )),
              ListTile(
                title: Text('My Properties'),
                onTap: () {
                  if (!c.isLoggedIn) {
                    Get.defaultDialog(
                        middleText: "Please login to continue",
                        textConfirm: "Login",
                        confirmTextColor: ChautariColors().blackAndWhitecolor(),
                        onConfirm: () => {
                              Get.back(),
                              _goTOLogin(),
                            },
                        onCancel: () => {Get.back()});
                  } else {
                    _goToMyProperties();
                  }
                },
              ),
              ListTile(
                title: Text('Add and Earn Money'),
                onTap: () => {},
              ),
              ListTile(
                title: Text('My Stats'),
                onTap: () => {},
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class UserInfoView extends StatelessWidget {
  final UserModel user;
  UserInfoView({this.user});
  @override
  Widget build(BuildContext context) {
    const double _padding = 15;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AvatarView(
          radius: 37.77,
          imageUrl: user.imageurl ?? "",
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.name ?? "", style: Theme.of(context).textTheme.bodyText1),
            Text(user.email ?? "")
          ],
        ),
        Expanded(child: Container()),
        FlatButton(
          color: ChautariColors().blackAndWhitecolor(),
          onPressed: null,
          child: Text("Logout"),
        )
      ],
    );
  }
}
