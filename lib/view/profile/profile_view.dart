import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/view/profile/avatar_component.dart';
import 'package:chautari/view/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  AlertDialog dialogue;

  _goTOLogin() {
    print("login");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (c) => SafeArea(
        child: Scaffold(
          body: Container(
            child: ListView(children: <Widget>[
              AvatarView(),
              ListTile(
                title: Text('My Properties'),
                onTap: () {
                  Get.defaultDialog(
                      middleText: "Please login to continue",
                      textConfirm: "Login",
                      confirmTextColor: ChautariColors().blackAndWhitecolor(),
                      onConfirm: () => {
                            Get.back(),
                            _goTOLogin(),
                          },
                      onCancel: () => {Get.back()});

                  // Get.dialog(showAndroidAlertDialog(context,
                  //     title: "Alert", message: "Please login"));
                  // print("show dialogue");
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
