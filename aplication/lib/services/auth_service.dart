import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/src/common/dialog_helpers.dart';
import 'package:mikinder/src/common/exceptions/bad_request_exception.dart';
import 'package:mikinder/src/common/interceptors/interceptors.dart';
import 'package:mikinder/src/models/user_model.dart';
import 'package:mikinder/src/providers/preferences_provider.dart';

const _urlLogin = 'auth/loginApp';
const _urlLogOut = 'auth/log-out';
const _urlGetProfile = 'auth/profile';

class AuthService {
  final prefs = PreferencesProvider();

  Future<bool> logOut() async {
    final client = InterceptedClient.build(interceptors: [
      LoggerInterceptor(),
    ]);
    try {
      final resp = await client.delete(
        Uri.parse('$kDomain$_urlLogOut/${prefs.idDevice}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.token}',
        },
      );
      if (resp.statusCode == 200) return true;
    } catch (err) {
      if (kDebugMode) {
        print('AuthService logOut: $err');
      }
    } finally {
      client.close();
    }
    return false;
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final client = InterceptedClient.build(interceptors: [
      GeneralInterceptor(),
      LoggerInterceptor(),
    ]);
    try {
      final resp = await client.post(Uri.parse('$kDomain$_urlLogin'),
          body: jsonEncode({
            "email": email,
            "password": password,
          }));
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      return decodedResp;
    } on BadRequestException {
      if (kDebugMode) {
        print('AuthService login: BadRequestException');
      }
    } catch (err) {
      showErrorUknown();
      if (kDebugMode) {
        print('AuthService login: $err');
      }
    } finally {
      client.close();
    }
    return null;
  }

  Future<UserModel?> getProfile() async {
    final client = InterceptedClient.build(interceptors: [
      LoggerInterceptor(),
    ]);
    try {
      final resp = await client.post(
        Uri.parse('$kDomain$_urlGetProfile'),
        headers: {
          'Authorization': 'Bearer ${prefs.token}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      UserModel user = UserModel.fromJson(decodedResp);
      return user;
    } catch (err) {
      if (kDebugMode) {
        print('AuthService getProfile: $err');
      }
    } finally {
      client.close();
    }
    return null;
  }
}
