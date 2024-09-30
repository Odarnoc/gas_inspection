import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/instalation/widgets/custom_field_expanded.dart';
import 'package:mikinder/src/screens/instalation/instalation_controller.dart';

class UserInformationCard extends StatelessWidget {
  const UserInformationCard({super.key, required this.instalationController});

  final InstalationController instalationController;

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
              S.of(context).lUserInfo,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                children: [
                  headers(context),
                  const SizedBox(
                    height: kDefaultPadding * .3,
                  ),
                  fila1(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  headers(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 60,
            child: Container(
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  color: kTableHeadersBackgroundColor,
                ),
                child: Text(
                  S.of(context).lId,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: textColor,
                  ),
                )),
          ),
          SizedBox(width: padding),
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    color: kTableHeadersBackgroundColor,
                  ),
                  child: Text(
                    S.of(context).lClient,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ))),
          SizedBox(width: padding),
          SizedBox(
              width: 145,
              child: Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    color: kTableHeadersBackgroundColor,
                  ),
                  child: Text(
                    S.of(context).lAssignedDate,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ))),
          SizedBox(width: padding),
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    color: kTableHeadersBackgroundColor,
                  ),
                  child: Text(
                    S.of(context).lAdrreess,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ))),
          SizedBox(width: padding),
          SizedBox(
              width: 145,
              child: Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    color: kTableHeadersBackgroundColor,
                  ),
                  child: Text(
                    S.of(context).lPhoneCellphone,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ))),
        ],
      ),
    );
  }

  fila1(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 60,
            child: Container(
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  color: kTableHeadersBackgroundColor,
                ),
                child: Text(
                  instalationController.requestPetition.id.toString(),
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontWeight: FontWeight.w900, color: textColor),
                )),
          ),
          SizedBox(width: padding),
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    color: kTableFieldsBackgroundColor2,
                  ),
                  child: Text(
                    '${instalationController.requestPetition.firstName} ${instalationController.requestPetition.maternalName} ${instalationController.requestPetition.paternalName}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: fieldsTextColor,
                    ),
                  ))),
          SizedBox(width: padding),
          SizedBox(
              width: 145,
              child: Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    color: kTableFieldsBackgroundColor2,
                  ),
                  child: Text(
                    DateFormat('yyyy-MM-dd').format(instalationController
                        .requestPetition.createdAt
                        .toLocal()),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: fieldsTextColor,
                    ),
                  ))),
          SizedBox(width: padding),
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    color: kTableFieldsBackgroundColor2,
                  ),
                  child: Text(
                    '${instalationController.requestPetition.zone}, ${instalationController.requestPetition.avenue}, ${instalationController.requestPetition.street} Nro. ${instalationController.requestPetition.door}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: fieldsTextColor,
                    ),
                  ))),
          SizedBox(width: padding),
          SizedBox(
              width: 145,
              child: Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    color: kTableFieldsBackgroundColor2,
                  ),
                  child: Text(
                    '${instalationController.requestPetition.phone} - ${instalationController.requestPetition.cellphone}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: fieldsTextColor,
                    ),
                  ))),
        ],
      ),
    );
  }
}
