import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/inspection/inspection_controller.dart';
import 'package:mikinder/src/screens/inspection/widgets/custom_field_expanded.dart';
import 'package:mikinder/src/screens/inspection/widgets/rounded_checkbox.dart';

class InternalProyectInformationCard extends StatelessWidget {
  const InternalProyectInformationCard(
      {super.key, required this.inspectionController});

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
                  const SizedBox(height: kDefaultPadding * .3),
                  fila4(context),
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
              text: S.of(context).qPressureCheck,
              backgroundColor: kTableFieldsBackgroundColor),
          const SizedBox(width: 10),
          RoundedCheckbox(
            value: inspectionController.checkbox5,
            onPressed: () {
              inspectionController.checkbox5 = !inspectionController.checkbox5;
            },
          ),
          const SizedBox(width: 10),
          CustomFieldExpanded(
              text: S.of(context).qValvuleCheck,
              backgroundColor: kTableFieldsBackgroundColor),
          const SizedBox(width: 10),
          RoundedCheckbox(
            value: inspectionController.checkbox6,
            onPressed: () {
              inspectionController.checkbox6 = !inspectionController.checkbox6;
            },
          ),
        ],
      ),
    );
  }

  fila3(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          CustomFieldExpanded(
              text: S.of(context).qLeakCheck,
              backgroundColor: kTableFieldsBackgroundColor),
          const SizedBox(width: 10),
          RoundedCheckbox(
            value: inspectionController.checkbox7,
            onPressed: () {
              inspectionController.checkbox7 = !inspectionController.checkbox7;
            },
          ),
          const SizedBox(width: 10),
          CustomFieldExpanded(
              text: S.of(context).qVentilation,
              backgroundColor: kTableFieldsBackgroundColor),
          const SizedBox(width: 10),
          RoundedCheckbox(
            value: inspectionController.checkbox8,
            onPressed: () {
              inspectionController.checkbox8 = !inspectionController.checkbox8;
            },
          ),
        ],
      ),
    );
  }

  fila4(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          CustomFieldExpanded(
              text: S.of(context).qAreaCleaning,
              backgroundColor: kTableFieldsBackgroundColor),
          const SizedBox(width: 10),
          RoundedCheckbox(
            value: inspectionController.checkbox9,
            onPressed: () {
              inspectionController.checkbox9 = !inspectionController.checkbox9;
            },
          ),
          const SizedBox(width: 10),
          Expanded(child: Container()),
          const SizedBox(width: 10),
          Center(
              child: InkWell(
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: kCardsBackgroundColor),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.check,
                  size: 30.0,
                  color: kCardsBackgroundColor,
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
