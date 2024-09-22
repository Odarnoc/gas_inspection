import 'dart:async';

import 'package:animated_snack_bar/animated_snack_bar.dart';
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

  scaffoldMessenger
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
      duration: const Duration(seconds: 5),
      backgroundColor: kPositiveColor,
      content: Text(
        message,
        style: const TextStyle(color: Colors.black),
      ),
    ));
}

showSuccessCenterSnackBar(String message) {
  final context = navigatorKey.currentContext!;

  // AnimatedSnackBar.removeAll();

  AnimatedSnackBar.rectangle(
    S.of(navigatorKey.currentContext!).lSuccess,
    message,
    type: AnimatedSnackBarType.success,
    mobileSnackBarPosition: MobileSnackBarPosition.top,
    desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
    brightness: Brightness.dark,
  ).show(context);

  /* scaffoldMessenger
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 100,
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.transparent,
      content: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding * .7),
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: kPositiveColor,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Text(
            message,
          ),
        ),
      ),
    )); */
}

showErrorUknown() {
  final context = navigatorKey.currentContext!;

  // AnimatedSnackBar.removeAll();

  AnimatedSnackBar.rectangle(
    S.of(navigatorKey.currentContext!).lWarnig,
    S.of(context).errUnknown,
    type: AnimatedSnackBarType.warning,
    mobileSnackBarPosition: MobileSnackBarPosition.top,
    desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
    brightness: Brightness.dark,
  ).show(context);
}
