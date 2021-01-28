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
        child: Column(
          children: [
            // districtview(),
            FormBuilder(
              child: Column(
                children: [
                  FormBuilderTextField(
                    controller: _districtTextController,
                    focusNode: _noFocusNode,
                    name: "district_field",
                    style: ChautariTextStyles().listTitle,
                    decoration: ChautariDecoration()
                        .outlinedBorderTextField(hintText: "Select District"),
                    onTap: () => {
                      _openSearch(),
                    },
                  ),
                  FormBuilderTextField(
                    controller: _districtTextController,
                    focusNode: _noFocusNode,
                    name: "map_field",
                    style: ChautariTextStyles().listTitle,
                    decoration: ChautariDecoration()
                        .outlinedBorderTextField(hintText: "Select Address"),
                    onTap: () => _openMap(),
                  ),
                ],
              ),
            ),

            RaisedButton(
              onPressed: () {},
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
