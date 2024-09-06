import 'package:intl/intl.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/models/request_petition_model.dart';
import 'package:mikinder/src/screens/inspection/inspection_screen.dart';
import 'package:mikinder/src/screens/inspections/inspections_controller.dart';

class InspectionsTable extends StatelessWidget {
  const InspectionsTable({
    super.key,
    required this.inspectionsController,
  });

  final InspectionsController inspectionsController;

  final Color textColor = Colors.white;

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
              S.of(context).lPreinspections.toUpperCase(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            width: 50,
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
                    fontSize: 16,
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
          Expanded(
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
            width: 50,
            child: Container(
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  color: kTableFieldsBackgroundColor,
                ),
                child: Text(
                  c1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: textColor),
                )),
          ),
          SizedBox(width: padding),
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    color: kTableFieldsBackgroundColor,
                  ),
                  child: Text(
                    c2,
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
                    color: kTableFieldsBackgroundColor,
                  ),
                  child: Text(
                    c3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ))),
          SizedBox(width: padding),
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          InspectionScreen(requestPetition: requestPetition)),
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    const WidgetStatePropertyAll(kTableFieldsBackgroundColor),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                  ),
                ),
              ),
              child: Text(
                S.of(context).bView.toUpperCase(),
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _dataRows(BuildContext context) {
    return inspectionsController.inspections
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
