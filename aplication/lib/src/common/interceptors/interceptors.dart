import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/constants/glob_keys.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/common/exceptions/bad_request_exception.dart';

class LoggerInterceptor extends InterceptorContract {
  @override
  BaseRequest interceptRequest({
    required BaseRequest request,
  }) {
    log('----- Request -----');
    log(request.toString());
    log(request.headers.toString());
    log('Request type: ${request.runtimeType}');
    return request;
  }

  @override
  BaseResponse interceptResponse({
    required BaseResponse response,
  }) {
    log('----- Response -----');
    log('Code: ${response.statusCode}');
    log('Response type: ${response.runtimeType}');
    if (response is Response) {
      log((response).body);
    }
    return response;
  }
}

class GeneralInterceptor extends InterceptorContract {
  @override
  BaseRequest interceptRequest({
    required BaseRequest request,
  }) {
    request.headers['Content-Type'] = 'application/json; charset=UTF-8';
    request.headers['x-lang'] = 'es';
    return request;
  }

  @override
  BaseResponse interceptResponse({
    required BaseResponse response,
  }) {
    final context = navigatorKey.currentContext!;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    if (response is Response) {
      if (response.statusCode < 200 || response.statusCode > 299) {
        Map<String, dynamic> decodedResp = json.decode(response.body);
        if (decodedResp['message'] != null) {
          String message = decodedResp['message'];

          scaffoldMessenger
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(message),
              backgroundColor: kErrorColor,
              duration: const Duration(milliseconds: 4500),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(20),
            ));
          throw BadRequestException(message);
        }
      }
    }
    return response;
  }
}
