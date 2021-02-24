import 'package:chautari/model/menu_item.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/widgets/chautari_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBar extends SearchDelegate<MenuItem> {
  List<MenuItem> items;
  MenuItem selected;
  Function onSelected;

  SearchBar({@required this.items, @required this.onSelected});

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith(
      textTheme: TextTheme(
        headline6: TextStyle(fontSize: 18.0, color: ChautariColors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
      ),
    );

    return theme;
  }

  @override
  TextStyle get searchFieldStyle => ChautariTextStyles().search;

  @override
  String get searchFieldLabel => "Search...";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.close),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (selected != null) {
      Get.back(result: selected);
    }
    return Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print(query);
    var filteredItems = query.isEmpty
        ? items
        : items
            .where(
              (element) => element.title.toLowerCase().startsWith(
                    query.toLowerCase(),
                  ),
            )
            .toList();
    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: filteredItems.length,
      separatorBuilder: (context, index) => ChautariList().getSeperator(),
      itemBuilder: (context, index) {
        var selected = filteredItems.elementAt(index);
        return ChautariList().getListTile(
          () async {
            // await Future.delayed(Duration(seconds: 1));
            close(
              context,
              selected,
            );
            onSelected(selected);
          },
          selected,
        );
      },
    );
  }
}
