import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';

class RoundedCheckbox extends StatelessWidget {
  const RoundedCheckbox(
      {super.key, required this.value, required this.onPressed});

  final bool value;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 3)),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: value
              ? const Icon(
                  Icons.check,
                  size: 20.0,
                  color: Colors.black,
                )
              : const Icon(
                  Icons.check_box_outline_blank,
                  size: 20.0,
                  color: Colors.white,
                ),
        ),
      ),
    ));
  }
}
