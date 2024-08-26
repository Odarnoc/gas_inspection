import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/constants/custom_fonts.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/common/validator.dart';
import 'package:mikinder/src/screens/login/access_controller.dart';

class EmailInput extends StatelessWidget {
  const EmailInput(
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
        color: kPrimaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        style: const TextStyle(fontFamily: CustomFonts.gontserrat),
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          icon: const Icon(Icons.person, color: kThridColor),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: S.of(context).hEmail,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontFamily: CustomFonts.bubblebody,
            fontWeight: FontWeight.bold,
          ),
          errorStyle: const TextStyle(
              color: kErrorColor, fontFamily: CustomFonts.bubblebody),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kThridColor),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kThridColor),
          ),
        ),
        initialValue: accessController.email,
        onSaved: (email) => accessController.email = email!.trim(),
        validator: (value) => validateEmail(context, value!),
      ),
    );
  }
}
