import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:primevideo/bottom/home/hometab.dart';
import 'package:primevideo/bottom/home/kids.dart';
import 'package:primevideo/bottom/home/movies.dart';
import 'package:primevideo/bottom/home/tv_show_tab.dart';
import 'package:primevideo/utils/colors.dart';

List<String> images = [
  'assets/images/action_jection.jpg',
  'assets/images/money_heist.jpg',
  'assets/images/kgf.jpg',
  'assets/images/action_jection.jpg',
  'assets/images/money_heist.jpg',
  'assets/images/kgf.jpg',
  'assets/images/action_jection.jpg',
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  // ignore: prefer_typing_uninitialized_variables
  var controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: appBgColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  const Text(
                    "prime video",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: textColor),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  tabbar(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: const TabBarView(
                        children: [HomeTab(), TVShow(), Movies(), Kids()]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  // ignore: unused_element
  Future<bool?> _showExitDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
  }

  Dialog _buildExitDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: 180,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "PrimeVideoApp",
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Do you want to exit?",
                  style: TextStyle(color: greyColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    raisedButton("NO", textColor, blackColor, () {
                      Navigator.pop(context);
                    }),
                    const SizedBox(
                      width: 10,
                    ),
                    raisedButton("YES", blugGreyDark, textColor, () {
                      exit(0);
                    })
                  ],
                )
              ],
            ),
          ),
          Positioned(
              top: -30,
              child: CircleAvatar(
                  backgroundColor: textColor,
                  radius: 40,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: textColor,
                      borderRadius: BorderRadius.circular(55),
                      image: const DecorationImage(
                          image: AssetImage('assets/icons/alert.png'),
                          fit: BoxFit.fill),
                    ),
                  )))
        ],
      ),
    );
  }

  tabbar() {
    return const TabBar(
      tabs: [
        Tab(
          child: Text(
            "Home",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        Tab(
          child: Text(
            "TV Shows",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        Tab(
          child: Text(
            "Movies",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        Tab(
          child: Text(
            "Kids",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        )
      ],
      indicatorColor: textColor,
      indicatorWeight: 2,
    );
  }

  final List<Widget> imageSlider = images
      .map((items) => SizedBox(
            child: Image.asset(
              items,
              fit: BoxFit.fill,
            ),
          ))
      .toList();

  raisedButton(text, color, textcolor, VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: 80,
        height: 40,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(10),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
              const BoxShadow(
                color: black26,
                blurRadius: 05.0,
              )
            ]),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 15, color: textcolor),
          ),
        ),
      ),
    );
  }
}