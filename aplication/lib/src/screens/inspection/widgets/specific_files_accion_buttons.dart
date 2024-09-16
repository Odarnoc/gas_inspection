import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/common/file_helper.dart';
import 'package:mikinder/src/common/file_routes_constant.dart';
import 'package:mikinder/src/screens/inspection/inspection_controller.dart';
import 'package:mikinder/src/screens/inspection/widgets/specific_documents_dialog.dart';
import 'package:mikinder/src/widgets/upload_file/upload_file.dart';

class SpecificActionsActionButtons extends StatelessWidget {
  const SpecificActionsActionButtons(
      {super.key, required this.inspectionController});

  final InspectionController inspectionController;

  final valueSize = 10.0;
  final GlobalKey _menuKey = const GlobalObjectKey('menu1');
  final GlobalKey _menuKey2 = const GlobalObjectKey('menu2');

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
                  child: PopupMenuButton(
                    key: _menuKey,
                    itemBuilder: (_) => <PopupMenuItem<String>>[
                      PopupMenuItem(
                        onTap: () {
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
                                  imageUpload,
                                  inspectionController.requestPetition.id);
                            }),
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.upload,
                              color: Colors.black,
                            ),
                            Text(S.of(context).bUpload),
                          ],
                        ),
                      ),
                      if (inspectionController
                          .requestPetition.isometric.isNotEmpty)
                        PopupMenuItem(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => SpecificDocumentsDialog(
                                inspectionController: inspectionController,
                                title: S.of(context).lIsometric,
                                url: inspectionController
                                    .requestPetition.isometric,
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.remove_red_eye,
                                color: Colors.black,
                              ),
                              Text(S.of(context).bView),
                            ],
                          ),
                        ),
                    ],
                    onSelected: (_) {},
                    child: ElevatedButton(
                      onPressed: () {
                        dynamic state = _menuKey.currentState;
                        state.showButtonMenu();
                      },
                      style: ButtonStyle(
                        padding:
                            const WidgetStatePropertyAll(EdgeInsets.all(10)),
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
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: PopupMenuButton(
                    key: _menuKey2,
                    itemBuilder: (_) => <PopupMenuItem<String>>[
                      PopupMenuItem(
                        onTap: () {
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
                                  imageUpload,
                                  inspectionController.requestPetition.id);
                            }),
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.upload,
                              color: Colors.black,
                            ),
                            Text(S.of(context).bUpload),
                          ],
                        ),
                      ),
                      if (inspectionController
                          .requestPetition.floorPlan.isNotEmpty)
                        PopupMenuItem(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => SpecificDocumentsDialog(
                                inspectionController: inspectionController,
                                title: S.of(context).lFloorPlan,
                                url: inspectionController
                                    .requestPetition.floorPlan,
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.remove_red_eye,
                                color: Colors.black,
                              ),
                              Text(S.of(context).bView),
                            ],
                          ),
                        ),
                    ],
                    onSelected: (_) {},
                    child: ElevatedButton(
                      onPressed: () {
                        dynamic state = _menuKey2.currentState;
                        state.showButtonMenu();
                      },
                      style: ButtonStyle(
                        padding:
                            const WidgetStatePropertyAll(EdgeInsets.all(10)),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
