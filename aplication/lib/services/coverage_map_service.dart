import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/src/common/dialog_helpers.dart';
import 'package:mikinder/src/common/exceptions/bad_request_exception.dart';
import 'package:mikinder/src/common/interceptors/interceptors.dart';
import 'package:mikinder/src/models/coverage_lines_model.dart';
import 'package:mikinder/src/providers/preferences_provider.dart';

const _urlGetLines = 'covergeLines/getAll';

class CoveageMapService {
  final prefs = PreferencesProvider();

  Future<List<CoverageLinesModel>> getLines() async {
    List<CoverageLinesModel> lines = [];
    final client = InterceptedClient.build(interceptors: [
      LoggerInterceptor(),
      GeneralInterceptor(),
    ]);
    try {
      final resp = await client.get(
        Uri.parse('$kDomain$_urlGetLines'),
        headers: {
          'Authorization': 'Bearer ${prefs.token}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      for (var item in decodedResp['data']) {
        lines.add(CoverageLinesModel.fromJson(item));
      }
      return lines;
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
    return lines;
  }
}
