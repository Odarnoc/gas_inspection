import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/src/common/dialog_helpers.dart';
import 'package:mikinder/src/common/exceptions/bad_request_exception.dart';
import 'package:mikinder/src/common/interceptors/interceptors.dart';
import 'package:mikinder/src/models/request_document_model.dart';
import 'package:mikinder/src/models/request_petition_model.dart';
import 'package:mikinder/src/providers/preferences_provider.dart';

const _urlCreate = 'requestDocuments/create';
const _urlDelete = 'requestDocuments/delete';
const _urlGetDocuments = 'requestDocuments/getDocuments';

class RequestDocumentService {
  final prefs = PreferencesProvider();

  Future<RequestDocumentModel?> create(int id, String url) async {
    final client = InterceptedClient.build(interceptors: [
      GeneralInterceptor(),
      LoggerInterceptor(),
    ]);
    try {
      final resp = await client.post(Uri.parse('$kDomain$_urlCreate'),
          headers: {
            'Authorization': 'Bearer ${prefs.token}',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "requestPetition": {"id": id},
            "documentUrl": url,
          }));
      Map<String, dynamic> decodedResp = json.decode(resp.body);

      return RequestDocumentModel.fromJson(decodedResp['systemDocument']);
    } on BadRequestException {
      if (kDebugMode) {
        print('RequestDocumentService create: BadRequestException');
      }
    } catch (err) {
      showErrorUknown();
      if (kDebugMode) {
        print('RequestDocumentService create: $err');
      }
    } finally {
      client.close();
    }
    return null;
  }

  Future<bool> delete(int id) async {
    final client = InterceptedClient.build(interceptors: [
      GeneralInterceptor(),
      LoggerInterceptor(),
    ]);
    try {
      final resp = await client.delete(
        Uri.parse('$kDomain$_urlDelete/$id'),
        headers: {
          'Authorization': 'Bearer ${prefs.token}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      Map<String, dynamic> decodedResp = json.decode(resp.body);

      if (decodedResp['result']) {
        return true;
      }
      return false;
    } on BadRequestException {
      if (kDebugMode) {
        print('RequestDocumentService create: BadRequestException');
      }
    } catch (err) {
      showErrorUknown();
      if (kDebugMode) {
        print('RequestDocumentService create: $err');
      }
    } finally {
      client.close();
    }
    return false;
  }

  Future<List<RequestDocumentModel>> getDocuments(int id) async {
    List<RequestDocumentModel> requests = [];
    final client = InterceptedClient.build(interceptors: [
      LoggerInterceptor(),
      GeneralInterceptor(),
    ]);
    try {
      final resp = await client.get(
        Uri.parse('$kDomain$_urlGetDocuments/$id'),
        headers: {
          'Authorization': 'Bearer ${prefs.token}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      for (var item in decodedResp['data']) {
        requests.add(RequestDocumentModel.fromJson(item));
      }
      return requests;
    } on BadRequestException {
      if (kDebugMode) {
        print('RequestDocumentService getDocuments: BadRequestException');
      }
    } catch (err) {
      showErrorUknown();
      if (kDebugMode) {
        print('RequestDocumentService getDocuments: $err');
      }
    } finally {
      client.close();
    }
    return requests;
  }
}
