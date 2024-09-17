import 'package:mikinder/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mikinder/src/models/request_petition_model.dart';
import 'package:mikinder/src/screens/instalation/widgets/specific_files_accion_buttons.dart';
import 'package:mikinder/src/screens/instalation/widgets/user_infomation_card.dart';
import 'package:mikinder/src/screens/instalation/instalation_controller.dart';
import 'package:mikinder/src/screens/instalation/widgets/bottom_accion_buttons.dart';
import 'package:mikinder/src/screens/inspections/inspections_screen.dart';
import 'package:mikinder/src/screens/instalations/instalations_screen.dart';
import 'package:provider/provider.dart';

class InstalationScreen extends StatelessWidget {
  const InstalationScreen({
    super.key,
    required this.requestPetition,
  });

  final RequestPetitionModel requestPetition;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InstalationController>.value(
      value: InstalationController(requestPetition),
      child: Consumer<InstalationController>(
        builder: (context, instalationController, child) => SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: kFourthColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => InstalationsScreen()),
                    (Route<dynamic> route) {
                  return false;
                }),
              ),
            ),
            backgroundColor: kThridColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  UserInformationCard(
                      instalationController: instalationController),
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          left: kDefaultPadding * 1.3,
                          right: kDefaultPadding * 1.3,
                        ),
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
                          markers: instalationController.markers,
                          polylines: {
                            ...instalationController.polylines,
                          },
                          initialCameraPosition:
                              instalationController.initialCameraPosition,
                          onMapCreated: (googleMapController) async {
                            await instalationController.onMapCreated(
                                googleMapController, context);
                          },
                          myLocationEnabled: false,
                          compassEnabled: false,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                        ),
                      ),
                      // FloatingMyLocationButton(demoController: demoController),
                    ],
                  ),
                  SpecificActionsActionButtons(
                    instalationController: instalationController,
                  ),
                  BottomActionButtons(
                    instalationController: instalationController,
                  ),
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
