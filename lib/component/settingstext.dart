import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevideo/utils/colors.dart';

// ignore: must_be_immutable
class SettingUIText extends StatelessWidget {
  String text;
  SettingUIText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: textColor, fontSize: 16),
    );
  }
}
