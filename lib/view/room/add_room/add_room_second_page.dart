import 'dart:io';

import 'package:chautari/forked/form_builder_image_picker.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/view/room/add_room/add_room_controller.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class AddRoomForm2 extends StatelessWidget {
  final AddRoomController controller = Get.find();
  final GlobalKey<FormBuilderState> formkey;
  final ValueKey contactKey;
  final ValueKey pricekey;
  final ValueKey numberkey;
  final ScrollController scrollController;

  AddRoomForm2({
    @required this.formkey,
    @required this.scrollController,
    @required this.contactKey,
    @required this.pricekey,
    @required this.numberkey,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => KeyboardActions(
        disableScroll: false,
        overscroll: 50,
        config: controller.keyboardActionConfig(context),
        child: FormBuilder(
          key: formkey,
          autovalidateMode: controller.autovalidateForm2Mode.value,
          child: Column(
            children: [
              // number of rooms
              NumberOfRoomWidget(controller: controller),

              // price
              PriceWidget(pricekey: pricekey, controller: controller),

              // mobile visibility
              MobileVisibilityWidget(controller: controller),

              // contact number
              if (controller.contactNumberVisible.value) ...[
                ContactNumberWidget(
                    contactKey: contactKey, controller: controller)
              ],

              // image
              ImageWidget(
                  controller: controller, scrollController: scrollController),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactNumberWidget extends StatelessWidget {
  const ContactNumberWidget({
    Key key,
    @required this.contactKey,
    @required this.controller,
  }) : super(key: key);

  final ValueKey contactKey;
  final AddRoomController controller;

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderTextField(
        key: contactKey,

        validator: (value) {
          if (value == null) {
            return "This field cannot be empty";
          } else
            return null;
        },
        // inputFormatters: [NumericTextFormatter()],
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        focusNode: controller.focusNodes.contactTextFocusNode,
        name: "contact",
        onTap: () {
          print("contact tapped");
          controller.focusNodes.contactTextFocusNode.requestFocus();
        },
        decoration: ChautariDecoration().outlinedBorderTextField(
            prefix: Text("+977-"),
            labelText: "Contact Number",
            helperText: "If vissible people can call to this number"),

        onSaved: (newValue) {
          controller.apiModel.contactNumber = newValue;
        },
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
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

class MobileVisibilityWidget extends StatelessWidget {
  const MobileVisibilityWidget({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final AddRoomController controller;

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderSwitch(
        initialValue: controller.contactNumberVisible.value,
        focusNode: controller.focusNodes.contactSwitchFocusNode,
        name: "contact number",
        title: Text(
          "Let people contact you via phone",
          style: ChautariTextStyles().listSubtitle,
        ),
        onChanged: (value) {
          print(value);
          controller.setContactNumbervisibility(value);
        },
        decoration: ChautariDecoration().outlinedBorderTextField(),
      ),
    );
  }
}

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    Key key,
    @required this.pricekey,
    @required this.controller,
  }) : super(key: key);

  final ValueKey pricekey;
  final AddRoomController controller;

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderTextField(
        key: pricekey,
        validator: (value) {
          if (value == null) {
            return "This field cannot be empty";
          } else if (int.parse(
                  value.isEmpty ? "0" : value.replaceAll(",", "")) <
              100) {
            return "value must be greater than 100";
          } else {
            return null;
          }
        },
        inputFormatters: [NumericTextFormatter()],
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        focusNode: controller.focusNodes.priceFocusNode,
        name: "price",
        onTap: () {
          print("price tapped");
          controller.focusNodes.priceFocusNode.requestFocus();
        },
        decoration: ChautariDecoration().outlinedBorderTextField(
            prefix: Text("Rs. "),
            labelText: "Price",
            helperText: "price per month"),
        onSaved: (newValue) {
          print(newValue);
          controller.apiModel.price = newValue.replaceAll(",", "");
        },
      ),
    );
  }
}

class NumberOfRoomWidget extends StatelessWidget {
  const NumberOfRoomWidget({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final AddRoomController controller;

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderTouchSpin(
          textStyle: ChautariTextStyles().withBigText,
          focusNode: controller.focusNodes.numberOfRoomsFocusNode,
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
          initialValue: 1,
          displayFormat: NumberFormat("##"),
          decoration: ChautariDecoration().outlinedBorderTextField(
              labelText: "Number of rooms",
              helperText: "Available number of rooms to rent"),
          onSaved: (newValue) {
            print(newValue);
            controller.apiModel.numberOfRooms = newValue.toInt();
          }),
    );
  }
}

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
