import 'package:flutter/material.dart';
import 'package:mikinder/src/screens/inspection/inspection_controller.dart';

class FloatingMyLocationButton extends StatelessWidget {
  const FloatingMyLocationButton(
      {super.key, required this.inspectionController});
  final InspectionController inspectionController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      right: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {
                inspectionController.cleanMeditions();
              },
              icon: const Icon(Icons.delete_forever),
            ),
          )
        ],
      ),
    );
  }
}
