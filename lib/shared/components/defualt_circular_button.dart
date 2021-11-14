import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/shared/constrains.dart';

class DefualtCircularButton extends StatelessWidget {
  IconData icon;
  var onPress;
  DefualtCircularButton({
    required this.icon,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RawMaterialButton(
        padding: EdgeInsets.all(12),
        fillColor: Colors.blue,
        onPressed: onPress,
        child: Icon(
          icon,
          size: 30,
          color: Colors.white,
        ),
        shape: CircleBorder(),
      ),
    );
  }
}
