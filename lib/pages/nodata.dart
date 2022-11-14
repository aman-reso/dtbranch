import 'package:dtlive/utils/color.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: appBgColor,
        borderRadius: BorderRadius.circular(12),
        shape: BoxShape.rectangle,
      ),
      constraints: const BoxConstraints(minHeight: 0, minWidth: 0),
      child: Center(
        child: MyImage(
          height: 180,
          fit: BoxFit.contain,
          imagePath: "nodata.png",
        ),
      ),
    );
  }
}
