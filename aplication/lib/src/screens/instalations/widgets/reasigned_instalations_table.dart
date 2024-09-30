import 'package:intl/intl.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/models/request_petition_model.dart';
import 'package:mikinder/src/screens/instalation/instalation_screen.dart';
import 'package:mikinder/src/screens/instalations/instalations_controller.dart';

class ReasignedInstalationsTable extends StatelessWidget {
  const ReasignedInstalationsTable({
    super.key,
    required this.instalationsController,
  });

  final InstalationsController instalationsController;

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
              S.of(context).lReasignedProyects.toUpperCase(),
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                children: [
                  headers(context),
                  ..._dataRows(context),
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
          Expanded(
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
          SizedBox(
              width: 110,
              child: Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    color: kTableHeadersBackgroundColor,
                  ),
                  child: Text(
                    S.of(context).lActions,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ))),
        ],
      ),
    );
  }

  Widget addRow(BuildContext context, RequestPetitionModel requestPetition,
      {String c1 = '', String c2 = '', String c3 = ''}) {
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
                  c1,
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
                    c2,
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
                    c3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: fieldsTextColor,
                    ),
                  ))),
          SizedBox(width: padding),
          SizedBox(
            width: 110,
            child: ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InstalationScreen(
                            requestPetition: requestPetition,
                          )),
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    const WidgetStatePropertyAll(kTableButtonsBackgroundColor),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                  ),
                ),
              ),
              child: const Icon(
                Icons.remove_red_eye,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _dataRows(BuildContext context) {
    List<Widget> rows = [];

    return instalationsController.internalInspections
        .map((inspection) => addRow(
              context,
              inspection,
              c1: inspection.id.toString(),
              c2: inspection.firstName,
              c3: DateFormat('yyyy-MM-dd')
                  .format(inspection.createdAt.toLocal()),
            ))
        .toList();
  }
}
