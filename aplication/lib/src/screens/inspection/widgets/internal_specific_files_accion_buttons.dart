import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/inspection/inspection_controller.dart';
import 'package:mikinder/src/screens/inspection/widgets/specific_documents_dialog.dart';

class InternalSpecificActionsActionButtons extends StatelessWidget {
  const InternalSpecificActionsActionButtons(
      {super.key, required this.inspectionController});

  final InspectionController inspectionController;

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
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => SpecificDocumentsDialog(
                          inspectionController: inspectionController,
                          title: S.of(context).lIsometric,
                          url: inspectionController.requestPetition.isometric,
                        ),
                      );
                    },
                    style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
                      backgroundColor:
                          const WidgetStatePropertyAll(kPrimaryColor),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    child: Text(
                      S.of(context).bViewIsometric,
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
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => SpecificDocumentsDialog(
                          inspectionController: inspectionController,
                          title: S.of(context).lFloorPlan,
                          url: inspectionController.requestPetition.floorPlan,
                        ),
                      );
                    },
                    style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
                      backgroundColor:
                          const WidgetStatePropertyAll(kFivethColor),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    child: Text(
                      S.of(context).bViewFloorPlan,
                      style: const TextStyle(
                          color: Colors.white,
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
