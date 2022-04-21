import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevideo/utils/colors.dart';

class ChannelText extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  ChannelText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 15),
      child: Row(
        children: [
          Text(
            "Eros Now",
            style: TextStyle(color: blueGrey300, fontSize: 11),
          )
        ],
      ),
    );
  }
}
