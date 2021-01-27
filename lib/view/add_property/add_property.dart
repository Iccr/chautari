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
  final FocusNode _myFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    _openSearch() async {
      _myFocusNode.unfocus();
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

    Widget districtview() {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _openSearch(),
        child: Container(
          padding: EdgeInsets.only(
            left: ChautariPadding.standard,
            right: ChautariPadding.standard,
            top: ChautariPadding.standard,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                focusNode: _myFocusNode,
                decoration: ChautariDecoration()
                    .outlinedBorderTextField(hintText: "Select District"),
                style: ChautariTextStyles().listSubtitle,
                controller: _districtTextController,
                onTap: () async {
                  _openSearch();
                },
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
      ),
      body: Container(
        child: Column(
          children: [
            districtview(),
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
