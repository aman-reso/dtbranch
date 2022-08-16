import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/myimage.dart';
import 'package:dtlive/utils/mytext.dart';
import 'package:dtlive/widget/homelandscap.dart';
import 'package:dtlive/widget/homeportrait.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController tabController =
      TabController(length: tabname.length, vsync: this);

  List<String> tabname = <String>[
    "Movies",
    "News",
    "Sport",
    "TV Show",
    "Kids",
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
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                controller: tabController,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: const [
                        HomePortrait(),
                      ],
                    ),
                  ),
                  const Center(child: Text("News")),
                  const Center(child: Text("Sport")),
                  const Center(child: Text("Tv Show")),
                  const Center(child: Text("Kids")),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
