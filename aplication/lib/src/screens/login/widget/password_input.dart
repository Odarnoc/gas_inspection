import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/login/access_controller.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput(
    this.accessController, {
    super.key,
  });
  final AccessController accessController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: kDefaultPadding * 0.75,
          right: kDefaultPadding * 0.75,
          bottom: kDefaultPadding * 0.75),
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.5),
      decoration: BoxDecoration(
        color: kContentColorDarkTheme,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: S.of(context).hPassword,
          labelStyle: const TextStyle(
            color: kFourthColor,
            fontWeight: FontWeight.bold,
          ),
          errorStyle: const TextStyle(color: kErrorColor),
          border: InputBorder.none,
        ),
        initialValue: accessController.password,
        onSaved: (password) => accessController.password = password!,
        validator: (value) {
          if (value!.trim().length < 6) {
            return S.of(context).eValidatoCharacters(6);
          }
          return null;
        },
      ),
    );
  }
}
