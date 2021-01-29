import 'package:chautari/forked/form_builder_image_picker.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/add_property/add_property_controller.dart';
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

class AddProperty extends StatelessWidget {
  final SearchController search = Get.put(SearchController());
  final AddPropertyController addController = Get.put(AddPropertyController());
  final TextEditingController _districtTextController = TextEditingController();

  ScrollController _scrollController = new ScrollController();

  final _formKey = GlobalKey<FormBuilderState>();
  final _districtKey = ValueKey("district");
  final _addressKey = ValueKey("address");
  final _parkingKey = ValueKey("parking");
  final _amenityKey = ValueKey("amenity");
  final _waterKey = ValueKey("water");
  final _priceKey = ValueKey("price");

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: ChautariColors.black.withOpacity(0.3),
        nextFocus: false,
        actions: [
          KeyboardActionsItem(focusNode: addController.priceFocusNode)
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
            _districtTextController.text =
                "${district.name}, province: ${district.state}";
          },
        ),
      );
    }

    _openMap() {
      addController.addressFocusNode.unfocus();
      addController.openMap();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
      ),
      body: Container(
        padding: EdgeInsets.all(ChautariPadding.standard),
        child: KeyboardActions(
          config: _buildConfig(context),
          child: SingleChildScrollView(
            child: FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                children: [
                  SizedBox(height: ChautariPadding.standard),
                  // district
                  FormBuilderTextField(
                    key: _districtKey,
                    validator: FormBuilderValidators.required(context),
                    controller: _districtTextController,
                    focusNode: addController.districtFocusNode,
                    name: "district_field",
                    style: ChautariTextStyles().listTitle,
                    decoration: ChautariDecoration().outlinedBorderTextField(
                      helperText: "Select District",
                      labelText: "District",
                    ),
                    onTap: () {
                      _openSearch();
                    },
                  ),
                  SizedBox(height: ChautariPadding.standard),
                  // address and map

                  FormBuilderTextField(
                    controller: null,
                    focusNode: addController.addressFocusNode,
                    name: "map_field",
                    style: ChautariTextStyles().listTitle,
                    decoration: ChautariDecoration().outlinedBorderTextField(
                        helperText: "local address name", labelText: "address"),
                    onTap: () => _openMap(),
                  ),
                  SizedBox(height: ChautariPadding.standard),

                  // parking
                  FormBuilderCheckboxGroup(
                    key: _parkingKey,
                    validator: (value) {
                      return value == null
                          ? "This field cannot be empty"
                          : null;
                    },
                    decoration: ChautariDecoration().outlinedBorderTextField(
                      labelText: "parkings",
                      helperText: "Select all availabe options",
                    ),
                    name: "parking",
                    options: addController.parkings
                        .map(
                          (element) =>
                              FormBuilderFieldOption(value: element.name),
                        )
                        .toList(),
                  ),

                  SizedBox(height: ChautariPadding.standard),

                  // amenity
                  FormBuilderCheckboxGroup(
                    key: _amenityKey,
                    validator: (value) {
                      return value == null
                          ? "This field cannot be empty"
                          : null;
                    },
                    wrapAlignment: WrapAlignment.spaceBetween,
                    wrapSpacing: Get.width,
                    decoration: ChautariDecoration().outlinedBorderTextField(
                      labelText: "Amenities",
                      helperText: "Select all availabe options",
                    ),
                    name: "amenity",
                    options: addController.amenities
                        .map(
                          (element) =>
                              FormBuilderFieldOption(value: element.name),
                        )
                        .toList(),
                  ),

                  SizedBox(height: ChautariPadding.standard),

                  // water
                  FormBuilderRadioGroup(
                    key: _waterKey,
                    wrapSpacing: Get.width,
                    validator: (value) {
                      return value == null
                          ? "This field cannot be empty"
                          : null;
                    },
                    decoration: ChautariDecoration().outlinedBorderTextField(
                      labelText: "Water",
                      helperText: "Select one options",
                    ),
                    name: "water",
                    options: addController.waters
                        .map(
                          (element) =>
                              FormBuilderFieldOption(value: element.name),
                        )
                        .toList(),
                  ),
                  SizedBox(height: ChautariPadding.standard),

                  // number of rooms
                  FormBuilderTouchSpin(
                    addIcon: Icon(
                      Icons.add,
                      color:
                          ChautariColors.whiteAndBlackcolor().withOpacity(0.5),
                    ),
                    subtractIcon: Icon(
                      Icons.remove,
                      color:
                          ChautariColors.whiteAndBlackcolor().withOpacity(0.5),
                    ),
                    name: "noOfROoms",
                    min: 1,
                    max: 20,
                    initialValue: 0,
                    displayFormat: NumberFormat("##"),
                    decoration: ChautariDecoration().outlinedBorderTextField(
                        labelText: "Number of rooms",
                        helperText: "Available number of rooms to rent"),
                  ),
                  SizedBox(height: ChautariPadding.standard),

                  // price
                  FormBuilderTextField(
                    key: _priceKey,
                    validator: (value) {
                      if (value == null) {
                        return "This field cannot be empty";
                      } else if (int.parse(value.isEmpty ? "0" : value) < 100) {
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
                    decoration: ChautariDecoration().outlinedBorderTextField(
                        labelText: "Price", helperText: "price per month"),
                  ),
                  SizedBox(height: ChautariPadding.standard),

                  // image
                  FormBuilderImagePicker(
                    previewMargin:
                        EdgeInsets.only(right: ChautariPadding.small5),
                    previewWidth: 130,
                    scrollController: _scrollController,
                    imageQuality: 40,
                    name: "images",
                    iconColor: ChautariColors.whiteAndPrimarycolor(),
                    onChanged: (value) {
                      print("on changed");
                      print(value.length);
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent + 130,
                          duration: Duration(milliseconds: 100),
                          curve: Curves.easeInOut);
                    },
                    decoration: ChautariDecoration().outlinedBorderTextField(
                        labelText: 'Propery images',
                        helperText: "Maximum 10 images are allowed"),
                    maxImages: 15,
                  ),

                  // submit
                  RaisedButton(
                    onPressed: () {
                      _formKey.currentState.save();
                      if (_formKey.currentState.validate()) {
                        print(_formKey.currentState.value);
                      } else {
                        var firstWidget =
                            _formKey.currentState.fields.entries.firstWhere(
                          (element) => element.value.hasError,
                        );
                        Scrollable.ensureVisible(firstWidget.value.context);
                      }
                    },
                    child: Text("Submit"),
                  ),
                  SizedBox(height: ChautariPadding.standard),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
