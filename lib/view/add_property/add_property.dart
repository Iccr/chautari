import 'package:chautari/view/add_property/add_property_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AddProperty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
      ),
      body: GetBuilder<AddPropertyController>(
        init: AddPropertyController(),
        builder: (c) => Container(),
      ),
    );
  }
}
