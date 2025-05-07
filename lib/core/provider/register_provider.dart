import 'package:flutter/material.dart';

class RegisterProvider with ChangeNotifier {
  bool isObscure = true;
  String? password = "";

  void changeObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
