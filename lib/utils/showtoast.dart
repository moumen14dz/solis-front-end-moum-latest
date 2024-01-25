import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToasterror(String label) {
  Fluttertoast.showToast(
      msg: label,
      textColor: Colors.white,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black);
}

showToasterrorLongLength(String label) {
  Fluttertoast.showToast(
      msg: label,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black);
}
