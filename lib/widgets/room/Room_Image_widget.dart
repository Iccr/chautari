import 'dart:io';

import 'package:chautari/forked/form_builder_image_picker.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';

class RoomImageWidget extends StatelessWidget {
  final FocusNode focusNode;
  final Function(List<dynamic> value) onChange;
  final ScrollController scrollController;
  final Function(List<dynamic> value) onSaved;
  const RoomImageWidget({
    Key key,
    @required this.focusNode,
    @required this.onChange,
    @required this.onSaved,
    @required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderImagePicker(
        focusNode: focusNode,
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
        onChanged: (value) => onChange(value),
        onSaved: (newValue) => onSaved(newValue),
        decoration: ChautariDecoration().outlinedBorderTextField(
            labelText: 'Propery images',
            helperText: "Maximum 10 images are allowed"),
        maxImages: 15,
      ),
    );
  }
}
