import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:mikinder/constants/code_error_constant.dart';
import 'package:mikinder/constants/glob_keys.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/services/auth_service.dart';
import 'package:mikinder/src/common/dialog_helpers.dart';
import 'package:mikinder/src/models/user_model.dart';
import 'package:mikinder/src/providers/preferences_provider.dart';

class ProfileController with ChangeNotifier {
  final AuthService authService = AuthService();
  final prefs = PreferencesProvider();

  String _image = '';
  String _fullName = '';
  String _paternal = '';
  String _maternal = '';
  String _address = '';
  String _email = '';
  String _password = '';
  String _phone = '';
  String _cellphone = '';
  String oldPhoneCountryISOCode = '';
  String oldPhonePrefix = '';
  String olpPhone = '';
  bool _inAsyncCall = false;
  bool _isImageRequested = false;

  ProfileController() {
    _fillProfile();
  }

  String get email => _email;

  set email(String email) {
    _email = email;
    notifyListeners();
  }

  String get fullName => _fullName;

  set fullName(String fullName) {
    _fullName = fullName;
    notifyListeners();
  }

  String get paternal => _paternal;

  set paternal(String paternal) {
    _paternal = paternal;
    notifyListeners();
  }

  String get maternal => _maternal;

  set maternal(String maternal) {
    _maternal = maternal;
    notifyListeners();
  }

  String get address => _address;

  set address(String address) {
    _address = address;
    notifyListeners();
  }

  String get image => _image;

  set image(String image) {
    _image = image;
    notifyListeners();
  }

  String get password => _password;

  set password(String password) {
    _password = password;
    notifyListeners();
  }

  String get cellphone => _cellphone;

  set cellphone(String cellphone) {
    _cellphone = cellphone;
    notifyListeners();
  }

  String get phone => _phone;

  set phone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  bool get isImageRequested => _isImageRequested;

  set isImageRequested(bool isImageRequested) {
    _isImageRequested = isImageRequested;
    notifyListeners();
  }

  bool get inAsyncCall => _inAsyncCall;

  set inAsyncCall(bool asyncCall) {
    _inAsyncCall = asyncCall;
    notifyListeners();
  }

  Future<bool> logOut() async {
    return await authService.logOut();
  }

  Future<bool> updatePasswor() async {
    inAsyncCall = true;
    Map<String, dynamic>? decodedResp =
        await authService.updatePasswordByUserId(prefs.user.id, password);
    inAsyncCall = false;
    try {
      bool result = decodedResp?['result'] ?? false;
      if (result) {
        showSuccessCenterSnackBar(
            S.of(navigatorKey.currentContext!).lUpdateSuccess);
      }
      return true;
    } catch (e) {
      print(e);
      showErrorUknown();
      inAsyncCall = false;
      return false;
    }
  }

  Future<bool> changeImage(String image) async {
    inAsyncCall = true;
    Map<String, dynamic>? decodedResp =
        await authService.changeImage(prefs.user.id, image);
    inAsyncCall = false;
    try {
      bool result = decodedResp?['result'] ?? false;
      if (result) {
        showSuccessCenterSnackBar(
            S.of(navigatorKey.currentContext!).lUpdateSuccess);
        getProfile();
      }
      return true;
    } catch (e) {
      print(e);
      showErrorUknown();
      inAsyncCall = false;
      return false;
    }
  }

  Future<void> getProfile() async {
    inAsyncCall = true;
    UserModel? user = await authService.getProfile();
    if (user != null) {
      prefs.user = user;
      _fillProfile();
    }
    inAsyncCall = false;
  }

  void _fillProfile() {
    _image = prefs.user.image;
    _fullName = prefs.user.firstName;
    _paternal = prefs.user.paternalName;
    _maternal = prefs.user.maternalName;
    _address = prefs.user.address;
    _email = prefs.user.email;
    _cellphone = prefs.user.cellphone;
    olpPhone = prefs.user.phone;
  }
}
