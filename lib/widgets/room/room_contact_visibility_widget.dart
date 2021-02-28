import 'package:chautari/utilities/theme/text_decoration.dart';
import 'package:chautari/utilities/theme/text_style.dart';
import 'package:chautari/widgets/top_down_space_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ContactNumberVisibilityWidget extends StatelessWidget {
  final bool initialValue;
  final FocusNode focusNode;
  final Function(bool value) onChanged;
  final ValueKey contactVisibilityKey;

  const ContactNumberVisibilityWidget(
      {Key key,
      @required this.initialValue,
      @required this.focusNode,
      @required this.onChanged,
      @required this.contactVisibilityKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopDownPaddingWrapper(
      child: FormBuilderSwitch(
        key: contactVisibilityKey,
        initialValue: initialValue,
        focusNode: focusNode,
        name: "contact_visibility",
        title: Text(
          "Let people contact you via phone",
          style: ChautariTextStyles().listSubtitle,
        ),
        onChanged: (value) => onChanged(value),
        decoration: ChautariDecoration().outlinedBorderTextField(),
      ),
    );
  }
}
