import 'package:chautari/model/login_model.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
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
    double padding = ChautariPadding.standard;
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
      return loginController.isLoggedIn ? 60 : 60;
    }

    Widget _getFAB() {
      return loginController.isLoggedIn
          ? null
          : FloatingActionButton(
              onPressed: () => {_goTOLogin()},
              backgroundColor: ChautariColors.blackAndPrimarycolor(),
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
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: padding, left: padding),
                    height: _getHeight(),
                    child: UserInfoView(
                      user: loginController.user,
                      action: _goTOLogin,
                    ),
                  ),
                  Expanded(
                      child: ListView.separated(
                    separatorBuilder: (context, index) => Container(
                      padding: EdgeInsets.only(left: 10, right: 100),
                      height: 0.5,
                      child: Container(
                        color: ChautariColors.primaryAndWhitecolor()
                            .withOpacity(0.5),
                      ),
                    ),
                    itemCount: c.menu.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => {c.selectedIndex(index)},
                        child: Container(
                          padding: EdgeInsets.all(ChautariPadding.standard),
                          height: 60,
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  c.menu.elementAt(index).title,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ))
                ],
              ),
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
          confirmTextColor: ChautariColors.blackAndWhitecolor(),
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
                                color: ChautariColors.primaryColor(),
                              ),
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
