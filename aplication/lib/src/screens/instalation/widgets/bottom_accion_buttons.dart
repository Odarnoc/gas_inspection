import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/instalation/instalation_controller.dart';
import 'package:mikinder/src/screens/instalation/widgets/approve_dialog.dart';

class BottomActionButtons extends StatelessWidget {
  const BottomActionButtons({
    super.key,
    required this.instalationController,
  });

  final InstalationController instalationController;

  final valueSize = 10.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              bool result =
                  await instalationController.finishInstalationProyect(
                      context, instalationController.requestPetition.id);
              if (result) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const ApproveDialog(),
                );
              }
            },
            style: ButtonStyle(
              padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
              backgroundColor: const WidgetStatePropertyAll(kPositiveColor),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            child: Text(
              S.of(context).bRequestInspection,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
