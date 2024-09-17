import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/instalation/widgets/custom_field_expanded.dart';
import 'package:mikinder/src/screens/instalation/instalation_controller.dart';

class UserInformationCard extends StatelessWidget {
  const UserInformationCard({super.key, required this.instalationController});

  final InstalationController instalationController;

  final Color textColor = Colors.white;

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
              S.of(context).lUserInfo,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
      child: Row(
        children: <Widget>[
          CustomFieldExpanded(
              text: S.of(context).lName,
              backgroundColor: kTableFieldsBackgroundColor),
          const SizedBox(width: 10),
          CustomFieldExpanded(
              text: instalationController.requestPetition.firstName,
              backgroundColor: kFourthColor),
          const SizedBox(width: 10),
          CustomFieldExpanded(
              text: S.of(context).lLastName,
              backgroundColor: kTableFieldsBackgroundColor),
          const SizedBox(width: 10),
          CustomFieldExpanded(
              text:
                  '${instalationController.requestPetition.maternalName} ${instalationController.requestPetition.paternalName}',
              backgroundColor: kFourthColor),
        ],
      ),
    );
  }

  fila2(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          CustomFieldExpanded(
              text: S.of(context).lPhone,
              backgroundColor: kTableFieldsBackgroundColor),
          const SizedBox(width: 10),
          CustomFieldExpanded(
              text: instalationController.requestPetition.phone,
              backgroundColor: kFourthColor),
          const SizedBox(width: 10),
          CustomFieldExpanded(
              text: S.of(context).lAdrreess,
              backgroundColor: kTableFieldsBackgroundColor),
          const SizedBox(width: 10),
          CustomFieldExpanded(
              text:
                  '${instalationController.requestPetition.street} Nro. ${instalationController.requestPetition.door}',
              backgroundColor: kFourthColor),
        ],
      ),
    );
  }
}
