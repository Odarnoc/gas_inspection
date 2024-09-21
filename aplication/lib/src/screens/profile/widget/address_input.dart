import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/profile/profile_controller.dart';

class AddressInput extends StatelessWidget {
  const AddressInput(
    this.profileController, {
    super.key,
  });
  final ProfileController profileController;

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
        readOnly: true,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: S.of(context).lName,
          labelStyle: const TextStyle(
            color: kFourthColor,
            fontWeight: FontWeight.bold,
          ),
          errorStyle: const TextStyle(color: kErrorColor),
          border: InputBorder.none,
          hintText: S.of(context).lName,
        ),
        initialValue: profileController.address,
        onSaved: (hFullName) => profileController.address = hFullName!,
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
