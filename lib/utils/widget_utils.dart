import 'package:flutter/material.dart';

class WidgetUtils {

  SnackBar showSnackBar(String message) {
    return SnackBar(
      content: Text(message),
      //backgroundColor: buttonColor,
    );
  }
}