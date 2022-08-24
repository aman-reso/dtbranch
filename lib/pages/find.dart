import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/myedittext.dart';
import 'package:dtlive/utils/myimage.dart';
import 'package:dtlive/utils/mytext.dart';
import 'package:flutter/material.dart';

class Find extends StatefulWidget {
  const Find({Key? key}) : super(key: key);

  @override
  State<Find> createState() => FindState();
}

class FindState extends State<Find> {
  final searchController = TextEditingController();

  List<String> browsebyList = <String>[
    "Movies",
    "Devine Origin",
    "Tv",
    "Kids",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: primary,
          child: Column(
            children: [
              searchBox(),
              browseBy(),
              genres(),
              drama(),
              actionAdventure(),
              romance(),
              comedy(),
              suspense(),
              seemoreGenres(),
              language(),
              hindi(),
              english(),
              tamil(),
              panjabi(),
              gujarati(),
              seemore(),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBox() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 130,
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        decoration: BoxDecoration(
            border: Border.all(
              color: bottomnavigationText,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: MyImage(
                width: 20,
                height: 20,
                imagePath: "ic_find.png",
                color: white,
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: MyEdittext(
                    hinttext: "Search by actor,title...",
                    size: 14,
                    color: white,
                    controller: searchController,
                    textInputAction: TextInputAction.done,
                    obscureText: false,
                    keyboardType: TextInputType.text),
              ),
            ),
            Container(
              width: 50,
              height: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: MyImage(
                width: 20,
                height: 20,
                imagePath: "ic_voice.png",
                color: white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget browseBy() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Padding(
              padding: const EdgeInsets.only(top: 7),
              child: MyText(
                  color: white,
                  text: "Browse by",
                  textalign: TextAlign.center,
                  fontsize: 16,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                  fontwaight: FontWeight.w500,
                  fontstyle: FontStyle.normal),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: browseby,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: MyText(
                            color: white,
                            text: "Movies",
                            fontsize: 12,
                            fontwaight: FontWeight.w500,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal),
                      ),
                      Container(
                        width: 150,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: browseby,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: MyText(
                            color: white,
                            text: "Divine Original",
                            fontsize: 12,
                            fontwaight: FontWeight.w500,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: browseby,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: MyText(
                            color: white,
                            text: "Tv",
                            fontsize: 12,
                            fontwaight: FontWeight.w500,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal),
                      ),
                      Container(
                        width: 150,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: browseby,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: MyText(
                            color: white,
                            text: "Kids",
                            fontsize: 12,
                            fontwaight: FontWeight.w500,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget genres() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: white,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: primary,
              alignment: Alignment.centerLeft,
              child: MyText(
                  color: white,
                  text: "Genres",
                  textalign: TextAlign.center,
                  fontsize: 14,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                  fontwaight: FontWeight.w600,
                  fontstyle: FontStyle.normal),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: dividerline,
          )
        ],
      ),
    );
  }

  Widget drama() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: white,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: primary,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                      color: white,
                      text: "Drama",
                      textalign: TextAlign.center,
                      fontsize: 12,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w400,
                      fontstyle: FontStyle.normal),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: MyImage(
                        width: 15, height: 15, imagePath: "ic_right.png"),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: dividerline,
          )
        ],
      ),
    );
  }

  Widget actionAdventure() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: white,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: primary,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                      color: white,
                      text: "Action and Adventure",
                      textalign: TextAlign.center,
                      fontsize: 12,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w400,
                      fontstyle: FontStyle.normal),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: MyImage(
                        width: 15, height: 15, imagePath: "ic_right.png"),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: dividerline,
          )
        ],
      ),
    );
  }

  Widget romance() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: white,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: primary,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                      color: white,
                      text: "Romance",
                      textalign: TextAlign.center,
                      fontsize: 12,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w400,
                      fontstyle: FontStyle.normal),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: MyImage(
                        width: 15, height: 15, imagePath: "ic_right.png"),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: dividerline,
          )
        ],
      ),
    );
  }

  Widget comedy() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: white,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: primary,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                      color: white,
                      text: "Comedy",
                      textalign: TextAlign.center,
                      fontsize: 12,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w400,
                      fontstyle: FontStyle.normal),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: MyImage(
                        width: 15, height: 15, imagePath: "ic_right.png"),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: dividerline,
          )
        ],
      ),
    );
  }

  Widget suspense() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: white,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: primary,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                      color: white,
                      text: "Suspense",
                      textalign: TextAlign.center,
                      fontsize: 12,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w400,
                      fontstyle: FontStyle.normal),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: MyImage(
                        width: 15, height: 15, imagePath: "ic_right.png"),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: dividerline,
          )
        ],
      ),
    );
  }

  Widget seemoreGenres() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: white,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: primary,
        alignment: Alignment.centerLeft,
        child: MyText(
            color: bottomnavigationText,
            text: "See more",
            textalign: TextAlign.center,
            fontsize: 12,
            maxline: 1,
            overflow: TextOverflow.ellipsis,
            fontwaight: FontWeight.w500,
            fontstyle: FontStyle.normal),
      ),
    );
  }

  Widget language() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: white,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: primary,
              alignment: Alignment.centerLeft,
              child: MyText(
                  color: white,
                  text: "Language",
                  textalign: TextAlign.center,
                  fontsize: 14,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                  fontwaight: FontWeight.w600,
                  fontstyle: FontStyle.normal),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: dividerline,
          )
        ],
      ),
    );
  }

  Widget hindi() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: white,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: primary,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                      color: white,
                      text: "Hindi",
                      textalign: TextAlign.center,
                      fontsize: 12,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w400,
                      fontstyle: FontStyle.normal),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: MyImage(
                        width: 15, height: 15, imagePath: "ic_right.png"),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: dividerline,
          )
        ],
      ),
    );
  }

  Widget english() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: white,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: primary,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                      color: white,
                      text: "English",
                      textalign: TextAlign.center,
                      fontsize: 12,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w400,
                      fontstyle: FontStyle.normal),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: MyImage(
                        width: 15, height: 15, imagePath: "ic_right.png"),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: dividerline,
          )
        ],
      ),
    );
  }

  Widget tamil() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: white,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: primary,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                      color: white,
                      text: "Tamil",
                      textalign: TextAlign.center,
                      fontsize: 12,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w400,
                      fontstyle: FontStyle.normal),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: MyImage(
                        width: 15, height: 15, imagePath: "ic_right.png"),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: dividerline,
          )
        ],
      ),
    );
  }

  Widget panjabi() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: white,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: primary,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                      color: white,
                      text: "Panjabi",
                      textalign: TextAlign.center,
                      fontsize: 12,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w400,
                      fontstyle: FontStyle.normal),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: MyImage(
                        width: 15, height: 15, imagePath: "ic_right.png"),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: dividerline,
          )
        ],
      ),
    );
  }

  Widget gujarati() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: white,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: primary,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
                color: white,
                text: "Gujarati",
                textalign: TextAlign.center,
                fontsize: 12,
                maxline: 1,
                overflow: TextOverflow.ellipsis,
                fontwaight: FontWeight.w400,
                fontstyle: FontStyle.normal),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: MyImage(width: 15, height: 15, imagePath: "ic_right.png"),
            ),
          ],
        ),
      ),
    );
  }

  Widget seemore() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 30,
      color: white,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: primary,
        alignment: Alignment.centerLeft,
        child: MyText(
            color: bottomnavigationText,
            text: "See more",
            textalign: TextAlign.center,
            fontsize: 12,
            maxline: 1,
            overflow: TextOverflow.ellipsis,
            fontwaight: FontWeight.w500,
            fontstyle: FontStyle.normal),
      ),
    );
  }
}
