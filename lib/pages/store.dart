import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  State<Store> createState() => StoreState();
}

class StoreState extends State<Store> with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);

  List<String> moviGridList = <String>[
    "ic_recentmovi1.png",
    "ic_recentmovi2.png",
    "ic_recentmovi1.png",
    "ic_recentmovi2.png",
    "ic_orignalspecial1.png",
    "ic_orignalspecial2.png",
    "ic_orignalspecial1.png",
    "ic_orignalspecial2.png",
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
    "ic_toprelated1.png",
    "ic_toprelated2.png",
    "ic_toprelated1.png",
    "ic_toprelated2.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 200,
              height: 50,
              margin: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: ButtonsTabBar(
                controller: tabController,
                radius: 50,
                contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                backgroundColor: primaryColor,
                unselectedBackgroundColor: white,
                unselectedLabelStyle: GoogleFonts.inter(
                    color: black,
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700),
                labelStyle: GoogleFonts.inter(
                    color: black,
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700),
                tabs: const [
                  Tab(
                    text: "Movies",
                  ),
                  Tab(
                    text: "TV shows",
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: TabBarView(
                controller: tabController,
                children: [
                  moviTab(),
                  tvShowTab(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget moviTab() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      alignment: Alignment.topCenter,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 7,
        mainAxisSpacing: 7,
        childAspectRatio: 7 / 4,
        shrinkWrap: true,
        children: List.generate(
          moviGridList.length,
          (index) {
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
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
                        imagePath: moviGridList[index]),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 50,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: MyText(
                          color: primaryColor,
                          text: "\$9.0",
                          fontsize: 12,
                          fontwaight: FontWeight.w400,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget tvShowTab() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      alignment: Alignment.topCenter,
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 7,
        mainAxisSpacing: 7,
        childAspectRatio: 5 / 7,
        shrinkWrap: true,
        children: List.generate(
          moviGridList.length,
          (index) {
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
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
                        imagePath: moviGridList[index]),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 50,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: MyText(
                          color: primaryColor,
                          text: "\$9.0",
                          fontsize: 12,
                          fontwaight: FontWeight.w400,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
