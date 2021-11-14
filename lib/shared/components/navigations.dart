import 'package:flutter/material.dart';

void navigateTo({
  required context,
  required nextScreen,
}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
    );

void navigateAndFinish({
  required context,
  required nextScreen,
}) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
      (route) => false,
    );
