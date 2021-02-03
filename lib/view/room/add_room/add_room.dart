import 'dart:io';

import 'package:chautari/forked/form_builder_image_picker.dart';
import 'package:chautari/utilities/loading/progress_hud.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/widgets/search/search.dart';
import 'package:chautari/widgets/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      final f = NumberFormat("##,##,###");
      final number =
          int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final newString = f.format(number);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}

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
                        // district
                        TopDownPaddingWrapper(
                          shouldHideTopPadding: true,
                          child: FormBuilderTextField(
                            key: _districtKey,
                            validator: FormBuilderValidators.required(context),
                            controller: addController.districtTextController,
                            focusNode: addController.districtFocusNode,
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
                        // address and map
                        if (addController.lat != null &&
                            addController.long != null) ...[
                          TopDownPaddingWrapper(
                            shouldHideBottomPadding: true,
                            child: Text(
                              "Latitude: ${addController.lat}, Longitude: ${addController.long}",
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                        TopDownPaddingWrapper(
                          child: Text.rich(
                            TextSpan(
                              style: ChautariTextStyles().listSubtitle,
                              children: [
                                TextSpan(
                                  text:
                                      "People will be serching with this address.",
                                  style: ChautariTextStyles()
                                      .listSubtitle
                                      .copyWith(
                                          color: ChautariColors
                                                  .whiteAndPrimarycolor()
                                              .withOpacity(0.8)),
                                ),
                                TextSpan(
                                  text:
                                      "Try to make it as accurate as possible",
                                  style: ChautariTextStyles()
                                      .listSubtitle
                                      .copyWith(
                                          color: ChautariColors
                                                  .whiteAndPrimarycolor()
                                              .withOpacity(0.8)),
                                ),
                              ],
                            ),
                          ),
                        ),

                        TopDownPaddingWrapper(
                          child: FormBuilderTextField(
                            key: _addressKey,
                            controller: addController.addressTextController,
                            focusNode: addController.addressFocusNode,
                            name: "map_field",
                            onSaved: (newValue) {
                              print(newValue);
                              addController.apiModel.address = newValue;
                            },
                            validator: (value) {
                              return value == null || value.isEmpty
                                  ? "This field cannot be empty"
                                  : null;
                            },
                            style: ChautariTextStyles().listSubtitle,
                            decoration: ChautariDecoration()
                                .outlinedBorderTextField(
                                    helperText: "local address name",
                                    labelText: "address"),
                            onTap: () => _openMap(),
                          ),
                        ),

                        // number of rooms
                        TopDownPaddingWrapper(
                          child: FormBuilderTouchSpin(
                              textStyle: ChautariTextStyles().withBigText,
                              addIcon: Icon(
                                Icons.add,
                                color: ChautariColors.whiteAndBlackcolor()
                                    .withOpacity(0.5),
                              ),
                              subtractIcon: Icon(
                                Icons.remove,
                                color: ChautariColors.whiteAndBlackcolor()
                                    .withOpacity(0.5),
                              ),
                              name: "noOfROoms",
                              min: 1,
                              max: 20,
                              initialValue: 0,
                              displayFormat: NumberFormat("##"),
                              decoration: ChautariDecoration()
                                  .outlinedBorderTextField(
                                      labelText: "Number of rooms",
                                      helperText:
                                          "Available number of rooms to rent"),
                              onSaved: (newValue) {
                                print(newValue);
                                addController.apiModel.numberOfRooms =
                                    newValue.toInt();
                              }),
                        ),

                        // price
                        TopDownPaddingWrapper(
                          child: FormBuilderTextField(
                            key: _priceKey,
                            validator: (value) {
                              if (value == null) {
                                return "This field cannot be empty";
                              } else if (int.parse(value.isEmpty
                                      ? "0"
                                      : value.replaceAll(",", "")) <
                                  100) {
                                return "value must be greater than 100";
                              } else {
                                return null;
                              }
                            },
                            inputFormatters: [NumericTextFormatter()],
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            focusNode: addController.priceFocusNode,
                            name: "price",
                            onTap: () {
                              print("price tapped");
                              addController.priceFocusNode.requestFocus();
                            },
                            decoration: ChautariDecoration()
                                .outlinedBorderTextField(
                                    prefix: Text("Rs. "),
                                    labelText: "Price",
                                    helperText: "price per month"),
                            onSaved: (newValue) {
                              print(newValue);
                              addController.apiModel.price =
                                  newValue.replaceAll(",", "");
                            },
                          ),
                        ),

                        // mobile visibility
                        TopDownPaddingWrapper(
                          child: FormBuilderSwitch(
                            initialValue: addController.contactNumberVisible,
                            name: "contact number",
                            title: Text(
                              "Let people contact you via phone",
                              style: ChautariTextStyles().listSubtitle,
                            ),
                            onChanged: (value) {
                              print(value);
                              addController.setContactNumbervisibility(value);
                            },
                            decoration:
                                ChautariDecoration().outlinedBorderTextField(),
                          ),
                        ),

                        // contact number
                        if (addController.contactNumberVisible) ...[
                          TopDownPaddingWrapper(
                            child: FormBuilderTextField(
                              key: _contactKey,

                              validator: (value) {
                                if (value == null) {
                                  return "This field cannot be empty";
                                } else
                                  return null;
                              },
                              // inputFormatters: [NumericTextFormatter()],
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.done,
                              focusNode: addController.contactFocusNode,
                              name: "contact",
                              onTap: () {
                                print("contact tapped");
                                addController.contactFocusNode.requestFocus();
                              },
                              decoration: ChautariDecoration()
                                  .outlinedBorderTextField(
                                      prefix: Text("+977-"),
                                      labelText: "Contact Number",
                                      helperText:
                                          "If vissible people can call to this number"),

                              onSaved: (newValue) {
                                addController.apiModel.contactNumber = newValue;
                              },
                            ),
                          )
                        ],

                        // image
                        TopDownPaddingWrapper(
                          child: FormBuilderImagePicker(
                            bottomSheetPadding:
                                EdgeInsets.only(bottom: ChautariPadding.huge),
                            previewMargin:
                                EdgeInsets.only(right: ChautariPadding.small5),
                            previewWidth: 130,
                            scrollController: _scrollController,
                            imageQuality: 40,
                            name: "images",
                            iconColor: ChautariColors.whiteAndPrimarycolor(),
                            onChanged: (value) {
                              print("on changed");
                              print(value);
                              _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent +
                                      130,
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.easeInOut);
                            },
                            onSaved: (newValue) {
                              print(newValue);
                              var imageLIst = List<File>.from(newValue);

                              addController.apiModel.images = imageLIst;
                            },
                            decoration: ChautariDecoration()
                                .outlinedBorderTextField(
                                    labelText: 'Propery images',
                                    helperText:
                                        "Maximum 10 images are allowed"),
                            maxImages: 15,
                          ),
                        ),

                        // types
                        TopDownPaddingWrapper(
                          child: FormBuilderRadioGroup(
                              key: _typesKey,
                              wrapSpacing: Get.width,
                              validator: (value) {
                                return value == null
                                    ? "This field cannot be empty"
                                    : null;
                              },
                              decoration:
                                  ChautariDecoration().outlinedBorderTextField(
                                labelText: "Type",
                                helperText: "Select one options",
                              ),
                              name: "Type",
                              options: addController.types
                                  .map(
                                    (element) => FormBuilderFieldOption(
                                      value: element,
                                      child: Text(element.name.capitalize),
                                    ),
                                  )
                                  .toList(),
                              onSaved: (newValue) {
                                print(newValue);
                                addController.apiModel.type = newValue;
                              }),
                        ),

                        // water
                        TopDownPaddingWrapper(
                          child: FormBuilderRadioGroup(
                              key: _waterKey,
                              wrapSpacing: Get.width,
                              validator: (value) {
                                return value == null
                                    ? "This field cannot be empty"
                                    : null;
                              },
                              decoration:
                                  ChautariDecoration().outlinedBorderTextField(
                                labelText: "Water",
                                helperText: "Select one options",
                              ),
                              name: "water",
                              options: addController.waters
                                  .map(
                                    (element) => FormBuilderFieldOption(
                                      value: element,
                                      child: Text(element.name.capitalize),
                                    ),
                                  )
                                  .toList(),
                              onSaved: (newValue) {
                                print(newValue);
                                addController.apiModel.water = newValue;
                              }),
                        ),

                        // parking
                        TopDownPaddingWrapper(
                          child: FormBuilderCheckboxGroup(
                            key: _parkingKey,
                            validator: (value) {
                              return value == null
                                  ? "This field cannot be empty"
                                  : null;
                            },
                            decoration:
                                ChautariDecoration().outlinedBorderTextField(
                              labelText: "parkings",
                              helperText: "Select all availabe options",
                            ),
                            name: "parking",
                            options: addController.parkings
                                .map(
                                  (element) => FormBuilderFieldOption(
                                    value: element,
                                    child: Text(element.name.capitalize),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              print("parking value $value");
                            },
                            onSaved: (newValue) {
                              print(newValue);
                              addController.apiModel.parkings = newValue;
                            },
                          ),
                        ),

                        // amenity
                        TopDownPaddingWrapper(
                          child: FormBuilderCheckboxGroup(
                              key: _amenityKey,
                              validator: (value) {
                                return value == null
                                    ? "This field cannot be empty"
                                    : null;
                              },
                              wrapAlignment: WrapAlignment.spaceBetween,
                              wrapSpacing: Get.width,
                              decoration:
                                  ChautariDecoration().outlinedBorderTextField(
                                labelText: "Amenities",
                                helperText: "Select all availabe options",
                              ),
                              name: "amenity",
                              options: addController.amenities
                                  .map(
                                    (element) => FormBuilderFieldOption(
                                      value: element,
                                      child: Text(element.name.capitalize),
                                    ),
                                  )
                                  .toList(),
                              onSaved: (newValue) {
                                print(newValue);
                                addController.apiModel.amenities = newValue;
                              }),
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

class TopDownPaddingWrapper extends StatelessWidget {
  final bool shouldHideTopPadding;
  final bool shouldHideBottomPadding;
  Widget child;
  TopDownPaddingWrapper(
      {this.child,
      this.shouldHideTopPadding = false,
      this.shouldHideBottomPadding = false});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (shouldHideTopPadding) ...[SizedBox(height: ChautariPadding.standard)],
      child,
      SizedBox(height: ChautariPadding.standard),
    ]);
  }
}
