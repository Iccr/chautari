import 'package:chautari/utilities/theme/text_decoration.dart';

import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ContactNumberWidget extends StatelessWidget {
  final FocusNode focusNode;
  final Function onTap;
  final Function(String value) onSaved;
  final ValueKey contactKey;

  const ContactNumberWidget(
      {Key key,
      @required this.contactKey,
      @required this.focusNode,
      @required this.onTap,
      @required this.onSaved})
      : super(key: key);

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
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        focusNode: focusNode,
        name: "contact",
        onTap: () => onTap(),
        decoration: ChautariDecoration().outlinedBorderTextField(
            prefix: Text("+977-"),
            labelText: "Contact Number",
            helperText: "If vissible people can call to this number"),
        onSaved: (newValue) => onSaved(newValue),
      ),
    );
  }
}
