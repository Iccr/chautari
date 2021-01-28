import 'package:chautari/model/menu_item.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/add_property/add_property_controller.dart';
import 'package:chautari/widgets/search/search.dart';
import 'package:chautari/widgets/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddProperty extends StatelessWidget {
  final SearchController search = Get.put(SearchController());
  final AddPropertyController addController = Get.put(AddPropertyController());
  final TextEditingController _districtTextController = TextEditingController();
  final FocusNode _noFocusNode = FocusNode();

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    _openSearch() async {
      _noFocusNode.unfocus();
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
      _noFocusNode.unfocus();
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
            child: Column(
              children: [
                // district
                FormBuilderTextField(
                  controller: _districtTextController,
                  focusNode: _noFocusNode,
                  name: "district_field",
                  style: ChautariTextStyles().listTitle,
                  decoration: ChautariDecoration().outlinedBorderTextField(
                      helperText: "Select District", labelText: "District"),
                  onTap: () => {
                    _openSearch(),
                  },
                ),
                SizedBox(height: ChautariPadding.standard),
                // address and map
                FormBuilderTextField(
                  controller: null,
                  focusNode: _noFocusNode,
                  name: "map_field",
                  style: ChautariTextStyles().listTitle,
                  decoration: ChautariDecoration()
                      .outlinedBorderTextField(helperText: "Select Address"),
                  onTap: () => _openMap(),
                ),
                SizedBox(height: ChautariPadding.standard),
                FormBuilderTouchSpin(
                  name: "noOfROoms",
                  min: 1,
                  max: 20,
                  initialValue: 0,
                  decoration: ChautariDecoration().outlinedBorderTextField(
                      labelText: "Number of rooms",
                      helperText: "Available number of rooms to rent"),
                ),
                SizedBox(height: ChautariPadding.standard),
                FormBuilderCheckboxGroup(
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

                FormBuilderRadioGroup(
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

                RaisedButton(
                  onPressed: () {},
                  child: Text("Submit"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
