import 'package:flutter/foundation.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/src/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class PreferencesProvider {
  static PreferencesProvider? _instance;

  PreferencesProvider._internal();

  factory PreferencesProvider() {
    _instance ??= PreferencesProvider._internal();
    return _instance!;
  }

  init() async {
    try {
      _instance!.preferences = await SharedPreferences.getInstance();
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  SharedPreferences? preferences;

  set user(UserModel user) {
    if (preferences == null) return;
    preferences!.setInt('userId', user.id);
    preferences!.setString('email', user.email);
    preferences!.setString('firstName', user.firstName);
    preferences!.setString('paternal', user.paternalName);
    preferences!.setString('maternal', user.maternalName);
    preferences!.setString('image', user.image);
    preferences!.setString('phone', user.phone);
    preferences!.setString('cellphone', user.cellphone);
    preferences!.setString('address', user.address);
    preferences!.setStringList('roles', user.roles);
  }

  UserModel get user {
    return UserModel(
      id: preferences!.getInt('userId') ?? 0,
      firstName: preferences!.getString('firstName') ?? '',
      paternalName: preferences!.getString('paternal') ?? '',
      maternalName: preferences!.getString('maternal') ?? '',
      email: preferences!.getString('email') ??
          'guest@${kNameApp.toLowerCase()}.com',
      phone: preferences!.getString('phone') ?? 's/n',
      cellphone: preferences!.getString('cellphone') ?? 's/n',
      address: preferences!.getString('address') ?? 'n/a',
      image: preferences!.getString('image') ?? kImageDeliveryManDefault,
      roles: preferences!.getStringList('roles') ?? [],
      token: preferences!.getString('token') ?? '',
    );
  }

  clean() {
    token = '';
    user = UserModel(
      id: 0,
      email: 'guest@${kNameApp.toLowerCase()}.com',
      firstName: 'Guest $kNameApp',
      paternalName: kCountryCode,
      maternalName: kPhonePrefix,
      phone: 's/n',
      cellphone: 's/n',
      address: 'n/a',
      image: kImageDeliveryManDefault,
      roles: [],
      token: '',
    );
  }

  bool get isAuth {
    if (preferences == null) return false;
    return preferences!.getInt('userId') != null &&
        preferences!.getInt('userId')! > 0;
  }

  String get token {
    if (preferences == null) return '';
    return preferences!.getString('token') ?? '';
  }

  set token(String? value) {
    if (preferences != null) preferences!.setString('token', value!);
  }

  String? get tokenPush {
    if (preferences == null) return null;
    return preferences!.getString('tokenPush');
  }

  set tokenPush(String? value) {
    if (preferences != null) preferences!.setString('tokenPush', value!);
  }

  String get idDevice {
    if (preferences!.getString('uuid') == null) {
      preferences!.setString('uuid', const Uuid().v4());
    }
    return preferences!.getString('uuid') ?? idDevice;
  }

  set idDevice(String value) {
    if (preferences != null) preferences!.setString('uuid', value);
  }

  String get locale {
    if (preferences == null) return 'es';
    return preferences!.getString('locale') ?? 'es';
  }

  set locale(String? value) {
    if (preferences != null) preferences!.setString('locale', value!);
  }
}
