import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/src/common/interceptors/interceptors.dart';
import 'package:mikinder/src/models/request_petition_model.dart';
import 'package:mikinder/src/providers/preferences_provider.dart';

const _urlGetPreinspections = 'requestPetition/getPreinspections';
const _urlGetInternalInspections = 'requestPetition/getInternalInspections';

class RequestPetitionService {
  final prefs = PreferencesProvider();

  Future<List<RequestPetitionModel>> getPreinspections() async {
    List<RequestPetitionModel> requests = [];
    final client = InterceptedClient.build(interceptors: [
      LoggerInterceptor(),
      GeneralInterceptor(),
    ]);
    try {
      final resp = await client.get(
        Uri.parse('$kDomain$_urlGetPreinspections'),
        headers: {
          'Authorization': 'Bearer ${prefs.token}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      for (var item in decodedResp['data']) {
        requests.add(RequestPetitionModel.fromJson(item));
      }
      return requests;
    } catch (err) {
      if (kDebugMode) {
        print('RequestPetitionService getPreinspections: $err');
      }
    } finally {
      client.close();
    }
    return requests;
  }

  Future<List<RequestPetitionModel>> getInternalInspections() async {
    List<RequestPetitionModel> requests = [];
    final client = InterceptedClient.build(interceptors: [
      LoggerInterceptor(),
      GeneralInterceptor(),
    ]);
    try {
      final resp = await client.get(
        Uri.parse('$kDomain$_urlGetInternalInspections'),
        headers: {
          'Authorization': 'Bearer ${prefs.token}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      for (var item in decodedResp['data']) {
        requests.add(RequestPetitionModel.fromJson(item));
      }
      return requests;
    } catch (err) {
      if (kDebugMode) {
        print('RequestPetitionService getInternalInspections: $err');
      }
    } finally {
      client.close();
    }
    return requests;
  }
}
