import 'package:mikinder/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mikinder/src/screens/clients/inspections_screen.dart';
import 'package:mikinder/src/screens/inspection/inspection_controller.dart';
import 'package:mikinder/src/screens/inspection/widgets/bottom_accion_buttons.dart';
import 'package:mikinder/src/screens/inspection/widgets/clients_table.dart';
import 'package:mikinder/src/screens/inspection/widgets/floating_my_location_button.dart';
import 'package:mikinder/src/screens/inspection/widgets/tech_info_card.dart';
import 'package:provider/provider.dart';

class InspectionScreen extends StatelessWidget {
  const InspectionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DemoController>.value(
      value: DemoController(),
      child: Consumer<DemoController>(
        builder: (context, demoController, child) => SafeArea(
          child: Scaffold(
            backgroundColor: kBodyBackgroundColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const ClientsTable2(),
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 10, bottom: 10),
                        height: 350,
                        width: double.infinity - 10,
                        child: GoogleMap(
                          gestureRecognizers: <Factory<
                              OneSequenceGestureRecognizer>>{
                            Factory<OneSequenceGestureRecognizer>(
                              () => EagerGestureRecognizer(),
                            ),
                          },
                          mapToolbarEnabled: false,
                          mapType: MapType.normal,
                          buildingsEnabled: false,
                          markers: demoController.markers,
                          polylines: {
                            ...demoController.polylines,
                            Polyline(
                              polylineId:
                                  const PolylineId('new_polyline_update'),
                              consumeTapEvents: true,
                              color: Colors.green,
                              width: 5,
                              points: demoController.markers
                                  .map((marker) => marker.position)
                                  .toList(),
                            )
                          },
                          initialCameraPosition:
                              demoController.initialCameraPosition,
                          onMapCreated: (googleMapController) async {
                            await demoController.onMapCreated(
                                googleMapController, context);
                          },
                          myLocationEnabled: false,
                          compassEnabled: false,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                          onTap: (LatLng point) {
                            demoController.addMarker(point);
                          },
                        ),
                      ),
                      FloatingMyLocationButton(demoController: demoController),
                    ],
                  ),
                  TechInfoCard(
                    demoController: demoController,
                  ),
                  const BottomActionButtons(),
                ],
              ),
            ),
          ),
        ),
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

  addRow(BuildContext context, {String c1 = '', String c2 = ''}) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 50,
            child: Expanded(
                child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: kTableFieldsBackgroundColor,
                    ),
                    child: Text(
                      c1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 16),
                    ))),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: kTableFieldsBackgroundColor,
                  ),
                  child: Text(c2))),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => InspectionsScreen()),
                (route) => false,
              );
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.orange[400]),
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
    ));
    return rows;
  }
}



// Stack(
//           children: [
            // GoogleMap(
            //   mapType: MapType.normal,
            //   buildingsEnabled: false,
            //   markers: demoController.markers,
            //   polylines: {
            //     ...demoController.polylines,
            //     Polyline(
            //       polylineId: const PolylineId('new_polyline_update'),
            //       consumeTapEvents: true,
            //       color: Colors.green,
            //       width: 5,
            //       points: demoController.markers
            //           .map((marker) => marker.position)
            //           .toList(),
            //     )
            //   },
            //   initialCameraPosition: demoController.initialCameraPosition,
            //   onMapCreated: (googleMapController) async {
            //     await demoController.onMapCreated(googleMapController, context);
            //   },
            //   myLocationEnabled: false,
            //   compassEnabled: false,
            //   myLocationButtonEnabled: false,
            //   zoomControlsEnabled: false,
            //   onTap: (LatLng point) {
            //     demoController.addMarker(point);
            //   },
            // ),
//             FloatingSheetBottom(demoController: demoController)
//           ],
//         )
