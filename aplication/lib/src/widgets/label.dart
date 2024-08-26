import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color? titleColor;
  final Color? subtitleColor;
  final Widget? append;
  final Widget? preppend;

  const Label(
    this.title,
    this.subtitle, {
    super.key,
    this.titleColor,
    this.subtitleColor,
    this.append,
    this.preppend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, bottom: 10.0, top: 12.0),
      child: Row(
        children: [
          ...appendChildren(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 16.0, color: titleColor)),
              const SizedBox(height: 5.0),
              Text(subtitle,
                  style: TextStyle(color: subtitleColor ?? Colors.blueGrey)),
            ],
          ),
          ...preppendChildren(),
        ],
      ),
    );
  }

  List<Widget> appendChildren() {
    return append != null
        ? [
            append!,
            const SizedBox(width: 10.0),
          ]
        : [];
  }

  List<Widget> preppendChildren() {
    return preppend != null
        ? [
            preppend!,
            const SizedBox(width: 10.0),
          ]
        : [];
  }
}
