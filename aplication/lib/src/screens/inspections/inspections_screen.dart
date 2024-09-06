import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/providers/preferences_provider.dart';
import 'package:mikinder/src/screens/inspections/inspections_controller.dart';
import 'package:mikinder/src/screens/inspections/widgets/inspections_table.dart';
import 'package:mikinder/src/screens/inspections/widgets/internal_inspections_table.dart';
import 'package:mikinder/src/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

class InspectionsScreen extends StatelessWidget {
  InspectionsScreen({super.key});

  final pref = PreferencesProvider();

  var appBarHeight = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InspectionsController>.value(
      value: InspectionsController(),
      child: Consumer<InspectionsController>(
        builder: (context, inspectionsController, child) => Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'assets/screen/icon.png',
              height: 40,
            ),
            actions: [
              PopupMenuButton(
                offset: Offset(0.0, appBarHeight),
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 40,
                ),
                itemBuilder: (ctx) => [
                  PopupMenuItem(
                    onTap: () {
                      final navigator = Navigator.of(context);

                      pref.clean();
                      navigator.pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (Route<dynamic> route) {
                        return false;
                      });
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                        ),
                        Text(S.of(context).signOut),
                      ],
                    ),
                  )
                ],
              )
            ],
            /* shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ), */
            backgroundColor: kFourthColor,
          ),
          backgroundColor: kThridColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                InspectionsTable(inspectionsController: inspectionsController),
                InternalInspectionsTable(
                    inspectionsController: inspectionsController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
