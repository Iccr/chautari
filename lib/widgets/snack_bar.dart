import 'package:flutter/material.dart';

class ChautariSnackBar {
  static BuildContext context;
  static showNoInternetMesage(String message) {
    if (context == null || !message.contains("internet connection")) {
      return;
    }
    final snackBar = SnackBar(
      content: Text(message),
    );

    var messenger = ScaffoldMessenger.of(context);

    messenger.removeCurrentSnackBar();
    messenger.showSnackBar(snackBar);
  }

  static remove() {
    var messenger = ScaffoldMessenger.of(context);
    messenger.removeCurrentSnackBar();
  }
}
