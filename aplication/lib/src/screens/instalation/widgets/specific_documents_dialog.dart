import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/src/screens/instalation/instalation_controller.dart';
import 'package:provider/provider.dart';

class SpecificDocumentsDialog extends StatelessWidget {
  const SpecificDocumentsDialog(
      {super.key,
      required this.instalationController,
      required this.title,
      required this.url});

  final String title;
  final String url;

  final InstalationController instalationController;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Scaffold(
        backgroundColor: kThridColor,
        appBar: AppBar(
          backgroundColor: kFourthColor,
        ),
        body: ChangeNotifierProvider<InstalationController>.value(
          value: instalationController,
          child: Consumer<InstalationController>(
            builder: (context, inspectionController, child) => CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
              ),
              items: [
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          InteractiveViewer(
                            panEnabled: false,
                            boundaryMargin: const EdgeInsets.all(100),
                            minScale: 1,
                            maxScale: 5,
                            child: CachedNetworkImage(
                              imageUrl: url,
                              fit: BoxFit.scaleDown,
                              width: 1000.0,
                              placeholder: (context, url) =>
                                  Image.asset('assets/no-image.png'),
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/no-image.png'),
                            ),
                          ),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(200, 0, 0, 0)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: Center(
                                  child: Text(title,
                                      style: const TextStyle(
                                          color: Colors.white))),
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
