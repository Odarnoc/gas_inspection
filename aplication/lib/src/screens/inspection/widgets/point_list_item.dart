import 'package:flutter/material.dart';
import 'package:mikinder/constants/constants.dart';

class PointListItem extends StatelessWidget {
  final double valueSize;
  final String valueIndex;
  final String value;
  const PointListItem(
      {super.key,
      required this.valueSize,
      required this.value,
      required this.valueIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5),
      child: Row(
        children: [
          Text(
            valueIndex,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: kFieldsBackgroundColor,
                  ),
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: valueSize),
                  ))),
        ],
      ),
    );
  }
}
