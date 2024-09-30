import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/inspection/widgets/custom_field_expanded.dart';
import 'package:mikinder/src/screens/instalation/instalation_controller.dart';

class ProyectInformationCard extends StatelessWidget {
  const ProyectInformationCard(
      {super.key, required this.instalationController});

  final InstalationController instalationController;

  final Color textColor = Colors.white;
  final Color fieldsTextColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Card(
        color: kCardsBackgroundColor,
        child: Column(
          children: [
            const SizedBox(
              height: kDefaultPadding,
            ),
            Text(
              S.of(context).lProyectInfo,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                children: [
                  fila1(context),
                  const SizedBox(
                    height: kDefaultPadding * .3,
                  ),
                  fila2(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  fila1(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          CustomFieldExpanded(
              text: S.of(context).lProyectType, backgroundColor: kPrimaryColor),
        ],
      ),
    );
  }

  fila2(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          CustomFieldExpanded(
              text: instalationController.requestPetition.proyectType.name,
              textColor: fieldsTextColor,
              backgroundColor: kTableFieldsBackgroundColor2),
        ],
      ),
    );
  }
}
