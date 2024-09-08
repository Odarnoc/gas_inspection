import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/src/common/dialog_helpers.dart';
import 'package:mikinder/src/common/exceptions/bad_request_exception.dart';
import 'package:mikinder/src/common/interceptors/interceptors.dart';
import 'package:mikinder/src/models/request_petition_model.dart';
import 'package:mikinder/src/providers/preferences_provider.dart';

const _urlUpdate = 'requestPetition/update';
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
    } on BadRequestException {
      if (kDebugMode) {
        print('RequestPetitionService getPreinspections: BadRequestException');
      }
    } catch (err) {
      showErrorUknown();
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
    } on BadRequestException {
      if (kDebugMode) {
        print(
            'RequestPetitionService getInternalInspections: BadRequestException');
      }
    } catch (err) {
      showErrorUknown();
      if (kDebugMode) {
        print('RequestPetitionService getInternalInspections: $err');
      }
    } finally {
      client.close();
    }
    return requests;
  }

  Future<RequestPetitionModel?> updateRequestPetition(
      Map<String, dynamic> data) async {
    RequestPetitionModel? requestPetition;
    final client = InterceptedClient.build(interceptors: [
      LoggerInterceptor(),
      GeneralInterceptor(),
    ]);
    try {
      final resp = await client.put(
        Uri.parse('$kDomain$_urlUpdate'),
        headers: {
          'Authorization': 'Bearer ${prefs.token}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      if (resp.statusCode != 200) return requestPetition;
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      requestPetition =
          RequestPetitionModel.fromJson(decodedResp['systemDocument']);
      return requestPetition;
    } on BadRequestException {
      if (kDebugMode) {
        print(
            'RequestPetitionService updateRequestPetition: BadRequestException');
      }
    } catch (err) {
      showErrorUknown();
      if (kDebugMode) {
        print('RequestPetitionService updateRequestPetition: $err');
      }
    } finally {
      client.close();
    }
    return requestPetition;
  }
}
