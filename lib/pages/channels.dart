import 'package:dtlive/pages/detailpage.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/mytext.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/myimage.dart';

class Channels extends StatefulWidget {
  const Channels({Key? key}) : super(key: key);

  @override
  State<Channels> createState() => ChannelsState();
}

class ChannelsState extends State<Channels> {
  PageController pageController = PageController();

  List<String> pageviewImgList = <String>[
    "ic_homebanner.png",
    "ic_homebanner.png",
    "ic_homebanner.png",
    "ic_homebanner.png",
  ];

  List<String> recentmoviList = <String>[
    "ic_recentmovi1.png",
    "ic_recentmovi2.png",
    "ic_recentmovi1.png",
    "ic_recentmovi2.png",
  ];

  List<String> specialOrignalMovi = <String>[
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
  ];

  List<String> actionmoviList = <String>[
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            homebanner(),
            landscap("Sony SAB", "Sony Tv Top Show"),
            portrait("India TV", "Sony Tv Top Sony Latest Movies"),
            square("ABP News", "DD Girnar show"),
            landscap("Times Now India", "Top Movies"),
            portrait("Animal Planets", "Movie Genres"),
            square("India TV", "Namaste Bharat"),
          ],
        ),
      ),
    );
  }

  Widget homebanner() {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: PageView.builder(
            itemCount: pageviewImgList.length,
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const DetailPage();
                      },
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: white,
                  child: MyImage(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.fill,
                      imagePath: pageviewImgList[index]),
                ),
              );
            },
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SmoothPageIndicator(
                controller: pageController,
                count: pageviewImgList.length,
                axisDirection: Axis.horizontal,
                effect: const ExpandingDotsEffect(
                    spacing: 5.0,
                    radius: 5.0,
                    dotWidth: 5.0,
                    dotHeight: 5.0,
                    dotColor: Colors.grey,
                    activeDotColor: bottomnavigationText),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget landscap(String channal, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 65,
            margin: const EdgeInsets.fromLTRB(10, 0, 15, 0),
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                      color: white,
                      text: channal,
                      textalign: TextAlign.center,
                      fontsize: 10,
                      maxline: 1,
                      fontwaight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis,
                      fontstyle: FontStyle.normal),
                  const SizedBox(
                    height: 5,
                  ),
                  MyText(
                      color: white,
                      text: title,
                      textalign: TextAlign.center,
                      fontsize: 16,
                      maxline: 1,
                      fontwaight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                      fontstyle: FontStyle.normal),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: recentmoviList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 175,
                  height: 100,
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: MyImage(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.cover,
                        imagePath: recentmoviList[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget portrait(String channal, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 65,
            margin: const EdgeInsets.fromLTRB(10, 0, 15, 0),
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                      color: white,
                      text: channal,
                      textalign: TextAlign.center,
                      fontsize: 10,
                      maxline: 1,
                      fontwaight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis,
                      fontstyle: FontStyle.normal),
                  const SizedBox(
                    height: 5,
                  ),
                  MyText(
                      color: white,
                      text: title,
                      textalign: TextAlign.center,
                      fontsize: 16,
                      maxline: 1,
                      fontwaight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                      fontstyle: FontStyle.normal),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 140,
            child: ListView.builder(
              itemCount: specialOrignalMovi.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: MyImage(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.cover,
                          imagePath: specialOrignalMovi[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget square(String channal, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 65,
            margin: const EdgeInsets.fromLTRB(10, 0, 15, 0),
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                      color: white,
                      text: channal,
                      textalign: TextAlign.center,
                      fontsize: 10,
                      maxline: 1,
                      fontwaight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis,
                      fontstyle: FontStyle.normal),
                  const SizedBox(
                    height: 5,
                  ),
                  MyText(
                      color: white,
                      text: title,
                      textalign: TextAlign.center,
                      fontsize: 16,
                      maxline: 1,
                      fontwaight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                      fontstyle: FontStyle.normal),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: ListView.builder(
              itemCount: actionmoviList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 7),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: MyImage(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.cover,
                          imagePath: actionmoviList[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
