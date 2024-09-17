import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/inspection/inspection_controller.dart';
import 'package:mikinder/src/screens/inspection/widgets/approve_dialog.dart';
import 'package:mikinder/src/screens/inspections/inspections_controller.dart';
import 'package:mikinder/src/screens/inspections/inspections_screen.dart';

class InternalBottomActionButtons2 extends StatelessWidget {
  const InternalBottomActionButtons2(
      {super.key,
      required this.inspectionController,
      required this.inspectionsController});

  final InspectionController inspectionController;
  final InspectionsController inspectionsController;

  final valueSize = 10.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding,
          top: 0,
          bottom: kDefaultPadding),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      bool result =
                          await inspectionController.internalRejectProyect();
                      if (!result) return;
                      navigator.pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => InspectionsScreen()),
                          (Route<dynamic> route) {
                        return false;
                      });
                    },
                    style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
                      backgroundColor:
                          const WidgetStatePropertyAll(kErrorColor),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    child: Text(
                      S.of(context).bReject,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      bool result =
                          await inspectionController.internalApproveProyect(
                              context, inspectionController.requestPetition.id);
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
                      backgroundColor:
                          const WidgetStatePropertyAll(kPositiveColor),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    child: Text(
                      S.of(context).bAprove,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
