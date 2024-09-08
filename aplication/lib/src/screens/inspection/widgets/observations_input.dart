import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/inspection/inspection_controller.dart';

class ObservationsInput extends StatelessWidget {
  const ObservationsInput({
    super.key,
    required this.inspectionController,
  });

  final InspectionController inspectionController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.75),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: S.of(context).lObservations,
          border: InputBorder.none,
        ),
        initialValue: inspectionController.observations,
        onSaved: (observations) =>
            inspectionController.observations = observations!,
        validator: (value) {
          if (value!.trim().length < 2) {
            return S.of(context).eValidatoCharacters(2);
          }
          return null;
        },
      ),
    );
  }
}
