import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/common/file_helper.dart';
import 'package:mikinder/src/common/file_routes_constant.dart';
import 'package:mikinder/src/screens/inspection/inspection_controller.dart';
import 'package:mikinder/src/widgets/upload_file/upload_file.dart';

class SpecificActionsActionButtons extends StatelessWidget {
  const SpecificActionsActionButtons(
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
                        builder: (context) => UploadFile((image) async {
                          inspectionController.inAsyncCall = true;
                          String imageUpload = await uploadFile(
                              image,
                              '${GeneralRoutes.proyects}${inspectionController.requestPetition.id}/${SpecificRoutes.isometric}',
                              '${inspectionController.requestPetition.id}-${DateTime.now().toIso8601String()}',
                              kTargetWidthUser,
                              isDocument: true);
                          inspectionController.updateUrlIsometric(
                              context,
                              imageUpload,
                              inspectionController.requestPetition.id);
                        }),
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
                      S.of(context).bUploadIsometric,
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
                        builder: (context) => UploadFile((image) async {
                          inspectionController.inAsyncCall = true;
                          String imageUpload = await uploadFile(
                              image,
                              '${GeneralRoutes.proyects}${inspectionController.requestPetition.id}/${SpecificRoutes.floorPlan}',
                              '${inspectionController.requestPetition.id}-${DateTime.now().toIso8601String()}',
                              kTargetWidthUser,
                              isDocument: true);
                          inspectionController.updateUrlFloorPlan(
                              context,
                              imageUpload,
                              inspectionController.requestPetition.id);
                        }),
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
                      S.of(context).bUploadFloorPlan,
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
