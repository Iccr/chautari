import 'package:chautari/model/menu_item.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/widgets/chautari_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class AddInfo extends StatelessWidget {
  const AddInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var menu1 =
        MenuItem(title: "It's Free", subtitle: "Add once, and Enjoy forever");
    var menu2 = MenuItem(
        title: "Reach More People",
        subtitle: "Your property will reach to more needy people than before");
    var menu3 = MenuItem(
        title: "Save Broker's Fee",
        subtitle:
            "No more paying to broker for your property. People will directly get connected with you");

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
                  height: 260,
                  width: Get.width,
                  padding: EdgeInsets.all(ChautariPadding.standard),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ChautariList().getListTile(
                        null,
                        menu1,
                        leading: Icon(
                          LineIcons.rupee,
                          color: ChautariColors.white,
                        ),
                      ),
                      ChautariList().getListTile(
                        null,
                        menu2,
                        leading: Icon(
                          Icons.people,
                          color: ChautariColors.white,
                        ),
                      ),
                      ChautariList().getListTile(
                        null,
                        menu3,
                        leading: Icon(
                          LineIcons.bank,
                          color: ChautariColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Positioned.fill(
              top: 610,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled))
                            return ChautariColors.tabYellow;
                          return ChautariColors.primary
                              .withAlpha(200); // Use the component's default.
                        },
                      ),
                    ),
                    onPressed: () {},
                    child: Text("Get Started"),
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
