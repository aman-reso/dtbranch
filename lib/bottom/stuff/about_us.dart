import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevideo/component/divider.dart';
import 'package:primevideo/component/smalltext.dart';
import 'package:primevideo/utils/colors.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        backgroundColor: appBgColor,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: appBgColor,
        ),
        title: const Text(
          "About & Legal",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Version",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            SmallText("1.0"),
            SizedBox(
              height: 10,
            ),
            SmallText(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard text."),
            SizedBox(
              height: 10,
            ),
            DividerUI(),
            SizedBox(
              height: 10,
            ),
            Text(
              "Terms and Privacy Notice",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            DividerUI(),
            SizedBox(
              height: 10,
            ),
            Text(
              "3rd party notices",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            DividerUI(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
