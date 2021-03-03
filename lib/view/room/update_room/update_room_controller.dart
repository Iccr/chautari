import 'package:chautari/model/room_model.dart';
import 'package:chautari/services/appinfo_service.dart';
import 'package:chautari/services/room_service.dart';

import 'package:chautari/utilities/NepaliRupeeTextFormatter.dart';
import 'package:chautari/utilities/api_service.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/view/room/form_keys.dart';
import 'package:chautari/view/room/room_form_focusnode.dart';
import 'package:chautari/widgets/alert.dart';
import 'package:chautari/widgets/keyboard_action.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';

class UpdateRoomController extends GetxController {
  RoomFormKeys formKeys = RoomFormKeys();
  RoomFocusNodes focusNodes = RoomFocusNodes();
  RoomModel room;
  ScrollController scrollController = ScrollController();

  KeyboardActionsConfig keyboardActionConfig;

  var isLoading = false.obs;
  var _error = "".obs;
  String get error => _error.value;

  RoomService roomService;

  List<String> get roomImages =>
      room.images.map((e) => BaseUrl().imageBaseUrl + e).toList();

  String get price =>
      NepaliRupeeFormatter().getDecoratedString(room.price ?? "");

  var contactNumberVisible = false.obs;
  AppInfoService appInfoService = Get.find();

  var updateNewImages = false.obs;

  List<dynamic> get initialParkingValue => room.parkings
      .map(
        (element) => element,
      )
      .toList();

  @override
  void onInit() {
    super.onInit();
    room = Get.arguments;
    roomService = Get.find();
    this.keyboardActionConfig = KeyboardAction().keyboardActionConfig(
      Get.context,
      List.from(
        [focusNodes.contactTextFocusNode, focusNodes.priceFocusNode],
      ),
    );

    contactNumberVisible.value = room.phoneVisibility;
  }

  updateRoom() {
    // autovalidateForm4Mode.value = AutovalidateMode.always;
    if (formKeys.formKey.currentState.validate()) {
      formKeys.formKey.currentState.save();

      _update();
    } else {
      var firstWidget =
          formKeys.form4Key.currentState.fields.entries.firstWhere(
        (element) => element.value.hasError,
      );
      Scrollable.ensureVisible(firstWidget.value.context);
    }
  }

  _update() async {
    isLoading.value = roomService.isLoading.value;
    await roomService.updateRoom(room);
    if (roomService.success.value) {
      isLoading.value = roomService.isLoading.value;
      await roomService.fetchMyRooms();

      // Get.offNamed(RouteName.myRooms);
      Get.until((route) => Get.currentRoute == RouteName.myRooms);
    }
  }

  showImageReplaceWarning() {
    Alert.show(
        title: "Warning!",
        message:
            "This will replace all current images of this room. Would you like to continue",
        onConfirm: () {
          updateNewImages.toggle();
          Get.back();
        });
  }

  showUpdateSuccess() {
    Alert.show(
        title: "Info!",
        message: "Updated version of this room is now in Chautari Basti",
        onConfirm: () {
          Get.back();
        });
  }
}
