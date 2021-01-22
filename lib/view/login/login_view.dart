import 'package:chautari/view/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (c) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () => c.fbLogin(),
                child: Text("Login With Facebook"),
              ),
              RaisedButton(
                onPressed: () => c.gleSignIn(),
                child: Text("Login With Google"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
