import 'package:dtlive/pages/setting.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/myimage.dart';
import 'package:dtlive/utils/mytext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyStuff extends StatefulWidget {
  const MyStuff({Key? key}) : super(key: key);

  @override
  State<MyStuff> createState() => MyStuffState();
}

class MyStuffState extends State<MyStuff> with TickerProviderStateMixin {
  late TabController tabController =
      TabController(length: tabname.length, vsync: this);

  List<String> tabname = <String>[
    "Download",
    "Watchlist",
    "Purchase",
  ];

  List<String> downloadList = <String>[
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
  ];

  List<String> downloadTitleList = <String>[
    "K.G.F Chapter 2",
    "R R R",
    "Dance Deewano",
    "Kapil Sharma Show",
    "K.G.F Chapter 2",
    "R R R",
    "Dance Deewano",
    "Kapil Sharma Show",
    "K.G.F Chapter 2",
    "R R R",
    "Dance Deewano",
    "Kapil Sharma Show",
  ];

  List<String> downloadGbList = <String>[
    "14 min 180 Mb",
    "22 min 120 Mb",
    "30 min 100 Mb",
    "12 min 180 Mb",
    "14 min 240 Mb",
    "25 min 32 Mb",
    "35 min 60 Mb",
    "5 min 200 Mb",
    "14 min 240 Mb",
    "25 min 32 Mb",
    "35 min 60 Mb",
    "5 min 200 Mb",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: primary,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyImage(
                                width: 50,
                                height: 50,
                                imagePath: "ic_user.png"),
                            const SizedBox(
                              width: 15,
                            ),
                            MyText(
                                color: white,
                                text: "IMS-128-VRAJRAVAL",
                                fontsize: 16,
                                fontwaight: FontWeight.w600,
                                maxline: 1,
                                overflow: TextOverflow.ellipsis,
                                textalign: TextAlign.center,
                                fontstyle: FontStyle.normal),
                            const SizedBox(
                              width: 15,
                            ),
                            MyImage(
                                width: 15,
                                height: 15,
                                imagePath: "ic_down.png"),
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const Setting();
                                    },
                                  ),
                                );
                              },
                              child: MyImage(
                                  width: 20,
                                  height: 20,
                                  imagePath: "ic_setting.png"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      alignment: Alignment.center,
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
                        labelPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        controller: tabController,
                        tabs:
                            List<Widget>.generate(tabname.length, (int index) {
                          return Tab(
                            child: MyText(
                                color: white,
                                text: tabname[index],
                                fontsize: 14,
                                maxline: 1,
                                overflow: TextOverflow.ellipsis,
                                fontwaight: FontWeight.w600,
                                textalign: TextAlign.center,
                                fontstyle: FontStyle.normal),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                          itemCount: downloadList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: downloadBg,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                color: downloadBg,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 140,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      color: white,
                                      child: MyImage(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          fit: BoxFit.fill,
                                          imagePath: downloadList[index]),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 0, 15),
                                                alignment: Alignment.centerLeft,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    MyText(
                                                        color: white,
                                                        text: downloadTitleList[
                                                            index],
                                                        textalign:
                                                            TextAlign.center,
                                                        fontsize: 12,
                                                        fontwaight:
                                                            FontWeight.w700,
                                                        fontstyle:
                                                            FontStyle.normal),
                                                    MyText(
                                                        color: white,
                                                        text: downloadGbList[
                                                            index],
                                                        textalign:
                                                            TextAlign.center,
                                                        fontsize: 10,
                                                        fontwaight:
                                                            FontWeight.w500,
                                                        fontstyle:
                                                            FontStyle.normal),
                                                    MyText(
                                                        color:
                                                            bottomnavigationText,
                                                        text: "DT prime",
                                                        textalign:
                                                            TextAlign.center,
                                                        fontsize: 12,
                                                        fontwaight:
                                                            FontWeight.w700,
                                                        fontstyle:
                                                            FontStyle.normal),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 30,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: MyImage(
                                                    width: 15,
                                                    height: 15,
                                                    imagePath: "ic_more.png"),
                                              ),
                                            ),
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
