import 'package:chautari/model/add_room_multipart_model.dart';
import 'package:chautari/model/amenity.dart';
import 'package:chautari/model/app_info.dart';
import 'package:chautari/model/districts.dart';
import 'package:chautari/model/menu_item.dart';
import 'package:chautari/model/parkings.dart';
import 'package:chautari/model/type.dart';
import 'package:chautari/model/water.dart';
import 'package:chautari/repository/rooms_repository.dart';
import 'package:chautari/utilities/constants.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/view/explore/explore_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class AddRoomController extends GetxController {
  final AppinfoModel appInfo = Get.find(tag: AppConstant.appinfomodelsKey);
  final ExploreController exploreController = Get.find();
  final CreateRoomApiRequestModel apiModel = CreateRoomApiRequestModel();

  var isValid = false;

  // observers
  var _isLoading = false.obs;
  var _error = "".obs;
  var addressError = "".obs;
  var _lat = 1000.0.obs;
  var _long = 1000.0.obs;
  var _contactNumberVisible = false.obs;
  // observable keys
  var _formKey = GlobalKey<FormBuilderState>().obs;
  var districtViewmodels = List<MenuItem>().obs;
  var _autovalidateMode = AutovalidateMode.disabled.obs;

// getters
  GlobalKey<FormBuilderState> get formKey => _formKey.value;
  List<Districts> get _districts => appInfo.districts;
  List<Water> get waters => appInfo.waters;
  List<Amenities> get amenities => appInfo.amenities;
  List<Parking> get parkings => appInfo.parkings;
  List<RoomType> get types => appInfo.types;
  AutovalidateMode get autovalidateMode => _autovalidateMode.value;

  bool get contactNumberVisible => _contactNumberVisible.value;

  bool get isLoading => _isLoading.value;
  String get error => _error.value;

  String get lat =>
      _lat.value.toString() == "1000.0" ? null : _lat.value?.toStringAsFixed(4);
  String get long => _long.value.toString() == "1000.0"
      ? null
      : _long.value?.toStringAsFixed(4);

  // properties

  final TextEditingController districtTextController = TextEditingController();
  final TextEditingController addressTextController = TextEditingController();
  //focus

  FocusNode districtFocusNode;
  FocusNode addressFocusNode;
  FocusNode priceFocusNode;
  FocusNode contactFocusNode;

// items
  var listItems = [
    MenuItem(title: "District"),
    MenuItem(title: "Address/map"),
    MenuItem(title: "Parkings"),
    MenuItem(title: "amenities"),
    MenuItem(title: "water"),
    MenuItem(title: "number of rooms"),
    MenuItem(title: "preferences"),
    MenuItem(title: "images")
  ];

  KeyboardActionsConfig keyboardActionConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: ChautariColors.black.withOpacity(0.3),
        nextFocus: false,
        actions: [
          KeyboardActionsItem(focusNode: priceFocusNode),
          KeyboardActionsItem(focusNode: contactFocusNode)
          // KeyboardActionsItem(focusNode: addController.n)
        ]);
  }

  // life cycles

  @override
  void onInit() {
    super.onInit();

    districtFocusNode = FocusNode();
    addressFocusNode = FocusNode();
    priceFocusNode = FocusNode();
    contactFocusNode = FocusNode();

    districtViewmodels.assignAll(
      _districts.map(
        (e) => MenuItem(title: e.name, subtitle: "${e.state}"),
      ),
    );
  }

  @override
  onClose() {
    super.onClose();
    // districtFocusNode.dispose();
    // addressFocusNode.dispose();
    // priceFocusNode.dispose();
  }

// setters

  setLatLng(double lat, double long) {
    _lat.value = lat;
    _long.value = long;
    apiModel.lat = lat;
    apiModel.long = long;
  }

// functions
  submit() async {
    _autovalidateMode.value = AutovalidateMode.always;

    if (formKey.currentState.validate()) {
      // TODo:- api call
      formKey.currentState.save();
      _isLoading.value = true;
      var model = await RoomsRepository().addRoom(
        await apiModel.toJson(),
      );
      if (model.errors == null) {
        print(model.room);
        _isLoading.value = false;
        // await exploreController.fetchRooms();
        // _isLoading.value = exploreController.isLoading;
        await showAlert(
          "Your property has been added for rent in chautari basti",
          title: "Chautari Basti",
          onConfirm: () {
            Get.back();
            Get.offAndToNamed(RouteName.myRooms);
          },
        );
      } else {
        _isLoading.value = false;
        String error = "";
        var errorObject = model.errors.first;
        if (errorObject.name.contains("lat") ||
            errorObject.name.contains("long")) {
          error =
              "Latitude and logitude is necessary for user to see your localit in map";
        } else {
          error = errorObject.value;
        }

        showAlert(error, onConfirm: () => Get.back());
      }
    } else {
      var firstWidget = formKey.currentState.fields.entries.firstWhere(
        (element) => element.value.hasError,
      );
      Scrollable.ensureVisible(firstWidget.value.context);
    }
  }

  showAlert(String message,
      {String title = "Alert", Function onConfirm, Function onCancel}) async {
    Get.defaultDialog(
      title: title,
      middleText: message,
      textConfirm: "Ok",
      confirmTextColor: ChautariColors.blackAndWhitecolor(),
      onConfirm: () async {
        onConfirm();
      },
      onCancel: onCancel,
    );
  }

  openMap() async {
    if (lat == null && long == null) {
      addressFocusNode.unfocus();
      var result = await Get.toNamed(RouteName.pickLocation);
      if (result?.latitude != null) {
        this._lat.value = result.latitude;
        this._long.value = result.longitude;
        apiModel.lat = result.latitude;
        apiModel.long = result.longitude;
        requestAddressFocus();
      }
    }
  }

  requestAddressFocus() async {
    if (lat != null) {
      await Future.delayed(Duration(milliseconds: 800));
      addressFocusNode.requestFocus();
    }
  }

  dismiss() {
    Get.back();
  }

  validateAddress() {}

  setContactNumbervisibility(bool val) {
    _contactNumberVisible.value = val;
  }
}
