import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  bool isObscure = true;

  void changeObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
