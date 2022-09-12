import 'package:flutter/material.dart';

class Input {
  Map<String, TextEditingController> input;
  Input({required this.input});

  String? validateInput(String? data) {
    if (data == null || data.isEmpty) {
      return "Can't be Empty.";
    } else {
      return null;
    }
  }
}
