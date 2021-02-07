import 'dart:io';

import 'package:chautari/forked/form_builder_image_picker.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';

class RoomImageWidget extends StatelessWidget {
  const RoomImageWidget({
    Key key,
    @required this.controller,
    @required this.scrollController,
  }) : super(key: key);

  final AddRoomController controller;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderImagePicker(
        focusNode: controller.focusNodes.imageFocusNode,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "This field cannot be empty";
          } else
            return null;
        },
        bottomSheetPadding: EdgeInsets.only(bottom: ChautariPadding.huge),
        previewMargin: EdgeInsets.only(right: ChautariPadding.small5),
        previewWidth: 130,
        scrollController: scrollController,
        imageQuality: 40,
        name: "images",
        iconColor: ChautariColors.whiteAndPrimarycolor(),
        onChanged: (value) {
          print("on changed");
          print(value);
          scrollController.animateTo(
              scrollController.position.maxScrollExtent + 130,
              duration: Duration(milliseconds: 100),
              curve: Curves.easeInOut);
        },
        onSaved: (newValue) {
          print(newValue);
          var imageLIst = List<File>.from(newValue);
          controller.apiModel.images = imageLIst;
        },
        decoration: ChautariDecoration().outlinedBorderTextField(
            labelText: 'Propery images',
            helperText: "Maximum 10 images are allowed"),
        maxImages: 15,
      ),
    );
  }
}
