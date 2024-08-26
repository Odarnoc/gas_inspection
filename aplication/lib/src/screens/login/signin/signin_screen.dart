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
    final loginController =
        Provider.of<LoginController>(context, listen: false);
    return ChangeNotifierProvider<AccessController>.value(
      value: AccessController(),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/screen/login_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Consumer<AccessController>(
            builder: (context, accessController, child) => Center(
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
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
                            PrimaryTextButton(
                              text: S.of(context).lForgetYourPassword,
                              color: Colors.black,
                              onPressed: () {},
                            ),
                            const SizedBox(height: kDefaultPadding * 3),
                            Text(
                              S.of(context).lNoAccount,
                              style: const TextStyle(fontSize: 20),
                            ),
                            PrimaryTextButton(
                              text: S.of(context).bSignup,
                              color: kFourthColor,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
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
