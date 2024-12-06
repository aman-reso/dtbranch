import 'dart:developer';

import 'package:dtlive/pages/bottombar.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => IntroState();
}

class IntroState extends State<Intro> {
  PageController pageController = PageController();
  final currentPageNotifier = ValueNotifier<int>(0);
  int position = 0;

  List<String> introBigtext = <String>[
    "intro1title",
    "intro2title",
    "intro3title"
  ];

  List<String> introPager = <String>[
    "image1.png",
    "image2.png",
    "image3.png"
  ];

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      body: Container(
        color: Colors.white, // Set background color to white
        child: Stack(
          children: [
            PageView.builder(
              itemCount: introPager.length,
              controller: pageController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: MyImage(
                    imagePath: introPager[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
              onPageChanged: (index) {
                position = index;
                currentPageNotifier.value = index;
                debugPrint("position :==> $position");
                setState(() {});
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 80,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: introPager.length,
                  axisDirection: Axis.horizontal,
                  effect: const ExpandingDotsEffect(
                    spacing: 6,
                    radius: 5,
                    dotWidth: 10,
                    expansionFactor: 4,
                    dotHeight: 10,
                    dotColor: grayDark,
                    activeDotColor: primaryColor,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 16,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16), // Add left and right padding
                child: InkWell(
                  onTap: () {
                    if (position == introPager.length - 1) {
                      Utils.setFirstTime("1");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const Bottombar();
                          },
                        ),
                      );
                    }
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: 0,
                      maxHeight: 45,
                      minWidth: 0,
                      maxWidth: 170,
                    ),
                    padding: const EdgeInsets.all(12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primaryDark,
                      borderRadius: BorderRadius.circular(5),
                      shape: BoxShape.rectangle,
                    ),
                    child: MyText(
                      color: white,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      multilanguage: true,
                      text: (position == introPager.length - 1) ? "getstarted" : "next",
                      textalign: TextAlign.center,
                      fontsizeNormal: 16,
                      fontsizeWeb: 18,
                      fontweight: FontWeight.w700,
                      fontstyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



}
