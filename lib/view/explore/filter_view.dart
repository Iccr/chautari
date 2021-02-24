import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/explore/filter_controller.dart';
import 'package:chautari/view/room/my_rooms/my_room.dart';

import 'package:chautari/widgets/room/number_of_room_widget.dart';
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
            controller.searchModel.setDistrictName(district);
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Chautari Basti"),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(ChautariPadding.standard),
            height: Get.height,
            child: SingleChildScrollView(
              child: Obx(
                () => FormBuilder(
                  key: controller.formKeys.formKey,
                  child: Column(
                    children: [
                      Text(
                        "Fine tune your expectations...",
                        style: ChautariTextStyles().listSubtitle,
                      ),
                      // district
                      TopDownPaddingWrapper(
                        child: FormBuilderTextField(
                          key: controller.formKeys.districtKey,
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
                          key: controller.formKeys.addressKey,
                          initialValue: controller.searchModel.address,
                          focusNode: controller.focusNodes.addressFocusNode,
                          name: "map_field",
                          onChanged: (value) {
                            controller.searchModel.setAddress(value);
                          },
                          // onSaved: (newValue) {
                          //   // controller.apiModel.address = newValue;
                          // },
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
                        initialVaue: controller.searchModel.noOfRoom,
                        labelText: "Minimum number of rooms",
                        helperText: null,
                        numberOfroomKey: controller.formKeys.numberOfRoomsKey,
                        focusNode: controller.focusNodes.numberOfRoomsFocusNode,
                        onSaved: (value) => {},
                        onChanged: (value) {
                          controller.searchModel.setNoOfRoom(value);
                        },
                        // controller.room.numberOfRooms = value.toInt(),
                      ),

                      RoomPriceWidget(
                        initialValue: controller.searchModel.priceLower,
                        labelText: "Minimum price",
                        helperText: "Per month",
                        pricekey: controller.formKeys.minimumPriceKey,
                        focusNode: controller.focusNodes.minimumPriceFocusNode,
                        onTap: () =>
                            controller.focusNodes.priceFocusNode.requestFocus(),
                        onSaved: (value) => {},
                        onChanged: (value) {
                          var val = value.replaceAll(",", "");
                          controller.searchModel.setPriceLower(val);
                        },

                        // controller.room.price = value.replaceAll(",", ""),
                      ),

                      RoomPriceWidget(
                        initialValue: controller.searchModel.priceUpper,
                        labelText: "Maximum price",
                        helperText: "Per month",
                        pricekey: controller.formKeys.maximumPriceKey,
                        focusNode: controller.focusNodes.maximumPriceFocusNode,
                        onTap: () =>
                            controller.focusNodes.priceFocusNode.requestFocus(),
                        onSaved: (value) => {},
                        onChanged: (value) {
                          controller.searchModel.setPriceUpper(
                            value.replaceAll(",", ""),
                          );
                        },
                        // controller.room.price = ,
                      ),

                      // types
                      RoomTypesRadioWidget(
                        typesKey: controller.formKeys.typesKey,
                        initialValue: controller.searchModel.type,
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
                          controller.searchModel.setType(value);
                        },
                      ),

                      // water
                      RoomWaterRadioWidgets(
                        initialiValue: controller.searchModel.water,
                        waterKey: controller.formKeys.waterKey,
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
                          controller.searchModel.setWater(value);
                        },
                      ),

                      // parkings
                      // RoomParkingCheckBoxWidget(
                      //     parkingKey: controller.formKeys.parkingKey,
                      //     focusNode: controller.focusNodes.parkingFocusNode,
                      //     options: controller.appInfoService.appInfo.parkings
                      //         .map(
                      //           (element) => FormBuilderFieldOption(
                      //             value: element,
                      //             child: Text(element.name.capitalize),
                      //           ),
                      //         )
                      //         .toList(),
                      //     onSaved: (value) => {}),

                      // // amenity
                      // RoomAmenityCheckBoxWidget(
                      //   amenityKey: controller.formKeys.amenityKey,
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
}
