import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/inspection/inspection_controller.dart';
import 'package:mikinder/src/screens/inspection/widgets/custo_field_expanded.dart';
import 'package:mikinder/src/screens/inspection/widgets/rounded_checkbox.dart';

class ProyectInformationCard extends StatelessWidget {
  const ProyectInformationCard({super.key, required this.inspectionController});

  final InspectionController inspectionController;

  final Color textColor = Colors.white;

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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                children: [
                  fila1(context),
                  const SizedBox(height: kDefaultPadding * .3),
                  fila2(context),
                  const SizedBox(height: kDefaultPadding * .3),
                  fila3(context),
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
              text: S.of(context).lProyectType,
              backgroundColor: kTableFieldsBackgroundColor),
          const SizedBox(width: 10),
          CustomFieldExpanded(
              text: inspectionController.requestPetition.proyectType.name,
              backgroundColor: kFourthColor),
        ],
      ),
    );
  }

  fila2(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          CustomFieldExpanded(
              text: S.of(context).qMinimumVolume,
              backgroundColor: kTableFieldsBackgroundColor),
          const SizedBox(width: 10),
          RoundedCheckbox(inspectionController: inspectionController),
          const SizedBox(width: 10),
          CustomFieldExpanded(
              text: S.of(context).qAirSupply,
              backgroundColor: kTableFieldsBackgroundColor),
          const SizedBox(width: 10),
          RoundedCheckbox(inspectionController: inspectionController),
        ],
      ),
    );
  }

  fila3(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          CustomFieldExpanded(
              text: S.of(context).qAirOutlet,
              backgroundColor: kTableFieldsBackgroundColor),
          const SizedBox(width: 10),
          RoundedCheckbox(inspectionController: inspectionController),
          const SizedBox(width: 10),
          CustomFieldExpanded(
              text: S.of(context).qRapidAeration,
              backgroundColor: kTableFieldsBackgroundColor),
          const SizedBox(width: 10),
          RoundedCheckbox(inspectionController: inspectionController),
        ],
      ),
    );
  }
}
