import 'package:mikinder/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mikinder/constants/status_constant.dart';
import 'package:mikinder/src/models/request_petition_model.dart';
import 'package:mikinder/src/screens/inspection/widgets/internal_bottom_accion_buttons.dart';
import 'package:mikinder/src/screens/inspection/widgets/internal_bottom_accion_buttons2.dart';
import 'package:mikinder/src/screens/inspection/widgets/internal_proyect_infomation_card.dart';
import 'package:mikinder/src/screens/inspection/widgets/internal_specific_files_accion_buttons.dart';
import 'package:mikinder/src/screens/inspection/widgets/proyect_infomation_card.dart';
import 'package:mikinder/src/screens/inspection/widgets/specific_files_accion_buttons.dart';
import 'package:mikinder/src/screens/inspection/widgets/user_infomation_card.dart';
import 'package:mikinder/src/screens/inspections/inspections_controller.dart';
import 'package:mikinder/src/screens/inspections/inspections_screen.dart';
import 'package:mikinder/src/screens/inspection/inspection_controller.dart';
import 'package:mikinder/src/screens/inspection/widgets/bottom_accion_buttons.dart';
import 'package:provider/provider.dart';

class InspectionScreen extends StatelessWidget {
  const InspectionScreen({
    super.key,
    required this.requestPetition,
    required this.inspectionsController,
  });

  final RequestPetitionModel requestPetition;
  final InspectionsController inspectionsController;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InspectionController>.value(
      value: InspectionController(requestPetition),
      child: Consumer<InspectionController>(
        builder: (context, inspectionController, child) => SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: kFourthColor,
            ),
            backgroundColor: kThridColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  UserInformationCard(
                      inspectionController: inspectionController),
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
                          markers: inspectionController.markers,
                          polylines: {
                            ...inspectionController.polylines,
                          },
                          initialCameraPosition:
                              inspectionController.initialCameraPosition,
                          onMapCreated: (googleMapController) async {
                            await inspectionController.onMapCreated(
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
                  Visibility(
                    visible: inspectionController.requestPetition.status ==
                        StatusProyect.assigned,
                    child: ProyectInformationCard(
                        inspectionController: inspectionController),
                  ),
                  Visibility(
                    visible: inspectionController.requestPetition.status ==
                        StatusProyect.interrnalInspection,
                    child: InternalProyectInformationCard(
                        inspectionController: inspectionController),
                  ),
                  SpecificActionsActionButtons(
                    inspectionController: inspectionController,
                  ),
                  Visibility(
                    visible: inspectionController.requestPetition.status ==
                        StatusProyect.assigned,
                    child: BottomActionButtons(
                      inspectionController: inspectionController,
                      inspectionsController: inspectionsController,
                    ),
                  ),
                  /* Visibility(
                    visible: inspectionController.requestPetition.status ==
                        StatusProyect.interrnalInspection,
                    child: InternalSpecificActionsActionButtons(
                      inspectionController: inspectionController,
                    ),
                  ), */
                  Visibility(
                    visible: inspectionController.requestPetition.status ==
                        StatusProyect.interrnalInspection,
                    child: InternalBottomActionButtons(
                      inspectionController: inspectionController,
                      inspectionsController: inspectionsController,
                    ),
                  ),
                  Visibility(
                    visible: inspectionController.requestPetition.status ==
                        StatusProyect.interrnalInspection,
                    child: InternalBottomActionButtons2(
                      inspectionController: inspectionController,
                      inspectionsController: inspectionsController,
                    ),
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
