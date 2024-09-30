import 'package:flutter/material.dart';
import 'package:mikinder/src/screens/inspection/inspection_controller.dart';

class FloatingMapTypeButton extends StatelessWidget {
  const FloatingMapTypeButton({super.key, required this.inspectionController});
  final InspectionController inspectionController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 20,
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
                inspectionController.changeMapType();
              },
              icon: const Icon(Icons.map),
            ),
          )
        ],
      ),
    );
  }
}
