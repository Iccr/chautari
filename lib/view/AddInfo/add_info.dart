import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddInfo extends StatelessWidget {
  const AddInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Earn Easy"),
        ),
        body: Container(
            child: Stack(
          fit: StackFit.expand,
          children: [
            // head lines
            // Positioned.fill(
            //   top: 20,
            //   child: Align(
            //     alignment: Alignment.topLeft,
            //     child: Container(
            //       width: Get.width,
            //       padding: EdgeInsets.only(left: ChautariPadding.standard),
            //       child: Text(
            //         "Easily earn money with Chautari Basti",
            //         textAlign: TextAlign.start,
            //         style: ChautariTextStyles()
            //             .listTitle
            //             .copyWith(color: ChautariColors.tabYellow),
            //       ),
            //     ),
            //   ),
            // ),

            Positioned.fill(
              top: 70,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 200,
                  child: AspectRatio(

                      // padding: EdgeInsets.all(ChautariPadding.standard),
                      aspectRatio: 1050 / 679,
                      child: Image.asset("images/earn_money.png")),
                ),
              ),
            ),

            Positioned.fill(
              top: 300,
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: Get.width,
                  height: 50,
                  color: ChautariColors.black.withAlpha(20),
                  padding: EdgeInsets.all(ChautariPadding.standard),
                  child: Text(
                    "Earn more with Chautari Basti",
                    textAlign: TextAlign.start,
                    style: ChautariTextStyles().listTitle.copyWith(
                        color: Get.isDarkMode
                            ? ChautariColors.tabYellow
                            : ChautariColors.primary),
                  ),
                ),
              ),
            ),

            Positioned.fill(
              top: 350,
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: Get.width,
                  color: ChautariColors.black.withAlpha(20),
                  padding: EdgeInsets.all(ChautariPadding.standard),
                  child: Text(
                    "Earn more with Chautari Basti",
                    textAlign: TextAlign.start,
                    style: ChautariTextStyles().listTitle.copyWith(
                        color: Get.isDarkMode
                            ? ChautariColors.tabYellow
                            : ChautariColors.primary),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
