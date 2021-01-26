import 'package:chautari/model/menu_item.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/add_property/add_property_controller.dart';
import 'package:chautari/widgets/chautari_list.dart';
import 'package:chautari/widgets/search/search.dart';
import 'package:chautari/widgets/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              Text(
                "District",
                style: ChautariTextStyles().listTitle,
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                focusNode: _myFocusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Select district",
                ),
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

    var listItems = addController.listItems;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
        // actions: [
        //   IconButton(
        //       icon: Icon(LineIcons.search),
        //       onPressed: () {
        //         _openSearch();
        //       })
        // ],
      ),
      body: Container(
        child: ListView.separated(
          itemCount: listItems.length,
          separatorBuilder: (context, index) => ChautariList().getSeperator(),
          itemBuilder: (context, index) {
            var item = listItems.elementAt(index);
            return Container(
              child: (item.title == "District")
                  ? districtview()
                  : Container(
                      height: 100,
                    ),
            );
          },
        ),
      ),
    );
  }
}
