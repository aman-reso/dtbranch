// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dtlive/utils/color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyEdittext extends StatelessWidget {
  late String hinttext;
  double size;
  late Color color;
  var textInputAction, controller, keyboardType;
  bool obscureText;

  MyEdittext(
      {Key? key,
      required this.hinttext,
      required this.keyboardType,
      this.controller,
      required this.size,
      required this.color,
      required this.textInputAction,
      required this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: textInputAction,
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      maxLines: 1,
      style: const TextStyle(
        color: white,
        fontSize: 14,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        // fillColor: white,
        hintStyle: TextStyle(
          color: color,
          fontSize: size,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w400,
        ),
        hintText: hinttext,
      ),
    );
  }
}
