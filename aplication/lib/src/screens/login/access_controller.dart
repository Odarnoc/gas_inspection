import 'package:flutter/material.dart';

class AccessController with ChangeNotifier {
  AccessController();

  String _email = '';
  String _password = '';

  String get email => _email;

  set email(String email) {
    _email = email;
    notifyListeners();
  }

  String get password => _password;

  set password(String password) {
    _password = password;
    notifyListeners();
  }

  Future signin() async {}

  Future signup() async {}
}
