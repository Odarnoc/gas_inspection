import 'package:flutter/material.dart';
import 'package:mikinder/src/screens/login/login_controller.dart';
import 'package:mikinder/src/screens/login/signin/signin_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _Screens());
  }
}

class _Screens extends StatelessWidget {
  const _Screens();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginController>.value(
      value: LoginController(),
      child: Consumer<LoginController>(
        builder: (context, loginController, child) => PageView(
          controller: loginController.pageController,
          physics: const BouncingScrollPhysics(),
          children: [
            SigninScreen(),
            // SignupScreen(),
          ],
        ),
      ),
    );
  }
}
