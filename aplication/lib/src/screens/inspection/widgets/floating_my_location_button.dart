import 'package:flutter/material.dart';
import 'package:mikinder/src/screens/inspection/inspection_controller.dart';

class FloatingMyLocationButton extends StatelessWidget {
  const FloatingMyLocationButton({super.key, required this.demoController});
  final InspectionController demoController;

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
              onPressed: () {},
              icon: const Icon(Icons.my_location),
            ),
          )
        ],
      ),
    );
  }
}
