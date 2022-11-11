import 'dart:developer';

import 'package:dtlive/provider/findprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/myedittext.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class Find extends StatefulWidget {
  const Find({Key? key}) : super(key: key);

  @override
  State<Find> createState() => FindState();
}

class FindState extends State<Find> {
  final searchController = TextEditingController();
  late FindProvider findProvider;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    findProvider = Provider.of<FindProvider>(context, listen: false);
    findProvider.getSectionType();
    findProvider.getGenres();
    findProvider.getLanguage();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void dispose() {
    findProvider.clearFindProvider();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: appBgColor,
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                /* Search Box */
                searchBox(),
                const SizedBox(
                  height: 22,
                ),
                /* Browse by */
                Consumer<FindProvider>(
                  builder: (context, findProvider, child) {
                    log("Browseby loading  ===>  ${findProvider.loading}");
                    if (findProvider.loading) {
                      return Utils.pageLoader();
                    } else {
                      if (findProvider.sectionTypeModel.status == 200) {
                        if (findProvider.sectionTypeModel.result != null &&
                            (findProvider.sectionTypeModel.result?.length ??
                                    0) >
                                0) {
                          log("sectionTypeModel Size  ===>  ${(findProvider.sectionTypeModel.result?.length ?? 0)}");
                          return Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                alignment: Alignment.centerLeft,
                                child: MyText(
                                  color: white,
                                  text: browseBy,
                                  textalign: TextAlign.center,
                                  fontsize: 16,
                                  maxline: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontwaight: FontWeight.bold,
                                  fontstyle: FontStyle.normal,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AlignedGridView.count(
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                itemCount: (findProvider
                                        .sectionTypeModel.result?.length ??
                                    0),
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder:
                                    (BuildContext context, int position) {
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(4),
                                    onTap: () {
                                      log("Item Clicked! => $position");
                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //     builder: (context) => DoctorDetails(homeProvider
                                      //             .doctorModel.result
                                      //             ?.elementAt(position)
                                      //             .id ??
                                      //         ""),
                                      //   ),
                                      // );
                                    },
                                    child: Container(
                                      height: 65,
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      decoration: BoxDecoration(
                                        color: primaryDarkColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      alignment: Alignment.center,
                                      child: MyText(
                                        color: white,
                                        text: findProvider
                                                .sectionTypeModel.result
                                                ?.elementAt(position)
                                                .name ??
                                            "",
                                        textalign: TextAlign.center,
                                        fontstyle: FontStyle.normal,
                                        fontsize: 14,
                                        fontwaight: FontWeight.w800,
                                        maxline: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      } else {
                        return const SizedBox.shrink();
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 22,
                ),
                /* Genres */
                Consumer<FindProvider>(
                  builder: (context, findProvider, child) {
                    log("setGenresSize  ===>  ${findProvider.setGenresSize}");
                    log("genresModel Size  ===>  ${(findProvider.genresModel.result?.length ?? 0)}");
                    if (findProvider.loading) {
                      return Utils.pageLoader();
                    } else {
                      if (findProvider.genresModel.status == 200) {
                        if (findProvider.genresModel.result != null &&
                            (findProvider.genresModel.result?.length ?? 0) >
                                0) {
                          return Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                alignment: Alignment.centerLeft,
                                child: MyText(
                                  color: white,
                                  text: genres,
                                  textalign: TextAlign.center,
                                  fontsize: 16,
                                  maxline: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontwaight: FontWeight.bold,
                                  fontstyle: FontStyle.normal,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              AlignedGridView.count(
                                shrinkWrap: true,
                                crossAxisCount: 1,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                itemCount: findProvider.setGenresSize <
                                        (findProvider
                                                .genresModel.result?.length ??
                                            0)
                                    ? findProvider.setGenresSize
                                    : (findProvider
                                            .genresModel.result?.length ??
                                        0),
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder:
                                    (BuildContext context, int position) {
                                  return Column(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 0.9,
                                        color: lightBlack,
                                      ),
                                      InkWell(
                                        borderRadius: BorderRadius.circular(4),
                                        onTap: () {
                                          log("Item Clicked! => $position");
                                        },
                                        child: SizedBox(
                                          height: 47,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              MyText(
                                                color: white,
                                                text: findProvider
                                                        .genresModel.result
                                                        ?.elementAt(position)
                                                        .name ??
                                                    "",
                                                textalign: TextAlign.center,
                                                fontsize: 14,
                                                maxline: 1,
                                                overflow: TextOverflow.ellipsis,
                                                fontwaight: FontWeight.normal,
                                                fontstyle: FontStyle.normal,
                                              ),
                                              MyImage(
                                                width: 15,
                                                height: 15,
                                                color: lightGray,
                                                imagePath: "ic_right.png",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Visibility(
                                visible: findProvider.isGenSeeMore,
                                child: InkWell(
                                  onTap: () {
                                    log("Clicked on Genres $seeMore");
                                    final findProvider =
                                        Provider.of<FindProvider>(context,
                                            listen: false);
                                    findProvider.setGenSeeMore(false);
                                    findProvider.setGenresListSize(findProvider
                                            .genresModel.result?.length ??
                                        0);
                                  },
                                  child: Container(
                                    height: 30,
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    alignment: Alignment.centerLeft,
                                    child: MyText(
                                      color: primaryColor,
                                      text: seeMore,
                                      textalign: TextAlign.center,
                                      fontsize: 14,
                                      maxline: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontwaight: FontWeight.normal,
                                      fontstyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      } else {
                        return const SizedBox.shrink();
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                /* Language */
                Consumer<FindProvider>(
                  builder: (context, findProvider, child) {
                    log("setLanguageSize  ===>  ${findProvider.setLanguageSize}");
                    log("langaugeModel Size  ===>  ${(findProvider.langaugeModel.result?.length ?? 0)}");
                    if (findProvider.loading) {
                      return Utils.pageLoader();
                    } else {
                      if (findProvider.langaugeModel.status == 200) {
                        if (findProvider.langaugeModel.result != null &&
                            (findProvider.langaugeModel.result?.length ?? 0) >
                                0) {
                          return Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                alignment: Alignment.centerLeft,
                                child: MyText(
                                  color: white,
                                  text: language,
                                  textalign: TextAlign.center,
                                  fontsize: 16,
                                  maxline: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontwaight: FontWeight.bold,
                                  fontstyle: FontStyle.normal,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              AlignedGridView.count(
                                shrinkWrap: true,
                                crossAxisCount: 1,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                itemCount: findProvider.setLanguageSize <
                                        (findProvider
                                                .langaugeModel.result?.length ??
                                            0)
                                    ? findProvider.setLanguageSize
                                    : (findProvider
                                            .langaugeModel.result?.length ??
                                        0),
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder:
                                    (BuildContext context, int position) {
                                  return Column(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 0.9,
                                        color: lightBlack,
                                      ),
                                      InkWell(
                                        borderRadius: BorderRadius.circular(4),
                                        onTap: () {
                                          log("Item Clicked! => $position");
                                        },
                                        child: SizedBox(
                                          height: 47,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              MyText(
                                                color: white,
                                                text: findProvider
                                                        .langaugeModel.result
                                                        ?.elementAt(position)
                                                        .name ??
                                                    "",
                                                textalign: TextAlign.center,
                                                fontsize: 14,
                                                maxline: 1,
                                                overflow: TextOverflow.ellipsis,
                                                fontwaight: FontWeight.normal,
                                                fontstyle: FontStyle.normal,
                                              ),
                                              MyImage(
                                                width: 15,
                                                height: 15,
                                                color: lightGray,
                                                imagePath: "ic_right.png",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Visibility(
                                visible: findProvider.isLangSeeMore,
                                child: InkWell(
                                  onTap: () {
                                    log("Clicked on Language $seeMore");
                                    final findProvider =
                                        Provider.of<FindProvider>(context,
                                            listen: false);
                                    findProvider.setLangSeeMore(false);
                                    findProvider.setLanguageListSize(
                                        findProvider
                                                .langaugeModel.result?.length ??
                                            0);
                                  },
                                  child: Container(
                                    height: 30,
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    alignment: Alignment.centerLeft,
                                    child: MyText(
                                      color: primaryColor,
                                      text: seeMore,
                                      textalign: TextAlign.center,
                                      fontsize: 14,
                                      maxline: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontwaight: FontWeight.normal,
                                      fontstyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      } else {
                        return const SizedBox.shrink();
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchBox() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: BoxDecoration(
        color: primaryDarkColor,
        border: Border.all(
          color: primaryLight,
          width: 0.5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
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
                hinttext: searchHint,
                size: 14,
                color: white,
                controller: searchController,
                textInputAction: TextInputAction.done,
                obscureText: false,
                keyboardType: TextInputType.text,
              ),
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
    );
  }
}
