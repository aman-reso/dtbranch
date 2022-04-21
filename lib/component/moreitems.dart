import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevideo/utils/colors.dart';

// ignore: must_be_immutable
class MoreItems extends StatelessWidget {
  IconData icon;
  String text;

  MoreItems(this.icon, this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 25),
      child: Row(
        children: [
          Icon(
            icon,
            color: greyColor,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            text,
            style: const TextStyle(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
          )
        ],
      ),
    );
  }
}
