import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/explore/filter_controller.dart';
import 'package:chautari/view/room/my_rooms/my_room.dart';

import 'package:chautari/widgets/room/number_of_room_widget.dart';
import 'package:chautari/widgets/room/room_amenity_checkbox_widget.dart';
import 'package:chautari/widgets/room/room_parking_checkbox_widget.dart';
import 'package:chautari/widgets/room/room_price_widget.dart';
import 'package:chautari/widgets/room/room_type_radio_widgets.dart';
import 'package:chautari/widgets/room/room_water_radio_widgets.dart';
import 'package:chautari/widgets/search/search.dart';
import 'package:chautari/widgets/search/search_controller.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class FilterRoom extends StatelessWidget {
  FilterRoomController controller = Get.put(FilterRoomController());
  final SearchController search = Get.put(SearchController());
  // var priceRangeKey = ValueKey("priceRange");
  // var districtKey = ValueKey("priceRange");
  // var addressKey = ValueKey("priceRange");
  var priceRangeFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    _openSearch() async {
      controller.focusNodes.districtFocusNode.unfocus();
      var _ = await showSearch(
        context: context,
        delegate: SearchBar(
          items: search.districtViewModel,
          onSelected: (item) {
            var district = search.onSelectedDistrict(item);
            print(district);
            controller.districtTextController.text =
                "${district.name}, province: ${district.state}";
            controller.searchModel.value.setDistrictName(district);
          },
        ),
      );
    }

    Widget buildFilter() {
      return Scaffold(
        appBar: AppBar(
          title: Text("Chautari Basti"),
          actions: [
            IconButton(
              iconSize: 40,
              icon: Text(
                "Reset",
                style: ChautariTextStyles().listSubtitle,
              ),
              onPressed: () {
                controller.reset();
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(ChautariPadding.standard),
              height: Get.height,
              child: SingleChildScrollView(
                child: FormBuilder(
                  key: controller.searchModel.value.formKeys.formKey,
                  child: Column(
                    children: [
                      Text(
                        "Fine tune your expectations...",
                        style: ChautariTextStyles().listSubtitle,
                      ),
                      // district
                      TopDownPaddingWrapper(
                        child: FormBuilderTextField(
                          key:
                              controller.searchModel.value.formKeys.districtKey,
                          validator: FormBuilderValidators.required(context),
                          controller: controller.districtTextController,
                          focusNode: controller.focusNodes.districtFocusNode,
                          name: "district_field",
                          style: ChautariTextStyles().listSubtitle,
                          decoration:
                              ChautariDecoration().outlinedBorderTextField(
                            helperText: "Select District",
                            labelText: "District",
                          ),
                          onTap: () {
                            _openSearch();
                          },
                        ),
                      ),

                      // address
                      TopDownPaddingWrapper(
                        // top: 10,
                        child: FormBuilderTextField(
                          controller: controller.addressTextController,
                          key: controller.searchModel.value.formKeys.addressKey,
                          initialValue: controller.searchModel.value.address,
                          focusNode: controller.focusNodes.addressFocusNode,
                          name: "map_field",
                          onChanged: (value) {},
                          onSaved: (newValue) {
                            controller.searchModel.value.setAddress(newValue);
                          },
                          validator: (value) {
                            return value == null || value.isEmpty
                                ? "This field cannot be empty"
                                : null;
                          },
                          style: ChautariTextStyles().listSubtitle,
                          decoration: ChautariDecoration()
                              .outlinedBorderTextField(
                                  helperText: "Local address name",
                                  labelText: "address"),
                          // onTap: () => openMap(),
                        ),
                      ),

                      // number of rooms
                      NumberOfRoomWidget(
                        key: controller
                            .searchModel.value.formKeys.numberOfRoomsKey,
                        initialVaue:
                            controller.searchModel.value.intitialNoOfRoom,
                        labelText: "Minimum number of rooms",

                        helperText: null,
                        numberOfroomKey: controller
                            .searchModel.value.formKeys.numberOfRoomsKey,
                        focusNode: controller.focusNodes.numberOfRoomsFocusNode,
                        onSaved: (value) => {},
                        onChanged: (value) {
                          controller.searchModel.value.setNoOfRoom(value);
                        },
                        // controller.room.numberOfRooms = value.toInt(),
                      ),

                      RoomPriceWidget(
                        initialValue:
                            controller.searchModel.value.initialPriceLower,
                        name: "price_lower",
                        labelText: "Minimum price",
                        helperText: "Per month",
                        pricekey: controller
                            .searchModel.value.formKeys.minimumPriceKey,
                        focusNode: controller.focusNodes.minimumPriceFocusNode,
                        onTap: () =>
                            controller.focusNodes.priceFocusNode.requestFocus(),
                        onSaved: (value) => {},
                        onChanged: (value) {
                          var val = value.replaceAll(",", "");
                          controller.searchModel.value.setPriceLower(val);
                        },

                        // controller.room.price = value.replaceAll(",", ""),
                      ),

                      RoomPriceWidget(
                        initialValue:
                            controller.searchModel.value.intialPriceUpper,
                        name: "price_upper",
                        labelText: "Maximum price",
                        helperText: "Per month",
                        pricekey: controller
                            .searchModel.value.formKeys.maximumPriceKey,
                        focusNode: controller.focusNodes.maximumPriceFocusNode,
                        onTap: () =>
                            controller.focusNodes.priceFocusNode.requestFocus(),
                        onSaved: (value) => {},
                        onChanged: (value) {
                          controller.searchModel.value.setPriceUpper(
                            value.replaceAll(",", ""),
                          );
                        },
                        // controller.room.price = ,
                      ),

                      // types
                      RoomTypesRadioWidget(
                        typesKey:
                            controller.searchModel.value.formKeys.typesKey,
                        initialValue: controller.searchModel.value.initialType,
                        focusNode: controller.focusNodes.typeFocusNode,
                        options: controller.appInfoService.appInfo.types
                            .map(
                              (element) => FormBuilderFieldOption(
                                value: element,
                                child: Text(element.name.capitalize),
                              ),
                            )
                            .toList(),
                        onSaved: (value) => {},
                        onChanged: (value) {
                          controller.searchModel.value.setType(value);
                        },
                      ),

                      // water
                      RoomWaterRadioWidgets(
                        initialiValue:
                            controller.searchModel.value.initialWater,
                        waterKey:
                            controller.searchModel.value.formKeys.waterKey,
                        focusNode: controller.focusNodes.waterFocusNode,
                        options: controller.appInfoService.appInfo.waters
                            .map(
                              (element) => FormBuilderFieldOption(
                                value: element,
                                child: Text(element.name.capitalize),
                              ),
                            )
                            .toList(),
                        onSaved: (value) =>
                            {/*controller..apiModel.water = value*/},
                        onChanged: (value) {
                          controller.searchModel.value.setWater(value);
                        },
                      ),

                      // parkings
                      RoomParkingCheckBoxWidget(
                        initialValue:
                            controller.searchModel.value.initialParkings,
                        parkingKey:
                            controller.searchModel.value.formKeys.parkingKey,
                        focusNode: controller.focusNodes.parkingFocusNode,
                        options: controller.appInfoService.appInfo.parkings
                            .map(
                              (element) => FormBuilderFieldOption(
                                value: element,
                                child: Text(element.name.capitalize),
                              ),
                            )
                            .toList(),
                        onSaved: (value) => {},
                        onChanged: (value) {
                          controller.searchModel.value.setParkings(value);
                        },
                      ),

                      // amenity
                      // RoomAmenityCheckBoxWidget(
                      //   amenityKey:
                      //       controller.searchModel.value.formKeys.amenityKey,
                      //   focusNode: controller.focusNodes.parkingFocusNode,
                      //   options: controller.appInfoService.appInfo.amenities
                      //       .map(
                      //         (element) => FormBuilderFieldOption(
                      //           value: element,
                      //           child: Text(element.name.capitalize),
                      //         ),
                      //       )
                      //       .toList(),
                      //   onSaved: (value) => {},
                      // ),

                      SizedBox(
                        height: ChautariPadding.huge * 3,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  ChautariRaisedButton(
                    title: "Apply Filter ",
                    onPressed: () => {
                      controller.search(),
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Obx(
      () => controller.object.value ? Container() : buildFilter(),
    );
  }
}
