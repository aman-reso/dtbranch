import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/myimage.dart';
import 'package:dtlive/utils/mytext.dart';
import 'package:flutter/material.dart';

class Homelandscap extends StatefulWidget {
  const Homelandscap({Key? key}) : super(key: key);

  @override
  State<Homelandscap> createState() => HomelandscapState();
}

class HomelandscapState extends State<Homelandscap> {
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
    "ic_actionmovi2.png",
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
  ];

   List<String> toprelatedList = <String>[
    "ic_toprelated1.png",
    "ic_toprelated2.png",
    "ic_toprelated1.png",
    "ic_toprelated2.png",
  ];

  List<String> orignalspecialList = <String>[
    "ic_orignalspecial1.png",
    "ic_orignalspecial2.png",
    "ic_orignalspecial1.png",
    "ic_orignalspecial2.png",
  ];

  List<String> best2022List = <String>[
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
  

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }

  Widget homebanner() {
    return SizedBox(
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
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: recentmoviList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 180,
                  height: 130,
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: MyImage(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.fill,
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

  Widget actionMovies() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            margin: const EdgeInsets.fromLTRB(10, 0, 15, 0),
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
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
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: actionmoviList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 180,
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: MyImage(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.fill,
                        imagePath: actionmoviList[index]),
                  ),
                );
              },
            ),
          ),
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
            height: 50,
            margin: const EdgeInsets.fromLTRB(10, 0, 15, 0),
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
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
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: toprelatedList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 180,
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: MyImage(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.fill,
                        imagePath: toprelatedList[index]),
                  ),
                );
              },
            ),
          ),
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
            height: 50,
            margin: const EdgeInsets.fromLTRB(10, 0, 15, 0),
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
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
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: best2022List.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 180,
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: MyImage(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.fill,
                        imagePath: best2022List[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

   Widget best2022() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            margin: const EdgeInsets.fromLTRB(10, 0, 15, 0),
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
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
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: orignalspecialList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 180,
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: MyImage(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.fill,
                        imagePath: orignalspecialList[index]),
                  ),
                );
              },
            ),
          ),
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
            height: 50,
            margin: const EdgeInsets.fromLTRB(10, 0, 15, 0),
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
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
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: specialOrignalMovi.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 180,
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: MyImage(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.fill,
                        imagePath: specialOrignalMovi[index]),
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
