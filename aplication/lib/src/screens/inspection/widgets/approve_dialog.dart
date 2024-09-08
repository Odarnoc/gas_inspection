import 'package:flutter/material.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/screens/inspections/inspections_screen.dart';

class ApproveDialog extends StatelessWidget {
  const ApproveDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 60,
              color: Colors.green[400],
            ),
            Text(S.of(context).lUpdateSuccess),
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => InspectionsScreen()),
                      (Route<dynamic> route) {
                    return false;
                  });
                },
                child: Text(S.of(context).bNext))
          ],
        ),
      ),
    );
  }
}
