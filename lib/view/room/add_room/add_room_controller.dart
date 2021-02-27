import 'package:chautari/model/add_room_multipart_model.dart';
import 'package:chautari/model/menu_item.dart';
import 'package:chautari/repository/rooms_repository.dart';
import 'package:chautari/services/appinfo_service.dart';
import 'package:chautari/services/room_service.dart';
import 'package:chautari/utilities/constants.dart';
import 'package:chautari/utilities/router/router_name.dart';
import 'package:chautari/view/explore/explore_controller.dart';
import 'package:chautari/view/room/form_keys.dart';
import 'package:chautari/view/room/room_form_focusnode.dart';
import 'package:chautari/widgets/alert.dart';
import 'package:chautari/widgets/keyboard_action.dart';
import 'package:chautari/widgets/snack_bar.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class AddRoomController extends GetxController {
  final AppInfoService appInfoService = Get.find();
  final ExploreController exploreController = Get.find();
  final CreateRoomApiRequestModel apiModel = CreateRoomApiRequestModel();

  final PageController pageController = PageController();
  RoomService fetchRoomService;

  var isValid = false;

  // observers
  var isLoading = false.obs;
  var _error = "".obs;
  var addressError = "".obs;
  var _lat = 1000.0.obs;
  var _long = 1000.0.obs;
  var contactNumberVisible = true.obs;

  var pageoffset = 0.0.obs;
  // observable keys

  RoomFormKeys formKeys = RoomFormKeys();
  RoomFocusNodes focusNodes = RoomFocusNodes();

  var districtViewmodels = List<MenuItem>().obs;

  var autovalidateMode = AutovalidateMode.disabled.obs;
  var autovalidateForm1Mode = AutovalidateMode.disabled.obs;
  var autovalidateForm2Mode = AutovalidateMode.disabled.obs;
  var autovalidateForm3Mode = AutovalidateMode.disabled.obs;
  var autovalidateForm4Mode = AutovalidateMode.disabled.obs;

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

  // KeyboardActionsConfig keyboardActionConfig(BuildContext context) {
  //   return KeyboardActionsConfig(
  //       keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
  //       keyboardBarColor: ChautariColors.black.withOpacity(0.3),
  //       nextFocus: false,
  //       actions: [
  //         KeyboardActionsItem(focusNode: focusNodes.priceFocusNode),
  //         KeyboardActionsItem(focusNode: focusNodes.contactTextFocusNode)
  //         // KeyboardActionsItem(focusNode: addController.n)
  //       ]);
  // }
  KeyboardActionsConfig keyboardActionConfig;

  // life cycles

  @override
  void onInit() async {
    super.onInit();
    var result = await DataConnectionChecker().hasConnection;
    if (!result) {
      ChautariSnackBar.showNoInternetMesage(AppConstant.noInternetMessage);
    }
    fetchRoomService = Get.find();
    this.keyboardActionConfig = KeyboardAction().keyboardActionConfig(
      Get.context,
      List.from(
        [focusNodes.contactTextFocusNode, focusNodes.priceFocusNode],
      ),
    );
    _setupDistrictViewModel();
  }

  _setupDistrictViewModel() {
    districtViewmodels.assignAll(
      appInfoService.appInfo.districts.map(
        (e) => MenuItem(title: e.name, subtitle: "${e.state}"),
      ),
    );
  }

  setLatLng(double lat, double long) {
    _lat.value = lat;
    _long.value = long;
    apiModel.lat = lat;
    apiModel.long = long;
  }

  submitPage1() {
    autovalidateForm1Mode.value = AutovalidateMode.always;
    if (formKeys.form1Key.currentState.validate()) {
      formKeys.form1Key.currentState.save();

      _goToNextPage();
    } else {
      var firstWidget =
          formKeys.form1Key.currentState.fields.entries.firstWhere(
        (element) => element.value.hasError,
      );
      Scrollable.ensureVisible(firstWidget.value.context);
    }
  }

  submitPage2() {
    autovalidateForm2Mode.value = AutovalidateMode.always;
    if (formKeys.form2Key.currentState.validate()) {
      formKeys.form2Key.currentState.save();
      _goToNextPage();
    } else {
      var firstWidget =
          formKeys.form2Key.currentState.fields.entries.firstWhere(
        (element) => element.value.hasError,
      );
      Scrollable.ensureVisible(firstWidget.value.context);
    }
  }

  submitPage3() {
    autovalidateForm3Mode.value = AutovalidateMode.always;
    if (formKeys.form3Key.currentState.validate()) {
      formKeys.form3Key.currentState.save();
      _goToNextPage();
    } else {
      var firstWidget =
          formKeys.form3Key.currentState.fields.entries.firstWhere(
        (element) => element.value.hasError,
      );
      Scrollable.ensureVisible(firstWidget.value.context);
    }
  }

  submitPage4() {
    autovalidateForm4Mode.value = AutovalidateMode.always;
    if (formKeys.form4Key.currentState.validate()) {
      formKeys.form4Key.currentState.save();

      _submit();
    } else {
      var firstWidget =
          formKeys.form4Key.currentState.fields.entries.firstWhere(
        (element) => element.value.hasError,
      );
      Scrollable.ensureVisible(firstWidget.value.context);
    }
  }

  _goToNextPage() {
    pageController.nextPage(
        duration: Duration(milliseconds: 333), curve: Curves.easeInOut);
  }

// functions
  submit() {
    print(pageController.page);
    int page = pageController.page.toInt();
    switch (page) {
      case 0:
        submitPage1();
        break;
      case 1:
        submitPage2();
        break;
      case 2:
        submitPage3();
        break;
      case 3:
        submitPage4();
        break;
    }
  }

  _submit() async {
    isLoading.value = true;
    var model = await RoomsRepository().addRoom(
      await apiModel.toJson(),
    );
    if (model.errors == null) {
      print(model.room);
      isLoading.value = false;

      fetchRoomService.fetchRooms();

      await Alert.show(
        message: "Your property has been added for rent in chautari Basti",
        onConfirm: () {
          Get.back();
          Get.offAndToNamed(RouteName.myRooms);
        },
        onCancel: null,
        textCancel: null,
      );
    } else {
      isLoading.value = false;
      String error = "";
      var errorObject = model.errors.first;
      if (errorObject.name.contains("lat") ||
          errorObject.name.contains("long")) {
        error =
            "Latitude and logitude is necessary for user to see your localit in map";
      } else {
        error = errorObject.value;
      }

      Alert.show(
        message: error,
      );
    }
  }

  openMap() async {
    focusNodes.addressFocusNode.unfocus();
    var result = await Get.toNamed(RouteName.pickLocation);
    this._lat.value = result.latitude;
    this._long.value = result.longitude;
    apiModel.lat = result.latitude;
    apiModel.long = result.longitude;
    requestAddressFocus();
  }

  onAddressTap() async {
    if (lat == null && long == null) {
      openMap();
    }
  }

  requestAddressFocus() async {
    if (lat != null) {
      await Future.delayed(Duration(milliseconds: 800));
      focusNodes.addressFocusNode.requestFocus();
    }
  }

  dismiss() {
    Get.back();
  }

  validateAddress() {}

  setContactNumbervisibility(bool val) {
    contactNumberVisible.value = val;
  }

  setPageOffset(int val) {
    pageoffset.value = val.toDouble();
  }
}
