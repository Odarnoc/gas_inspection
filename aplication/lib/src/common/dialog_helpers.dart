import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/constants/glob_keys.dart';
import 'package:mikinder/generated/l10n.dart';

Future<bool> showDialogAlert(BuildContext context,
    {Widget? title, Widget? content, Widget? textOK, Widget? textCancel}) {
  Completer<bool> completer = Completer<bool>();
  final sContext = S.of(context);
  final navigatorContext = Navigator.of(context);
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title,
          content: content,
          actions: <Widget>[
            if (textCancel != null)
              TextButton(
                child: Text(sContext.bCancel),
                onPressed: () {
                  navigatorContext.pop();
                  completer.complete(false);
                },
              ),
            TextButton(
              child: textOK ?? Text(sContext.bOk),
              onPressed: () {
                navigatorContext.pop();
                completer.complete(true);
              },
            ),
          ],
        );
      });
  return completer.future;
}

showSuccessSnackBar(String message) {
  final context = navigatorKey.currentContext!;
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  scaffoldMessenger.showSnackBar(SnackBar(
    duration: const Duration(seconds: 5),
    backgroundColor: kPrimaryColor,
    content: Text(message),
  ));
}

showSuccessCenterSnackBar(String message) {
  final context = navigatorKey.currentContext!;
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  scaffoldMessenger.showSnackBar(SnackBar(
    duration: const Duration(seconds: 5),
    backgroundColor: Colors.transparent,
    content: Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding * .7),
        width: double.maxFinite,
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Text(
          message,
        ),
      ),
    ),
  ));
}

showErrorUknown() {
  final context = navigatorKey.currentContext!;
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  scaffoldMessenger
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(S.of(context).errUnknown),
      backgroundColor: kErrorColor,
      duration: const Duration(milliseconds: 4500),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20),
    ));
}
