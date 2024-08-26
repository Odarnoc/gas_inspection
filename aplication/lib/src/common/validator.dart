import 'package:flutter/material.dart';
import 'package:mikinder/generated/l10n.dart';

String? validateEmail(BuildContext context, String email) {
  String value = email.trim();
  if (value.length < 8) return S.of(context).eValidatoEmail;
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);
  if (!emailValid) return S.of(context).eValidatoEmail;
  return null;
}
