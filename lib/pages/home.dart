import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/myimage.dart';
import 'package:dtlive/utils/mytext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController tabController =
      TabController(length: tabname.length, vsync: this);

  PageController pageController = PageController();

  List<String> tabname = <String>[
    "Movies",
    "News",
    "Sport",
    "TV Show",
    "Kids",
  ];

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

  List<String> actionmoviList = <String>[
    "ic_actionmovi1.png",
    "ic_recentmovi2.png",
    "ic_actionmovi1.png",
    "ic_homebanner.png",
  ];

  List<String> specialOrignalMovi = <String>[
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: primary,
          title: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: MyImage(width: 80, height: 80, imagePath: "ic_appicon.png"),
          ),
        ),
      ),
      body: Column(
        children: [
          tabTitle(),
          tabItem(),
        ],
      ),
    );
  }

  Widget tabTitle() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      alignment: Alignment.center,
      child: TabBar(
        indicatorColor: white,
        isScrollable: true,
        physics: const AlwaysScrollableScrollPhysics(),
        unselectedLabelColor: white,
        labelStyle: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal),
        labelColor: white,
        controller: tabController,
        tabs: List<Widget>.generate(tabname.length, (int index) {
          return Tab(
            child: MyText(
                color: white,
                text: tabname[index],
                fontsize: 12,
                maxline: 1,
                overflow: TextOverflow.ellipsis,
                fontwaight: FontWeight.w600,
                textalign: TextAlign.center,
                fontstyle: FontStyle.normal),
          );
        }),
      ),
    );
  }

  Widget tabItem() {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: TabBarView(
          controller: tabController,
          children: List<Widget>.generate(
            tabname.length,
            (int index) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    homebanner(),
                    landscap("Recently Addes Movies"),
                    portrait("Action Movies"),
                    square("Top Rated IMDB Movies"),
                    landscap("Original Special Series"),
                    portrait("Best of 2022"),
                    square("Top Rated IMDB Movies"),
                  ],
                ),
              );
            },
          ),
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
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: white,
                child: MyImage(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fill,
                    imagePath: pageviewImgList[index]),
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

  Widget landscap(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 55,
            margin: const EdgeInsets.fromLTRB(10, 0, 15, 0),
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: MyText(
                  color: white,
                  text: title,
                  textalign: TextAlign.center,
                  fontsize: 16,
                  maxline: 1,
                  fontwaight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  fontstyle: FontStyle.normal),
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

  Widget portrait(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 55,
            margin: const EdgeInsets.fromLTRB(10, 0, 15, 0),
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: MyText(
                  color: white,
                  text: "Action Movies",
                  textalign: TextAlign.center,
                  fontsize: 16,
                  maxline: 1,
                  fontwaight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  fontstyle: FontStyle.normal),
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

  Widget square(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 55,
            margin: const EdgeInsets.fromLTRB(10, 0, 15, 0),
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: MyText(
                  color: white,
                  text: title,
                  textalign: TextAlign.center,
                  fontsize: 16,
                  maxline: 1,
                  fontwaight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  fontstyle: FontStyle.normal),
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
