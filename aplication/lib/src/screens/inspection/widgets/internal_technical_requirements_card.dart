import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/inspection/inspection_controller.dart';
import 'package:mikinder/src/screens/inspection/widgets/custom_field_expanded.dart';
import 'package:mikinder/src/screens/inspection/widgets/rounded_checkbox.dart';

class InternalTechnicalRequirementsCard extends StatelessWidget {
  const InternalTechnicalRequirementsCard(
      {super.key, required this.inspectionController});

  final InspectionController inspectionController;

  final Color textColor = Colors.white;
  final Color fieldsTextColor = Colors.black;

  final double padding = 10.0;
  final double borderRadius = 10.0;

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
              S.of(context).lTechnicalRequirements,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
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
                  const SizedBox(height: kDefaultPadding * .3),
                  fila5(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  filaDistancia(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          CustomFieldExpanded(
              text: S.of(context).lDistance, backgroundColor: kPrimaryColor),
          const SizedBox(width: 10),
          CustomFieldExpanded(
              text: inspectionController.distance.toStringAsFixed(2),
              textColor: fieldsTextColor,
              backgroundColor: kTableFieldsBackgroundColor2),
        ],
      ),
    );
  }

  fila1(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 40,
            child: Container(
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  color: kTableHeadersBackgroundColor,
                ),
                child: Text(
                  'V',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: textColor,
                  ),
                )),
          ),
          const SizedBox(width: 10),
          CustomFieldExpanded(
              text: S.of(context).qPressureCheck,
              textColor: fieldsTextColor,
              backgroundColor: kTableFieldsBackgroundColor2),
          const SizedBox(width: 10),
          RoundedCheckbox(
            value: inspectionController.checkbox5,
            onPressed: () {
              inspectionController.checkbox5 = !inspectionController.checkbox5;
            },
          ),
        ],
      ),
    );
  }

  fila2(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 40,
            child: Container(
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  color: kTableHeadersBackgroundColor,
                ),
                child: Text(
                  'A',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: textColor,
                  ),
                )),
          ),
          const SizedBox(width: 10),
          CustomFieldExpanded(
              text: S.of(context).qValvuleCheck,
              textColor: fieldsTextColor,
              backgroundColor: kTableFieldsBackgroundColor2),
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
          SizedBox(
            width: 40,
            child: Container(
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  color: kTableHeadersBackgroundColor,
                ),
                child: Text(
                  'S',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: textColor,
                  ),
                )),
          ),
          const SizedBox(width: 10),
          CustomFieldExpanded(
              text: S.of(context).qLeakCheck,
              textColor: fieldsTextColor,
              backgroundColor: kTableFieldsBackgroundColor2),
          const SizedBox(width: 10),
          RoundedCheckbox(
            value: inspectionController.checkbox7,
            onPressed: () {
              inspectionController.checkbox7 = !inspectionController.checkbox7;
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
          SizedBox(
            width: 40,
            child: Container(
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  color: kTableHeadersBackgroundColor,
                ),
                child: Text(
                  'A',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: textColor,
                  ),
                )),
          ),
          const SizedBox(width: 10),
          CustomFieldExpanded(
              text: S.of(context).qVentilation,
              textColor: fieldsTextColor,
              backgroundColor: kTableFieldsBackgroundColor2),
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

  fila5(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 40,
            child: Container(
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  color: kTableHeadersBackgroundColor,
                ),
                child: Text(
                  'A',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: textColor,
                  ),
                )),
          ),
          const SizedBox(width: 10),
          CustomFieldExpanded(
              text: S.of(context).qAreaCleaning,
              textColor: fieldsTextColor,
              backgroundColor: kTableFieldsBackgroundColor2),
          const SizedBox(width: 10),
          RoundedCheckbox(
            value: inspectionController.checkbox9,
            onPressed: () {
              inspectionController.checkbox9 = !inspectionController.checkbox9;
            },
          ),
        ],
      ),
    );
  }
}
