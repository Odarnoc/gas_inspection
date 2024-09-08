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
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: kFourthColor),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: value
              ? const Icon(
                  Icons.check,
                  size: 30.0,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.check_box_outline_blank,
                  size: 30.0,
                  color: kFourthColor,
                ),
        ),
      ),
    ));
  }
}
