import 'package:flutter/material.dart';

void showMessageBox({
  required String message,
  var onPress,
  required BuildContext context,
  String title = 'error',
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          FlatButton(
            child: Text("Ok"),
            onPressed: onPress == null
                ? () {
                    Navigator.of(context).pop();
                  }
                : onPress,
          ),
        ],
      );
    },
  );
}
