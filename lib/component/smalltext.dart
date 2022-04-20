import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SmallText extends StatefulWidget {
  String text;
  SmallText(this.text, {Key? key}) : super(key: key);

  @override
  State<SmallText> createState() => _SmallTextState();
}

class _SmallTextState extends State<SmallText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        color: Colors.blueGrey[500],
      ),
    );
  }
}
