import 'package:flutter/material.dart';
import 'package:mikinder/constants/types_constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/inspections/inspections_screen.dart';
import 'package:mikinder/src/screens/instalations/instalations_screen.dart';
import 'package:mikinder/src/screens/login/access_controller.dart';
import 'package:mikinder/src/widgets/primary_button.dart';

class SigninButton extends StatelessWidget {
  const SigninButton(
    this.accessController, {
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;
  final AccessController accessController;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: S.of(context).bSignin,
      onPressed: () async {
        final navigator = Navigator.of(context);
        FocusScope.of(context).requestFocus(FocusNode());
        _formKey.currentState!.save();
        if (!_formKey.currentState!.validate()) return;

        final response = await accessController.signin();
        if (response != null) {
          if (accessController.prefs.user.roles.contains(TypesRol.instalator)) {
            navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => InstalationsScreen()),
                (Route<dynamic> route) {
              return false;
            });
          } else {
            navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => InspectionsScreen()),
                (Route<dynamic> route) {
              return false;
            });
          }
        }
      },
    );
  }
}
