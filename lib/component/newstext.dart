import 'package:flutter/material.dart';
import 'package:primevideo/utils/colors.dart';

// ignore: must_be_immutable
class NewsText extends StatelessWidget {
  String text;
  VoidCallback ontap;
  NewsText(this.text, this.ontap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 07),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 17, color: textColor),
          ),
          const Icon(
            Icons.chevron_right_sharp,
            color: textColor,
          )
        ],
      ),
    );
  }
}
