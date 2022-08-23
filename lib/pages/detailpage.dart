import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/myimage.dart';
import 'package:dtlive/utils/mytext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  late TabController tabController =
      TabController(length: tabname.length, vsync: this);

  List<String> tabname = <String>[
    "Related",
    "More details",
  ];

  List<String> specialOrignalMovi = <String>[
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
    "ic_actionmovi1.png",
  ];

  List<String> episodList = <String>[
    "Episode 1",
    "Episode 2",
  ];

  String maxText =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: primary,
          child: Column(
            children: [
              videolayout(),
              videoTitle(),
              playButton(),
              cricleButton(),
              testData(),
              desctiption(),
              detailTab(),
              tabView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget videolayout() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 230,
      color: white,
      child: MyImage(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.fill,
          imagePath: "ic_recentmovi1.png"),
    );
  }

  Widget videoTitle() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
              color: white,
              text: "K.G.F : Chapter 2",
              textalign: TextAlign.center,
              fontsize: 18,
              fontwaight: FontWeight.w700,
              maxline: 1,
              overflow: TextOverflow.ellipsis,
              fontstyle: FontStyle.normal),
          const SizedBox(
            height: 5,
          ),
          MyText(
              color: bottomnavigationText,
              text: "DT prime",
              textalign: TextAlign.center,
              fontsize: 14,
              fontwaight: FontWeight.w700,
              maxline: 1,
              overflow: TextOverflow.ellipsis,
              fontstyle: FontStyle.normal),
          const SizedBox(
            height: 10,
          ),
          MyText(
              color: white,
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              textalign: TextAlign.left,
              fontsize: 10,
              fontwaight: FontWeight.w400,
              maxline: 2,
              overflow: TextOverflow.ellipsis,
              fontstyle: FontStyle.normal),
        ],
      ),
    );
  }

  Widget playButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
      decoration: BoxDecoration(
        color: playButtonBg,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          MyImage(width: 20, height: 20, imagePath: "ic_play.png"),
          const SizedBox(
            width: 15,
          ),
          MyText(
              color: white,
              text: "Watch Now",
              textalign: TextAlign.center,
              fontsize: 14,
              fontwaight: FontWeight.w500,
              maxline: 1,
              overflow: TextOverflow.ellipsis,
              fontstyle: FontStyle.normal),
        ],
      ),
    );
  }

  Widget cricleButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 130,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: loginBtnOne,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: MyImage(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      imagePath: "ic_borderplay.png"),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              MyText(
                  color: white,
                  text: "Trailer",
                  fontsize: 12,
                  fontwaight: FontWeight.w500,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                  textalign: TextAlign.center,
                  fontstyle: FontStyle.normal),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: loginBtnOne,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: MyImage(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      imagePath: "ic_download.png"),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              MyText(
                  color: white,
                  text: "Download",
                  fontsize: 12,
                  fontwaight: FontWeight.w500,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                  textalign: TextAlign.center,
                  fontstyle: FontStyle.normal),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: loginBtnOne,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: MyImage(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      imagePath: "ic_plus.png"),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              MyText(
                  color: white,
                  text: "Watchlist",
                  fontsize: 12,
                  fontwaight: FontWeight.w500,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                  textalign: TextAlign.center,
                  fontstyle: FontStyle.normal),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: loginBtnOne,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: MyImage(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      imagePath: "ic_moreborder.png"),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              MyText(
                  color: white,
                  text: "More",
                  fontsize: 12,
                  fontwaight: FontWeight.w500,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                  textalign: TextAlign.center,
                  fontstyle: FontStyle.normal),
            ],
          ),
        ],
      ),
    );
  }

  Widget testData() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 20,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      alignment: Alignment.centerLeft,
      child: MyText(
          color: white,
          text: "Test Data",
          textalign: TextAlign.center,
          fontsize: 12,
          fontwaight: FontWeight.w500,
          maxline: 1,
          overflow: TextOverflow.ellipsis,
          fontstyle: FontStyle.normal),
    );
  }

  Widget desctiption() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
              color: white,
              text: "IMDB 0",
              textalign: TextAlign.center,
              fontwaight: FontWeight.w500,
              fontsize: 10,
              maxline: 1,
              overflow: TextOverflow.ellipsis,
              fontstyle: FontStyle.normal),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              MyText(
                  color: white,
                  text: "0",
                  textalign: TextAlign.center,
                  fontwaight: FontWeight.w500,
                  fontsize: 10,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                  fontstyle: FontStyle.normal),
              const SizedBox(
                width: 5,
              ),
              MyImage(width: 10, height: 10, imagePath: "ic_a.png"),
              const SizedBox(
                width: 5,
              ),
              MyImage(width: 10, height: 10, imagePath: "ic_message.png")
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          MyText(
              color: white,
              text: "Language: Audio(1),Subtitle(1)",
              textalign: TextAlign.center,
              fontwaight: FontWeight.w500,
              fontsize: 10,
              maxline: 1,
              overflow: TextOverflow.ellipsis,
              fontstyle: FontStyle.normal),
        ],
      ),
    );
  }

  Widget detailTab() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
            child: TabBar(
              indicatorColor: white,
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              physics: const AlwaysScrollableScrollPhysics(),
              unselectedLabelColor: white,
              labelStyle: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal),
              labelColor: white,
              labelPadding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              controller: tabController,
              tabs: List<Widget>.generate(tabname.length, (int index) {
                return Tab(
                  child: SizedBox(
                    child: MyText(
                        color: white,
                        text: tabname[index],
                        fontsize: 14,
                        maxline: 1,
                        overflow: TextOverflow.ellipsis,
                        fontwaight: FontWeight.w600,
                        textalign: TextAlign.center,
                        fontstyle: FontStyle.normal),
                  ),
                );
              }),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: white),
        ],
      ),
    );
  }

  Widget tabView() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 900,
      child: TabBarView(
        controller: tabController,
        children: [
          relatedTabTvShow(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  margin: const EdgeInsets.fromLTRB(25, 10, 20, 0),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 54,
                        alignment: Alignment.topLeft,
                        child: MyText(
                            color: white,
                            text: "Genres",
                            fontsize: 14,
                            fontwaight: FontWeight.w700,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: loginBtnOne),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  margin: const EdgeInsets.fromLTRB(25, 10, 20, 0),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 54,
                        alignment: Alignment.topLeft,
                        child: MyText(
                            color: white,
                            text: "Director",
                            fontsize: 14,
                            fontwaight: FontWeight.w700,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: loginBtnOne),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  margin: const EdgeInsets.fromLTRB(25, 10, 20, 0),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 54,
                        alignment: Alignment.topLeft,
                        child: MyText(
                            color: white,
                            text: "Starring",
                            fontsize: 14,
                            fontwaight: FontWeight.w700,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: loginBtnOne),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  margin: const EdgeInsets.fromLTRB(25, 10, 20, 0),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 54,
                        alignment: Alignment.topLeft,
                        child: MyText(
                            color: white,
                            text: "Supporting Actores",
                            fontsize: 14,
                            fontwaight: FontWeight.w700,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: loginBtnOne),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  margin: const EdgeInsets.fromLTRB(25, 10, 20, 0),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 54,
                        alignment: Alignment.topLeft,
                        child: MyText(
                            color: white,
                            text: "Networks",
                            fontsize: 14,
                            fontwaight: FontWeight.w700,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: loginBtnOne),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  margin: const EdgeInsets.fromLTRB(25, 10, 20, 0),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 54,
                        alignment: Alignment.topLeft,
                        child: MyText(
                            color: white,
                            text: "Maturity Rating",
                            fontsize: 14,
                            fontwaight: FontWeight.w700,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: loginBtnOne),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                          color: white,
                          text: "Customer reviews",
                          fontsize: 16,
                          fontwaight: FontWeight.w700,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                      const SizedBox(
                        height: 10,
                      ),
                      MyText(
                          color: white,
                          text: "We dont have any customer reviews",
                          fontsize: 10,
                          fontwaight: FontWeight.w400,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                          color: white,
                          text: "Did you know?",
                          fontsize: 16,
                          fontwaight: FontWeight.w700,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                      const SizedBox(
                        height: 10,
                      ),
                      MyText(
                          color: white,
                          text: maxText,
                          fontsize: 12,
                          fontwaight: FontWeight.w400,
                          maxline: 10,
                          overflow: TextOverflow.ellipsis,
                          textalign: TextAlign.left,
                          fontstyle: FontStyle.normal),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget relatedTabMovi() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 260,
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 15),
            alignment: Alignment.center,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: specialOrignalMovi.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                          color: white,
                          text: "Cast & Crew",
                          fontsize: 14,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w700,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                      const SizedBox(
                        height: 10,
                      ),
                      MyText(
                          color: white,
                          text: "Details from IMDB",
                          fontsize: 10,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w400,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        color: primary,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(7),
                              topLeft: Radius.circular(7)),
                          // side: BorderSide(width: 1, color: Colors.green),
                        ),
                        child: Container(
                          width: 100,
                          height: 150,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(7.0),
                              topLeft: Radius.circular(7.0),
                            ),
                            color: white,
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(7.0),
                              topLeft: Radius.circular(7.0),
                            ),
                            child: MyImage(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                fit: BoxFit.cover,
                                imagePath: specialOrignalMovi[index]),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            color: loginBtnOne,
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              alignment: Alignment.center,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: specialOrignalMovi.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        alignment: Alignment.topCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 110,
                              height: MediaQuery.of(context).size.height,
                              color: loginBtnOne,
                              child: MyImage(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  fit: BoxFit.cover,
                                  imagePath: specialOrignalMovi[index]),
                            ),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                        color: white,
                                        text: "Directors",
                                        textalign: TextAlign.left,
                                        fontsize: 12,
                                        maxline: 1,
                                        overflow: TextOverflow.ellipsis,
                                        fontwaight: FontWeight.w500,
                                        fontstyle: FontStyle.normal),
                                    MyText(
                                        color: white,
                                        text: maxText,
                                        textalign: TextAlign.left,
                                        fontsize: 10,
                                        maxline: 7,
                                        overflow: TextOverflow.ellipsis,
                                        fontwaight: FontWeight.w400,
                                        fontstyle: FontStyle.normal)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget relatedTabTvShow() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 140,
            // margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                itemCount: episodList.length,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      color: downloadBg,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 25,
                          ),
                          MyImage(
                              width: 25, height: 25, imagePath: "ic_play.png"),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                  color: white,
                                  text: episodList[index],
                                  fontsize: 12,
                                  maxline: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontwaight: FontWeight.w600,
                                  textalign: TextAlign.center,
                                  fontstyle: FontStyle.normal),
                              MyText(
                                  color: white,
                                  text: episodList[index],
                                  fontsize: 10,
                                  maxline: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontwaight: FontWeight.w500,
                                  textalign: TextAlign.center,
                                  fontstyle: FontStyle.normal),
                            ],
                          ),
                          const Spacer(),
                          MyImage(
                              width: 20,
                              height: 20,
                              imagePath: "ic_download.png"),
                          const SizedBox(
                            width: 20,
                          ),
                          MyImage(
                              width: 20, height: 20, imagePath: "ic_more.png"),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 260,
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 15),
            alignment: Alignment.center,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: specialOrignalMovi.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                          color: white,
                          text: "Cast & Crew",
                          fontsize: 14,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w700,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                      const SizedBox(
                        height: 10,
                      ),
                      MyText(
                          color: white,
                          text: "Details from IMDB",
                          fontsize: 10,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w400,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        color: primary,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(7),
                              topLeft: Radius.circular(7)),
                          // side: BorderSide(width: 1, color: Colors.green),
                        ),
                        child: Container(
                          width: 100,
                          height: 150,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(7.0),
                              topLeft: Radius.circular(7.0),
                            ),
                            color: white,
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(7.0),
                              topLeft: Radius.circular(7.0),
                            ),
                            child: MyImage(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                fit: BoxFit.cover,
                                imagePath: specialOrignalMovi[index]),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            color: loginBtnOne,
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              alignment: Alignment.center,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  itemCount: specialOrignalMovi.length,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        alignment: Alignment.topCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 110,
                              height: MediaQuery.of(context).size.height,
                              color: loginBtnOne,
                              child: MyImage(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  fit: BoxFit.cover,
                                  imagePath: specialOrignalMovi[index]),
                            ),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                        color: white,
                                        text: "Directors",
                                        textalign: TextAlign.left,
                                        fontsize: 12,
                                        maxline: 1,
                                        overflow: TextOverflow.ellipsis,
                                        fontwaight: FontWeight.w500,
                                        fontstyle: FontStyle.normal),
                                    MyText(
                                        color: white,
                                        text: maxText,
                                        textalign: TextAlign.left,
                                        fontsize: 10,
                                        maxline: 7,
                                        overflow: TextOverflow.ellipsis,
                                        fontwaight: FontWeight.w400,
                                        fontstyle: FontStyle.normal)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
