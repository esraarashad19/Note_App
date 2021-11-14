import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

User? currentUser;
String? userPhone;
String? userFullname;
String? userName;

// doubles
double profileCardSpace = 20;
// colors
Color appGreyColor = Color(0xFFB6B4B4);
Color darkBlue = Color(0xFF0067EC);
Color minDarkBlue = Color(0xFF04BAF8);
Color lightBlue = Color(0xFFDFEDF8);
Color blue = Color(0xFF7DC1F5);

// text styles
TextStyle mainHeadLineTextStyle = TextStyle(
  fontSize: 44,
  color: Colors.white,
);

TextStyle greyTextStyle = TextStyle(
  color: appGreyColor,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);
TextStyle appBarTextStyle = TextStyle(
  color: appGreyColor,
  fontSize: 22,
  fontWeight: FontWeight.w400,
);
TextStyle profileDataTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w400,
);

TextStyle titleTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
);
