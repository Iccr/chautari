import 'package:chautari/utilities/loading/progress_hud.dart';
import 'package:chautari/view/splash/spalsh_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (c) => Container(
          child: ProgressHud(
        isLoading: !c.loaded,
        child: Scaffold(
          body: Center(
            child: Text("loading"),
          ),
        ),
      )),
    );
  }
}
