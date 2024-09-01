import 'package:flutter/material.dart';

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
            const Text('Aprobado'),
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Continuar"))
          ],
        ),
      ),
    );
  }
}
