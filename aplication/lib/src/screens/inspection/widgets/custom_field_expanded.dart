import 'package:flutter/material.dart';

class CustomFieldExpanded extends StatelessWidget {
  const CustomFieldExpanded(
      {super.key,
      required this.text,
      required this.backgroundColor,
      this.textColor = Colors.white});

  final String text;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: backgroundColor,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
              ),
            )));
  }
}
