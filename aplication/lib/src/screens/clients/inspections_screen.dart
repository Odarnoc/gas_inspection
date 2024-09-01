import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/clients/widgets/inspections_table.dart';

class InspectionsScreen extends StatelessWidget {
  InspectionsScreen({super.key});

  var appBarHeight = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: const Column(
        children: [
          InspectionsTable(),
        ],
      ),
    );
  }
}
