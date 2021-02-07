import 'package:chautari/utilities/loading/progress_hud.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/view/room/add_room/add_room_first_page.dart';
import 'package:chautari/view/room/add_room/add_room_fourth_page.dart';
import 'package:chautari/view/room/add_room/add_room_third_page.dart';
import 'package:chautari/view/room/add_room/add_room_second_page.dart';
import 'package:chautari/widgets/keyboard_visibility_builder.dart';
import 'package:chautari/widgets/search/search.dart';
import 'package:chautari/widgets/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRoom extends StatelessWidget {
  final SearchController search = Get.put(SearchController());
  final AddRoomController addController = Get.put(AddRoomController());

  final ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    _openSearch() async {
      addController.districtFocusNode.unfocus();
      var _ = await showSearch(
        context: context,
        delegate: SearchBar(
          items: search.districtViewModel,
          onSelected: (item) {
            var district = search.onSelectedDistrict(item);
            print(district);
            addController.districtTextController.text =
                "${district.name}, province: ${district.state}";
            addController.apiModel.district = district.id;
          },
        ),
      );
    }

    _openMap() {
      addController.openMap();
    }

    List<Widget> _getPagerContents() {
      return [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AddRoomForm1(
            formKey: addController.form1Key,
            districtKey: addController.districtKey,
            addressKey: addController.addressKey,
            openSearch: () => _openSearch(),
            openMap: () => _openMap(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AddRoomForm2(
            formkey: addController.form2Key,
            contactKey: addController.contactKey,
            pricekey: addController.priceKey,
            numberkey: addController.numberOfRoomsKey,
            scrollController: _scrollController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AddRoomForm3(
            formkey: addController.form3Key,
            typesKey: addController.typesKey,
            waterKey: addController.waterKey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AddRoomForm4(
            parkingKey: addController.parkingKey,
            amenityKey: addController.amenityKey,
          ),
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
      ),
      body: GetX<AddRoomController>(
          init: AddRoomController(),
          builder: (addController) {
            return ProgressHud(
              isLoading: addController.isLoading.value,
              child: Container(
                padding: EdgeInsets.all(ChautariPadding.standard),
                child: Column(
                  children: [
                    Expanded(
                        child: PageView.builder(
                            controller: addController.pageController,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _getPagerContents().length,
                            itemBuilder: (context, index) {
                              return _getPagerContents().elementAt(index);
                            })),

                    // submit
                    KeyboardVisibilityBuilder(
                      builder: (context, child, isKeyboardVisible) => Column(
                        children: [
                          if (!isKeyboardVisible) ...[
                            RaisedButton(
                              color: ChautariColors.primaryColor(),
                              onPressed: () {
                                addController.submit();
                              },
                              child: Text(
                                "Submit",
                                style: ChautariTextStyles()
                                    .normal
                                    .copyWith(color: ChautariColors.white),
                              ),
                            ),
                          ],
                          SizedBox(height: ChautariPadding.standard),
                        ],
                      ),
                    )
                  ],
                ),
                // ),
              ),
            );
          }),
    );
  }
}
