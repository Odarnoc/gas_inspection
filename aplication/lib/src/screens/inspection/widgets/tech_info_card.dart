import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/src/screens/inspection/inspection_controller.dart';
import 'package:mikinder/src/screens/inspection/widgets/point_list_item.dart';

class TechInfoCard extends StatelessWidget {
  final InspectionController demoController;
  const TechInfoCard({super.key, required this.demoController});

  final valueSize = 10.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Container(
        color: kTableFieldsBackgroundColor,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'DATOS TECNICOS',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ...demoController.markers.map((marker) => PointListItem(
                valueSize: valueSize,
                value:
                    '${marker.position.latitude}, ${marker.position.longitude}',
                valueIndex: marker.markerId.value)),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5),
              child: Row(
                children: [
                  const Text(
                    'TOTAL EN MTS',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: kFieldsBackgroundColor,
                    ),
                    child: Text(
                      '${demoController.distance}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: valueSize,
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: kFieldsBackgroundColor,
                      ),
                      child: Text(
                        'Observaciones',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: valueSize,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
