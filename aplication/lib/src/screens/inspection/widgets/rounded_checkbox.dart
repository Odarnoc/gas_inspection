import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/src/screens/inspection/inspection_controller.dart';

class RoundedCheckbox extends StatelessWidget {
  const RoundedCheckbox({super.key, required this.inspectionController});

  final InspectionController inspectionController;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
      onTap: () {
        inspectionController.checkbox1 = !inspectionController.checkbox1;
      },
      child: Container(
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: kFourthColor),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: inspectionController.checkbox1
              ? const Icon(
                  Icons.check,
                  size: 30.0,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.check_box_outline_blank,
                  size: 30.0,
                  color: kFourthColor,
                ),
        ),
      ),
    ));
  }
}
