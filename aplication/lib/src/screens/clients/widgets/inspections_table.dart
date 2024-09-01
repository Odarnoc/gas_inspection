import 'package:mikinder/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/inspection/inspection_screen.dart';

class InspectionsTable extends StatelessWidget {
  const InspectionsTable({
    super.key,
  });

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
              S.of(context).lPreinspections.toUpperCase(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
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
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
          const SizedBox(width: 10),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: kTableHeadersBackgroundColor,
                  ),
                  child: Text(
                    S.of(context).lClient,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ))),
          const SizedBox(width: 10),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: kTableHeadersBackgroundColor,
                  ),
                  child: Text(
                    S.of(context).lAssignedDate,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ))),
          const SizedBox(width: 10),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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

  addRow(BuildContext context,
      {String c1 = '', String c2 = '', String c3 = ''}) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 50,
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
          const SizedBox(width: 10),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: kTableFieldsBackgroundColor,
                  ),
                  child: Text(
                    c2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ))),
          const SizedBox(width: 10),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: kTableFieldsBackgroundColor,
                  ),
                  child: Text(
                    c3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ))),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InspectionScreen()),
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    const WidgetStatePropertyAll(kTableFieldsBackgroundColor),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
    List<Widget> rows = [];

    rows.add(addRow(
      context,
      c1: '1',
      c2: 'Juan Gonzalez',
      c3: '2024-08-31',
    ));
    rows.add(addRow(
      context,
      c1: '2',
      c2: 'Ramiro Mendieta',
      c3: '2024-08-31',
    ));
    rows.add(addRow(
      context,
      c1: '3',
      c2: 'Javier Medina',
      c3: '2024-08-31',
    ));
    rows.add(addRow(
      context,
      c1: '4',
      c2: 'Jose Pedraza',
      c3: '2024-08-31',
    ));
    rows.add(addRow(
      context,
      c1: '5',
      c2: 'Maria Molina',
      c3: '2024-08-31',
    ));
    return rows;
  }
}
