import 'dart:io';

import 'package:chautari/forked/form_builder_image_picker.dart';
import 'package:chautari/utilities/loading/progress_hud.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/view/room/add_room/add_room_first_page.dart';
import 'package:chautari/view/room/add_room/add_room_fourth_page.dart';
import 'package:chautari/view/room/add_room/add_room_third_page.dart';
import 'package:chautari/view/room/add_room/add_room_second_page.dart';
import 'package:chautari/widgets/search/search.dart';
import 'package:chautari/widgets/search/search_controller.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class AddRoom extends StatelessWidget {
  final SearchController search = Get.put(SearchController());
  final AddRoomController addController = Get.put(AddRoomController());

  ScrollController _scrollController = new ScrollController();

  final _districtKey = ValueKey("district");
  final _addressKey = ValueKey("address");
  final _parkingKey = ValueKey("parking");
  final _amenityKey = ValueKey("amenity");
  final _waterKey = ValueKey("water");
  final _priceKey = ValueKey("price");
  final _contactKey = ValueKey("contact");
  final _typesKey = ValueKey("types");
  final _numberOfRoomsKey = ValueKey("_numberOfRoomsKey");

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: ChautariColors.black.withOpacity(0.3),
        nextFocus: false,
        actions: [
          KeyboardActionsItem(focusNode: addController.priceFocusNode),
          KeyboardActionsItem(focusNode: addController.contactFocusNode)
          // KeyboardActionsItem(focusNode: addController.n)
        ]);
  }

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

    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
      ),
      body: GetX<AddRoomController>(
          init: AddRoomController(),
          builder: (addController) {
            return ProgressHud(
              isLoading: addController.isLoading,
              child: Container(
                padding: EdgeInsets.all(ChautariPadding.standard),
                child: KeyboardActions(
                  overscroll: 50,
                  config: _buildConfig(context),
                  child: FormBuilder(
                    key: addController.formKey,
                    autovalidateMode: addController.autovalidateMode,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AddRoomForm1(
                          districtKey: _districtKey,
                          addressKey: _addressKey,
                          openSearch: () => _openSearch(),
                          openMap: () => _openMap(),
                        ),

                        AddRoomForm2(
                          contactKey: _contactKey,
                          pricekey: _priceKey,
                          numberkey: _numberOfRoomsKey,
                          scrollController: _scrollController,
                        ),

                        AddRoomForm3(
                          typesKey: _typesKey,
                          waterKey: _waterKey,
                        ),

                        AddRoomForm4(
                          parkingKey: _parkingKey,
                          amenityKey: _amenityKey,
                        ),

                        // submit
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
                        SizedBox(height: ChautariPadding.standard),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
