import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/src/common/file_helper.dart';
import 'package:mikinder/src/common/file_routes_constant.dart';
import 'package:mikinder/src/screens/inspection/inspection_controller.dart';
import 'package:mikinder/src/screens/inspection/widgets/document_%20bottom_accion_buttons.dart';
import 'package:mikinder/src/widgets/upload_file/upload_file.dart';
import 'package:provider/provider.dart';

class DocumentsDialog extends StatelessWidget {
  const DocumentsDialog({super.key, required this.inspectionController});

  final InspectionController inspectionController;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Scaffold(
        backgroundColor: kThridColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => UploadFile((image) async {
                inspectionController.inAsyncCall = true;
                String imageUpload = await uploadFile(
                    image,
                    '${GeneralRoutes.proyects}${inspectionController.requestPetition.id}/${SpecificRoutes.extras}',
                    '${inspectionController.requestPetition.id}-${DateTime.now().toIso8601String()}',
                    kTargetWidthUser,
                    isDocument: true);
                inspectionController.addDocument(context, imageUpload);
              }),
            );
          },
          child: const Icon(Icons.add_a_photo),
        ),
        appBar: AppBar(
          backgroundColor: kFourthColor,
        ),
        body: ChangeNotifierProvider<InspectionController>.value(
          value: inspectionController,
          child: Consumer<InspectionController>(
            builder: (context, inspectionController, child) => CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
              ),
              items: inspectionController.documents
                  .map((item) => Container(
                        margin: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5.0)),
                            child: Stack(
                              children: <Widget>[
                                CachedNetworkImage(
                                  imageUrl: item.documentUrl,
                                  fit: BoxFit.scaleDown,
                                  width: 1000.0,
                                  placeholder: (context, url) =>
                                      Image.asset('assets/no-image.png'),
                                  errorWidget: (context, url, error) =>
                                      Image.asset('assets/no-image.png'),
                                ),
                                Positioned(
                                  bottom: 0.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(200, 0, 0, 0),
                                          Color.fromARGB(0, 0, 0, 0)
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    child: DocumentBottomActionButtons(
                                      inspectionController:
                                          inspectionController,
                                      onPressed: () {
                                        inspectionController.deleteDocument(
                                            context, item.id);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
