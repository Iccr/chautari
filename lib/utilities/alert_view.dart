import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AlertDialog showAndroidAlertDialog(BuildContext context,
    {String title,
    String message,
    String defaultActionTitle = "Cancel",
    String actionButtonTitle = "",
    Color actionButtonColor,
    Function onDefaultActionButtonPressed,
    bool shouleShowActionButton = false,
    Function onActionButtonPressed}) {
  // Color _color = Color.fromARGB(220, 117, 218, 255);

  return AlertDialog(
    title: new Text(
      title,
      style: Theme.of(context).textTheme.bodyText2,
    ),
    content: new Text(
      message,
      style: Theme.of(context).textTheme.bodyText2,
    ),
    // backgroundColor: _color,
    // shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
    actions: <Widget>[
      new FlatButton(
        child: new Text(
          defaultActionTitle,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        textColor: Colors.greenAccent,
        onPressed: () {
          onDefaultActionButtonPressed() ?? Navigator.of(context).pop();
        },
      ),
      if (shouleShowActionButton)
        FlatButton(
          child: Text(
            actionButtonTitle,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          textColor: Colors.redAccent,
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
    ],
  );
}

CupertinoAlertDialog showiOSAlertDialog(BuildContext context,
    {String title,
    String message,
    String defaultActionTitle = "Cancel",
    String actionButtonTitle = "",
    Color actionButtonColor,
    Function onDefaultActionButtonPressed,
    bool shouleShowActionButton = false,
    Function onActionButtonPressed}) {
  return CupertinoAlertDialog(
    title: title == null
        ? null
        : Text(
            title,
            style: Theme.of(context).textTheme.bodyText2,
          ),
    content: Column(
      children: [
        SizedBox(
          height: 8.0,
        ),
        Text(
          message ?? "",
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    ),
    actions: <Widget>[
      CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            onDefaultActionButtonPressed ?? Navigator.of(context).pop();
            // : onDefaultActionButtonPressed();
          },
          child: Text(
            defaultActionTitle ?? "Okay",
            style: Theme.of(context).textTheme.bodyText2,
          )),
      if (shouleShowActionButton)
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            onActionButtonPressed();
          },
          child: Text(
            actionButtonTitle,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
    ],
  );
}
