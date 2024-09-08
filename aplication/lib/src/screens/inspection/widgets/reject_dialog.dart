import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/inspection/inspection_controller.dart';
import 'package:mikinder/src/screens/inspection/widgets/observations_input.dart';
import 'package:mikinder/src/screens/inspections/inspections_screen.dart';

class RejectDialog extends StatelessWidget {
  RejectDialog(this.inspectionController, {super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final InspectionController inspectionController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(kDefaultPadding * 1.6),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ObservationsInput(inspectionController: inspectionController),
          ],
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.reply_outlined),
              const SizedBox(width: kDefaultPadding * .5),
              Text(S.of(context).bCancel),
              const SizedBox(width: kDefaultPadding * .5),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () async {
            _formKey.currentState!.save();
            if (!_formKey.currentState!.validate()) return;
            final navigator = Navigator.of(context);
            bool result = await inspectionController.rejectProyect();
            if (!result) return;
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => InspectionsScreen()),
                (Route<dynamic> route) {
              return false;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.save_outlined),
              const SizedBox(width: kDefaultPadding * .5),
              Text(S.of(context).bSaveChanges),
              const SizedBox(width: kDefaultPadding * .5),
            ],
          ),
        )
      ],
    );
  }
}
