import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RoomFormKeys {
  var formKey = GlobalKey<FormBuilderState>();
  var form1Key = GlobalKey<FormBuilderState>();
  var form2Key = GlobalKey<FormBuilderState>();
  var form3Key = GlobalKey<FormBuilderState>();
  var form4Key = GlobalKey<FormBuilderState>();

  var districtKey = ValueKey("district");
  var addressKey = ValueKey("address");
  var parkingKey = ValueKey("parking");
  var amenityKey = ValueKey("amenity");
  var waterKey = ValueKey("water");
  var priceKey = ValueKey("price");
  var contactKey = ValueKey("contact");
  var imageKey = ValueKey("image");
  var contactVisibilityKey = ValueKey("contactVisibilityKey");
  var typesKey = ValueKey("types");
  var numberOfRoomsKey = ValueKey("_numberOfRoomsKey");
}
