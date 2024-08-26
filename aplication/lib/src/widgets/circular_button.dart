import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton(
      {super.key,
      this.onPressed,
      required this.icon,
      this.bgColor,
      this.onLongPress});

  final Function? onPressed;
  final Widget icon;
  final Color? bgColor;
  final Function? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            shape: BoxShape.rectangle,
            color: bgColor ?? Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 1,
                color: Colors.grey.shade300,
                offset: const Offset(3, 3),
              ),
            ],
          ),
          child: icon,
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                splashColor: Colors.blueAccent.withOpacity(0.6),
                onTap: () {
                  if (onPressed != null) {
                    onPressed!();
                  }
                },
                onLongPress: () {
                  if (onLongPress != null) {
                    onLongPress!();
                  }
                }),
          ),
        ),
      ],
    );
  }
}
