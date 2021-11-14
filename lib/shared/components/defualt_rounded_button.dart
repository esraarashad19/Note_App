import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/shared/constrains.dart';

class DefualtRoundedButton extends StatelessWidget {
  String title;
  var onpress;
  DefualtRoundedButton({
    required this.title,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            //darkBlue,
            minDarkBlue,

            blue,
          ], // List of colors
        ),
      ),
      width: 170,
      height: 40,
      child: MaterialButton(
        //color: minDarkBlue,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        onPressed: onpress,
      ),
    );
  }
}
