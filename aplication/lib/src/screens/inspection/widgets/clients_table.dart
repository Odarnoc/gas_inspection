import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/src/screens/inspections/inspections_screen.dart';

class ClientsTable2 extends StatelessWidget {
  const ClientsTable2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          headers(),
          ..._dataRows(context),
        ],
      ),
    );
  }

  headers() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: kTableFieldsBackgroundColor,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            const Text('Nro.'),
            const SizedBox(width: 10),
            const VerticalDivider(
              color: Colors.black,
            ),
            const Text('Cliente'),
            Expanded(child: Container()),
            const VerticalDivider(
              color: Colors.black,
            ),
            const Text('Acciones'),
          ],
        ),
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
                style:
                    const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: kTableFieldsBackgroundColor,
              ),
              child: Text(c3),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => InspectionsScreen()),
                  (Route<dynamic> route) => false);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.orange[700]),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            child: const Text(
              'VOLVER',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
    return rows;
  }
}
