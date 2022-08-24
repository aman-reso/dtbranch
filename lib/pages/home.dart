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
          Container(
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
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                controller: tabController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        homebanner(),
                        recentlyAdded(),
                        actionMovies(),
                        topRatedIMDBMovies(),
                        originalSpecialSeries(),
                        best2022(),
                        orignalSpecialMovi(),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        homebanner(),
                        recentlyAdded(),
                        actionMovies(),
                        topRatedIMDBMovies(),
                        originalSpecialSeries(),
                        best2022(),
                        orignalSpecialMovi(),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        homebanner(),
                        recentlyAdded(),
                        actionMovies(),
                        topRatedIMDBMovies(),
                        originalSpecialSeries(),
                        best2022(),
                        orignalSpecialMovi(),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        homebanner(),
                        recentlyAdded(),
                        actionMovies(),
                        topRatedIMDBMovies(),
                        originalSpecialSeries(),
                        best2022(),
                        orignalSpecialMovi(),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        homebanner(),
                        recentlyAdded(),
                        actionMovies(),
                        topRatedIMDBMovies(),
                        originalSpecialSeries(),
                        best2022(),
                        orignalSpecialMovi(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
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

  Widget recentlyAdded() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            margin: const EdgeInsets.fromLTRB(10, 0, 15, 0),
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: MyText(
                  color: white,
                  text: "Recently Addes Movies",
                  textalign: TextAlign.center,
                  fontsize: 16,
                  maxline: 1,
                  fontwaight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  fontstyle: FontStyle.normal),
            ),
          ),
          landscap(),
        ],
      ),
    );
  }

  Widget actionMovies() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 190,
      margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
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
          portrait(),
        ],
      ),
    );
  }

  Widget topRatedIMDBMovies() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            margin: const EdgeInsets.fromLTRB(10, 0, 15, 0),
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: MyText(
                  color: white,
                  text: "Top Rated IMDB Movies",
                  textalign: TextAlign.center,
                  fontsize: 16,
                  maxline: 1,
                  fontwaight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  fontstyle: FontStyle.normal),
            ),
          ),
          squre(),
        ],
      ),
    );
  }

  Widget originalSpecialSeries() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            margin: const EdgeInsets.fromLTRB(10, 0, 15, 0),
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: MyText(
                  color: white,
                  text: "Original Special Series",
                  textalign: TextAlign.center,
                  fontsize: 16,
                  maxline: 1,
                  fontwaight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  fontstyle: FontStyle.normal),
            ),
          ),
          landscap(),
        ],
      ),
    );
  }

  Widget best2022() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 190,
      margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            margin: const EdgeInsets.fromLTRB(10, 0, 15, 0),
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: MyText(
                  color: white,
                  text: "Besi of 2022",
                  textalign: TextAlign.center,
                  fontsize: 16,
                  maxline: 1,
                  fontwaight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  fontstyle: FontStyle.normal),
            ),
          ),
          portrait(),
        ],
      ),
    );
  }

  Widget orignalSpecialMovi() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            margin: const EdgeInsets.fromLTRB(10, 0, 15, 0),
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: MyText(
                  color: white,
                  text: "Original Special Movies",
                  textalign: TextAlign.center,
                  fontsize: 16,
                  maxline: 1,
                  fontwaight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  fontstyle: FontStyle.normal),
            ),
          ),
          squre(),
        ],
      ),
    );
  }

  Widget landscap() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: recentmoviList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 170,
            height: 100,
            padding: const EdgeInsets.fromLTRB(10, 7, 0, 7),
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
    );
  }

  Widget portrait() {
    return Expanded(
      child: ListView.builder(
        itemCount: specialOrignalMovi.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Container(
              width: 100,
              height: 180,
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
    );
  }

  Widget squre() {
    return Expanded(
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
    );
  }
}
