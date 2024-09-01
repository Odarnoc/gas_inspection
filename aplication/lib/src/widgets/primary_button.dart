import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.color = kSecondaryColor,
    this.padding = const EdgeInsets.all(kDefaultPadding * 0.85),
    this.fullWidth = true,
  });

  final String text;
  final VoidCallback onPressed;
  final Color color;
  final EdgeInsets padding;
  final IconData? icon;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding * .5),
      child: MaterialButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        padding: padding,
        color: color,
        minWidth: fullWidth ? double.infinity : null,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (icon != null) const SizedBox(width: 20),
            Text(text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                )),
            if (icon != null) Icon(icon, color: Colors.white)
          ],
        ),
      ),
    );
  }
}
