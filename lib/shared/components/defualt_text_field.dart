import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/shared/constrains.dart';

class DefualtTextField extends StatelessWidget {
  TextEditingController controller;
  TextInputType keyboardType;
  String? hint;
  bool isPassword;
  bool isProfile;
  DefualtTextField({
    this.hint = '',
    required this.controller,
    this.isPassword = false,
    this.isProfile = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: profileDataTextStyle,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: appGreyColor,
        ),
        border: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xFFB6B4B4),
          width: 1.5,
        )),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFB6B4B4),
            width: 1.5,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xFFB6B4B4),
          width: 1.5,
        )),
      ),
      obscureText: isPassword ? true : false,
      textAlign: !isProfile ? TextAlign.center : TextAlign.start,
      validator: (String? value) {
        if (value!.isEmpty) return '$hint is required';
        return null;
      },
    );
  }
}
