import 'package:dtlive/utils/color.dart';
import 'package:dtlive/widget/channelsportrait.dart';
import 'package:flutter/material.dart';

class Channels extends StatefulWidget {
  const Channels({Key? key}) : super(key: key);

  @override
  State<Channels> createState() => ChannelsState();
}

class ChannelsState extends State<Channels> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            // Channelslandscap(),
            // ChannelsSqure()
            ChannelsPortrait()
          ],
        ),
      ),
    );
  }
}
