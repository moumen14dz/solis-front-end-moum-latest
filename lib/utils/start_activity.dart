import 'package:flutter/material.dart';

class StartActivity {
  void start(BuildContext context, Widget activity ) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => activity),
    );
  }
}