import 'package:flutter/material.dart';
import 'package:primevideo/utils/colors.dart';

// ignore: must_be_immutable
class ChannelNewsText extends StatefulWidget {
  String text;
  VoidCallback ontap;
  ChannelNewsText(this.text, this.ontap, {Key? key}) : super(key: key);

  @override
  State<ChannelNewsText> createState() => _ChannelNewsTextState();
}

class _ChannelNewsTextState extends State<ChannelNewsText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 05),
      child: Row(
        children: [
          Text(
            widget.text,
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
