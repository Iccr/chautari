import 'package:chautari/model/login_model.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/view/login/auth_controller.dart';
import 'package:chautari/view/login/login_view.dart';
import 'package:chautari/view/profile/avatar_component.dart';
import 'package:chautari/view/profile/profile_controller.dart';
import 'package:chautari/widgets/flat_buttons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProfileView extends StatelessWidget {
  AlertDialog dialogue;

  @override
  Widget build(BuildContext context) {
    AuthController loginController = Get.find();
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

    _logout() async {
      await loginController.logout();
    }

    double _getHeight() {
      print("get_height of userview");
      print(loginController.isLoggedIn);
      return loginController.isLoggedIn ? 60 : 85;
    }

    Widget _getFAB() {
      return loginController.isLoggedIn
          ? null
          : FloatingActionButton(
              onPressed: () => {_goTOLogin()},
              backgroundColor: ChautariColors().blackAndPrimarycolor(),
              child: Text(
                "Login",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            );
    }

    return GetX<ProfileController>(
      init: ProfileController(),
      builder: (c) => SafeArea(
        child: Scaffold(
            body: Container(
              child: ListView(children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: padding, left: padding),
                    height: _getHeight(),
                    child: UserInfoView(
                      user: loginController.user,
                      action: _goTOLogin,
                    )),
                ListTile(
                  title: Text('My Properties'),
                  onTap: () {
                    if (!loginController.isLoggedIn) {
                      Get.defaultDialog(
                          middleText: "Please login to continue",
                          textConfirm: "Login",
                          confirmTextColor:
                              ChautariColors().blackAndWhitecolor(),
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
            floatingActionButton: _getFAB()),
      ),
    );
  }
}

class UserInfoView extends StatelessWidget {
  AuthController loginController = Get.find();
  ProfileController profileController = Get.find();
  final UserModel user;
  final Function action;
  UserInfoView({this.user, this.action});
  @override
  Widget build(BuildContext context) {
    showDialogue() {
      Get.defaultDialog(
          title: "Do you want to Logout?",
          middleText:
              "your will not be able to get notification and other services",
          textConfirm: "Logout",
          confirmTextColor: ChautariColors().blackAndWhitecolor(),
          onConfirm: () async {
            await loginController.logout();
            Get.back();
          },
          onCancel: () => {Get.back()});
    }

    return !loginController.isLoggedIn
        ? Container(
            child: Row(
              children: [
                Flexible(
                  child: RichText(
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                              text: profileController.user_insight_message),
                          TextSpan(text: " Would you like to "),
                          TextSpan(
                              text: "Login now",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.none,
                                  color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  action();
                                }),
                        ]),
                  ),
                ),
              ],
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AvatarView(
                radius: 37.77,
                imageUrl: user?.imageurl ?? "",
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user?.name ?? "",
                      style: Theme.of(context).textTheme.bodyText1),
                  Text(user?.email ?? "")
                ],
              ),
              Expanded(child: Container()),
              ChautariWidget.getFlatButton(
                Text("Logout"),
                () {
                  showDialogue();
                },
              ),
              SizedBox(
                width: 15,
              )
            ],
          );
  }
}
