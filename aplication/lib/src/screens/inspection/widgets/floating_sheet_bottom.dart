import 'package:flutter/material.dart';
import 'package:mikinder/src/screens/inspection/inspection_controller.dart';

class FloatingSheetBottom extends StatelessWidget {
  final InspectionController demoController;
  const FloatingSheetBottom({super.key, required this.demoController});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.1,
      minChildSize: 0.1,
      maxChildSize: 1,
      snap: true,
      snapSizes: const [0.7, 1],
      builder: (context, scrollController) => Container(
        padding: const EdgeInsets.only(top: 0, right: 10, left: 10, bottom: 10),
        color: Colors.white,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                  child: SizedBox(width: 60, child: Divider(thickness: 5))),
              Text(
                'Distancia en metros: ${demoController.distance}',
                style: const TextStyle(fontSize: 10, color: Colors.black),
              ),
              const SizedBox(height: 10),
              ...demoController.markers.map((marker) => Text(
                    '${marker.markerId.value}: ${marker.position.latitude}, ${marker.position.longitude}',
                    style: const TextStyle(fontSize: 10, color: Colors.black),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
