import 'package:chautari/forked/form_builder_image_picker.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/add_property/add_property_controller.dart';
import 'package:chautari/widgets/search/search.dart';
import 'package:chautari/widgets/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class AddProperty extends StatelessWidget {
  final SearchController search = Get.put(SearchController());
  final AddPropertyController addController = Get.put(AddPropertyController());
  final TextEditingController _districtTextController = TextEditingController();
  final FocusNode _districtFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();

  ScrollController _scrollController = new ScrollController();

  final _formKey = GlobalKey<FormBuilderState>();
  final _districtKey = ValueKey("district");
  final _addressKey = ValueKey("address");
  final _parkingKey = ValueKey("parking");

  @override
  Widget build(BuildContext context) {
    _openSearch() async {
      _districtFocusNode.unfocus();
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
      _addressFocusNode.unfocus();
      addController.openMap();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
      ),
      body: Container(
        padding: EdgeInsets.all(ChautariPadding.standard),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                SizedBox(height: ChautariPadding.standard),
                // district
                FormBuilderTextField(
                  key: _districtKey,
                  validator: FormBuilderValidators.required(context),
                  controller: _districtTextController,
                  focusNode: _districtFocusNode,
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
                  focusNode: _addressFocusNode,
                  name: "map_field",
                  style: ChautariTextStyles().listTitle,
                  decoration: ChautariDecoration().outlinedBorderTextField(
                      helperText: "local address name", labelText: "address"),
                  onTap: () => _openMap(),
                ),
                SizedBox(height: ChautariPadding.standard),

                // number of rooms
                FormBuilderTouchSpin(
                  addIcon: Icon(
                    Icons.add,
                    color: ChautariColors.whiteAndBlackcolor().withOpacity(0.5),
                  ),
                  subtractIcon: Icon(
                    Icons.remove,
                    color: ChautariColors.whiteAndBlackcolor().withOpacity(0.5),
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

                // parking
                FormBuilderCheckboxGroup(
                  key: _parkingKey,
                  validator: (value) {
                    return value == null ? "This field cannot be empty" : null;
                  },
                  decoration: ChautariDecoration().outlinedBorderTextField(
                    labelText: "parkings",
                    helperText: "Select all availabe options",
                  ),
                  name: "Checkbox",
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
                  wrapAlignment: WrapAlignment.spaceBetween,
                  wrapSpacing: Get.width,
                  decoration: ChautariDecoration().outlinedBorderTextField(
                    labelText: "Amenities",
                    helperText: "Select all availabe options",
                  ),
                  name: "Checkbox",
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
                  wrapSpacing: Get.width,
                  decoration: ChautariDecoration().outlinedBorderTextField(
                    labelText: "Water",
                    helperText: "Select one options",
                  ),
                  name: "Checkbox",
                  options: addController.waters
                      .map(
                        (element) =>
                            FormBuilderFieldOption(value: element.name),
                      )
                      .toList(),
                ),
                SizedBox(height: ChautariPadding.standard),

                // price
                FormBuilderTextField(
                  keyboardType: TextInputType.number,
                  name: "price",
                  decoration: ChautariDecoration().outlinedBorderTextField(
                      labelText: "Price", helperText: "price per month"),
                ),
                SizedBox(height: ChautariPadding.standard),

                // image
                FormBuilderImagePicker(
                  previewMargin: EdgeInsets.only(right: ChautariPadding.small5),
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
    );
  }
}
