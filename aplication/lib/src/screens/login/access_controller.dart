import 'package:flutter/material.dart';
import 'package:mikinder/services/auth_service.dart';
import 'package:mikinder/src/models/user_model.dart';
import 'package:mikinder/src/providers/preferences_provider.dart';

class AccessController with ChangeNotifier {
  AccessController();

  final prefs = PreferencesProvider();
  final AuthService authService = AuthService();

  bool _inAsyncCall = false;
  String _email = '';
  String _password = '';

  String get email => _email;

  bool get inAsyncCall => _inAsyncCall;

  set inAsyncCall(bool asyncCall) {
    _inAsyncCall = asyncCall;
    notifyListeners();
  }

  set email(String email) {
    _email = email;
    notifyListeners();
  }

  String get password => _password;

  set password(String password) {
    _password = password;
    notifyListeners();
  }

  Future<UserModel?> signin() async {
    UserModel? user;
    inAsyncCall = true;
    Map<String, dynamic>? decodedResp =
        await authService.login(email, password);
    inAsyncCall = false;
    try {
      user = UserModel.fromJson(decodedResp!);
      prefs.user = user;
      prefs.token = user.token;
      inAsyncCall = false;
      return user;
    } catch (e) {
      print(e);
      inAsyncCall = false;
      return null;
    }
  }

  Future signup() async {}
}
