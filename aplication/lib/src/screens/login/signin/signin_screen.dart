import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/login/access_controller.dart';
import 'package:mikinder/src/screens/login/login_controller.dart';
import 'package:mikinder/src/screens/login/widget/email_input.dart';
import 'package:mikinder/src/screens/login/widget/password_input.dart';
import 'package:mikinder/src/screens/login/widget/signin_button.dart';
import 'package:mikinder/src/widgets/primary_text_button.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccessController>.value(
      value: AccessController(),
      child: Scaffold(
        backgroundColor: kThridColor,
        body: Consumer<AccessController>(
          builder: (context, accessController, child) => Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    children: [
                      const SizedBox(height: kDefaultPadding * 1.3),
                      Image.asset("assets/screen/icon.png", height: 150),
                      const SizedBox(height: kDefaultPadding * 1.3),
                      EmailInput(accessController),
                      const SizedBox(height: kDefaultPadding * 1.3),
                      PasswordInput(accessController),
                      const SizedBox(height: kDefaultPadding * 1.3),
                      SigninButton(accessController, formKey: _formKey),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
