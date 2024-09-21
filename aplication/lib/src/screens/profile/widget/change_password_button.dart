import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/profile/profile_controller.dart';
import 'package:mikinder/src/screens/profile/widget/password_dialog.dart';
import 'package:mikinder/src/widgets/primary_button.dart';
import 'package:mikinder/src/widgets/secondary_button.dart';

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton(
    this.profileController, {
    super.key,
  });

  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
        fullWidth: false,
        text: S.of(context).bChangePassword,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) =>
                PasswordDialog(profileController, onPressedOk: () async {
              await profileController.updatePasswor();
            }),
          );
        });
  }
}
