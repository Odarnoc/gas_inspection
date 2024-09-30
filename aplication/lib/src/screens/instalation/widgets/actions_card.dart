import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/inspection/widgets/custom_field_expanded.dart';
import 'package:mikinder/src/screens/instalation/instalation_controller.dart';
import 'package:mikinder/src/screens/instalation/widgets/bottom_accion_buttons.dart';
import 'package:mikinder/src/screens/instalation/widgets/specific_documents_dialog.dart';

class ActionsCard extends StatelessWidget {
  const ActionsCard({super.key, required this.instalationController});

  final InstalationController instalationController;

  final Color textColor = Colors.white;
  final Color fieldsTextColor = Colors.black;

  final double padding = 10.0;
  final double borderRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Card(
        color: kCardsBackgroundColor,
        child: Column(
          children: [
            const SizedBox(
              height: kDefaultPadding,
            ),
            Text(
              S.of(context).lProyectInfo,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                children: [
                  fila1(context),
                  const SizedBox(
                    height: kDefaultPadding * .3,
                  ),
                  fila2(context),
                  const SizedBox(
                    height: kDefaultPadding * 2,
                  ),
                  BottomActionButtons(
                    instalationController: instalationController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  fila1(BuildContext context) {
    return IntrinsicHeight(
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => SpecificDocumentsDialog(
              instalationController: instalationController,
              title: S.of(context).lIsometric,
              url: instalationController.requestPetition.isometric,
            ),
          );
        },
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 40,
              child: Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    color: kTableHeadersBackgroundColor,
                  ),
                  child: Text(
                    '1',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: textColor,
                    ),
                  )),
            ),
            const SizedBox(width: 10),
            CustomFieldExpanded(
                text: S.of(context).lIsometric,
                textColor: fieldsTextColor,
                backgroundColor: kTableFieldsBackgroundColor2),
            const SizedBox(width: 10),
            const Icon(Icons.remove_red_eye)
          ],
        ),
      ),
    );
  }

  fila2(BuildContext context) {
    return IntrinsicHeight(
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => SpecificDocumentsDialog(
              instalationController: instalationController,
              title: S.of(context).lFloorPlan,
              url: instalationController.requestPetition.floorPlan,
            ),
          );
        },
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 40,
              child: Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    color: kTableHeadersBackgroundColor,
                  ),
                  child: Text(
                    '2',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: textColor,
                    ),
                  )),
            ),
            const SizedBox(width: 10),
            CustomFieldExpanded(
                text: S.of(context).lFloorPlan,
                textColor: fieldsTextColor,
                backgroundColor: kTableFieldsBackgroundColor2),
            const SizedBox(width: 10),
            const Icon(Icons.remove_red_eye)
          ],
        ),
      ),
    );
  }
}
