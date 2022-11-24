import 'dart:developer';

import 'package:dtlive/pages/moviedetails.dart';
import 'package:dtlive/pages/nodata.dart';
import 'package:dtlive/pages/setting.dart';
import 'package:dtlive/pages/tvshowdetails.dart';
import 'package:dtlive/provider/mystuffprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class MyStuff extends StatefulWidget {
  const MyStuff({Key? key}) : super(key: key);

  @override
  State<MyStuff> createState() => MyStuffState();
}

class MyStuffState extends State<MyStuff> with TickerProviderStateMixin {
  late TabController tabController =
      TabController(length: tabname.length, vsync: this);

  List<String> tabname = <String>[
    downloads,
    watchlist,
    purchases,
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

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    final myStuffProvider =
        Provider.of<MyStuffProvider>(context, listen: false);
    await myStuffProvider.getProfile();
    await myStuffProvider.getWatchlist();
    await myStuffProvider.getUserRentVideoList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: appBgColor,
                    title: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Consumer<MyStuffProvider>(
                              builder: (context, myStuffProvider, child) {
                                return Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(45),
                                      clipBehavior: Clip.antiAlias,
                                      child: MyNetworkImage(
                                        imageUrl: myStuffProvider
                                                    .profileModel.status ==
                                                200
                                            ? myStuffProvider
                                                        .profileModel.result !=
                                                    null
                                                ? (myStuffProvider.profileModel
                                                        .result?.image ??
                                                    Constant.userPlaceholder)
                                                : Constant.userPlaceholder
                                            : Constant.userPlaceholder,
                                        fit: BoxFit.cover,
                                        imgHeight: 50,
                                        imgWidth: 50,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    MyText(
                                      color: white,
                                      multilanguage: false,
                                      text:
                                          myStuffProvider.profileModel.status ==
                                                  200
                                              ? myStuffProvider.profileModel
                                                          .result !=
                                                      null
                                                  ? (myStuffProvider
                                                          .profileModel
                                                          .result
                                                          ?.name ??
                                                      "")
                                                  : ""
                                              : "",
                                      fontsize: 16,
                                      fontwaight: FontWeight.w600,
                                      maxline: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    MyImage(
                                      width: 15,
                                      height: 15,
                                      imagePath: "ic_down.png",
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
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
                              imagePath: "ic_setting.png",
                            ),
                          ),
                        ],
                      ),
                    ), // This is the title in the app bar.
                    pinned: false,
                    expandedHeight: 120,
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      indicatorColor: white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      isScrollable: false,
                      physics: const AlwaysScrollableScrollPhysics(),
                      unselectedLabelColor: white,
                      labelStyle: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                      labelColor: white,
                      labelPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      controller: tabController,
                      tabs: List<Widget>.generate(
                        tabname.length,
                        (int index) {
                          return Tab(
                            child: MyText(
                              color: white,
                              text: tabname[index],
                              fontsize: 14,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontwaight: FontWeight.w600,
                              textalign: TextAlign.center,
                              fontstyle: FontStyle.normal,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 0.5,
                  color: otherColor,
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      /* Downloads */
                      Consumer<MyStuffProvider>(
                        builder: (context, myStuffProvider, child) {
                          if (myStuffProvider.loading) {
                            return Utils.pageLoader();
                          } else {
                            if (myStuffProvider.profileModel.status == 200) {
                              return AlignedGridView.count(
                                shrinkWrap: true,
                                crossAxisCount: 1,
                                padding:
                                    const EdgeInsets.only(top: 12, bottom: 8),
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 8,
                                itemCount: downloadList.length,
                                itemBuilder:
                                    (BuildContext context, int position) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 95,
                                    constraints: const BoxConstraints(
                                      minHeight: 90,
                                      maxHeight: 110,
                                    ),
                                    color: lightBlack,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.44,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: MyImage(
                                            fit: BoxFit.fill,
                                            imagePath: downloadList[position],
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 95,
                                          ),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      MyText(
                                                        color: white,
                                                        text: downloadTitleList[
                                                            position],
                                                        textalign:
                                                            TextAlign.center,
                                                        maxline: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontsize: 14,
                                                        fontwaight:
                                                            FontWeight.w700,
                                                        fontstyle:
                                                            FontStyle.normal,
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Visibility(
                                                            visible: (position ==
                                                                        1 ||
                                                                    position ==
                                                                        2)
                                                                ? true
                                                                : false,
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 8),
                                                              child: MyText(
                                                                color:
                                                                    otherColor,
                                                                text:
                                                                    "Season 1",
                                                                maxline: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textalign:
                                                                    TextAlign
                                                                        .center,
                                                                fontsize: 12,
                                                                fontwaight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontstyle:
                                                                    FontStyle
                                                                        .normal,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 8),
                                                            child: MyText(
                                                              color: otherColor,
                                                              text: "140 min",
                                                              maxline: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textalign:
                                                                  TextAlign
                                                                      .center,
                                                              fontsize: 12,
                                                              fontwaight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontstyle:
                                                                  FontStyle
                                                                      .normal,
                                                            ),
                                                          ),
                                                          MyText(
                                                            color: otherColor,
                                                            text: "140 MB",
                                                            textalign: TextAlign
                                                                .center,
                                                            maxline: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontsize: 12,
                                                            fontwaight:
                                                                FontWeight
                                                                    .normal,
                                                            fontstyle: FontStyle
                                                                .normal,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Container(
                                                    width: 25,
                                                    height: 25,
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10,
                                                              right: 15),
                                                      child: MyImage(
                                                        width: 18,
                                                        height: 18,
                                                        imagePath: (position ==
                                                                    1 ||
                                                                position == 2)
                                                            ? "ic_right.png"
                                                            : "ic_more.png",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const NoData();
                            }
                          }
                        },
                      ),

                      /* WatchList */
                      Consumer<MyStuffProvider>(
                        builder: (context, myStuffProvider, child) {
                          if (myStuffProvider.loading) {
                            return Utils.pageLoader();
                          } else {
                            if (myStuffProvider.watchlistModel.status == 200 &&
                                myStuffProvider.watchlistModel.result != null) {
                              if ((myStuffProvider
                                          .watchlistModel.result?.length ??
                                      0) >
                                  0) {
                                return AlignedGridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 1,
                                  padding:
                                      const EdgeInsets.only(top: 12, bottom: 8),
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 8,
                                  itemCount: myStuffProvider
                                          .watchlistModel.result?.length ??
                                      0,
                                  itemBuilder:
                                      (BuildContext context, int position) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 95,
                                      constraints: const BoxConstraints(
                                        minHeight: 90,
                                        maxHeight: 110,
                                      ),
                                      color: lightBlack,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.44,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            child: Stack(
                                              alignment: AlignmentDirectional
                                                  .bottomStart,
                                              children: [
                                                InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(0),
                                                  onTap: () {
                                                    log("Clicked on position ==> $position");
                                                    if ((myStuffProvider
                                                                .watchlistModel
                                                                .result
                                                                ?.elementAt(
                                                                    position)
                                                                .videoType ??
                                                            0) ==
                                                        1) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return MovieDetails(
                                                              myStuffProvider
                                                                      .watchlistModel
                                                                      .result
                                                                      ?.elementAt(
                                                                          position)
                                                                      .id ??
                                                                  0,
                                                              myStuffProvider
                                                                      .watchlistModel
                                                                      .result
                                                                      ?.elementAt(
                                                                          position)
                                                                      .videoType ??
                                                                  0,
                                                              myStuffProvider
                                                                      .watchlistModel
                                                                      .result
                                                                      ?.elementAt(
                                                                          position)
                                                                      .typeId ??
                                                                  0,
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    } else if ((myStuffProvider
                                                                .watchlistModel
                                                                .result
                                                                ?.elementAt(
                                                                    position)
                                                                .videoType ??
                                                            0) ==
                                                        2) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return TvShowDetails(
                                                              myStuffProvider
                                                                      .watchlistModel
                                                                      .result
                                                                      ?.elementAt(
                                                                          position)
                                                                      .id ??
                                                                  0,
                                                              myStuffProvider
                                                                      .watchlistModel
                                                                      .result
                                                                      ?.elementAt(
                                                                          position)
                                                                      .videoType ??
                                                                  0,
                                                              myStuffProvider
                                                                      .watchlistModel
                                                                      .result
                                                                      ?.elementAt(
                                                                          position)
                                                                      .typeId ??
                                                                  0,
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: MyNetworkImage(
                                                    imageUrl: (myStuffProvider
                                                                    .watchlistModel
                                                                    .result
                                                                    ?.elementAt(
                                                                        position)
                                                                    .landscape ??
                                                                "")
                                                            .isNotEmpty
                                                        ? myStuffProvider
                                                                .watchlistModel
                                                                .result
                                                                ?.elementAt(
                                                                    position)
                                                                .landscape ??
                                                            Constant
                                                                .placeHolderLand
                                                        : myStuffProvider
                                                                .watchlistModel
                                                                .result
                                                                ?.elementAt(
                                                                    position)
                                                                .thumbnail ??
                                                            Constant
                                                                .placeHolderLand,
                                                    fit: BoxFit.fill,
                                                    imgWidth:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    imgHeight: 95,
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8,
                                                              bottom: 5),
                                                      child: MyImage(
                                                        width: 30,
                                                        height: 30,
                                                        imagePath: "play.png",
                                                      ),
                                                    ),
                                                    Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              minWidth: 0),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3),
                                                      child:
                                                          LinearPercentIndicator(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        barRadius: const Radius
                                                            .circular(2),
                                                        lineHeight: 4,
                                                        percent: Utils.getPercentage(
                                                            myStuffProvider
                                                                    .watchlistModel
                                                                    .result
                                                                    ?.elementAt(
                                                                        position)
                                                                    .videoDuration ??
                                                                0,
                                                            myStuffProvider
                                                                    .watchlistModel
                                                                    .result
                                                                    ?.elementAt(
                                                                        position)
                                                                    .stopTime ??
                                                                0),
                                                        backgroundColor:
                                                            secProgressColor,
                                                        progressColor:
                                                            primaryColor,
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: (myStuffProvider
                                                                      .watchlistModel
                                                                      .result
                                                                      ?.elementAt(
                                                                          position)
                                                                      .releaseTag !=
                                                                  null &&
                                                              (myStuffProvider
                                                                          .watchlistModel
                                                                          .result
                                                                          ?.elementAt(
                                                                              position)
                                                                          .releaseTag ??
                                                                      "")
                                                                  .isNotEmpty)
                                                          ? true
                                                          : false,
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: black,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    4),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    4),
                                                          ),
                                                          shape: BoxShape
                                                              .rectangle,
                                                        ),
                                                        width: 172,
                                                        height: 12,
                                                        child: MyText(
                                                          color: white,
                                                          text: myStuffProvider
                                                                  .watchlistModel
                                                                  .result
                                                                  ?.elementAt(
                                                                      position)
                                                                  .releaseTag ??
                                                              "",
                                                          textalign:
                                                              TextAlign.center,
                                                          fontsize: 6,
                                                          maxline: 1,
                                                          fontwaight:
                                                              FontWeight.normal,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontstyle:
                                                              FontStyle.normal,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        /* Title */
                                                        MyText(
                                                          color: white,
                                                          text: myStuffProvider
                                                                  .watchlistModel
                                                                  .result
                                                                  ?.elementAt(
                                                                      position)
                                                                  .name ??
                                                              "",
                                                          textalign:
                                                              TextAlign.center,
                                                          maxline: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontsize: 14,
                                                          fontwaight:
                                                              FontWeight.w700,
                                                          fontstyle:
                                                              FontStyle.normal,
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        /* Release Year & Video Duration */
                                                        Row(
                                                          children: [
                                                            (myStuffProvider.watchlistModel
                                                                            .result
                                                                            ?.elementAt(
                                                                                position)
                                                                            .releaseYear ??
                                                                        "")
                                                                    .isNotEmpty
                                                                ? Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            8),
                                                                    child:
                                                                        MyText(
                                                                      color:
                                                                          otherColor,
                                                                      text: myStuffProvider
                                                                              .watchlistModel
                                                                              .result
                                                                              ?.elementAt(position)
                                                                              .releaseYear ??
                                                                          "",
                                                                      maxline:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      textalign:
                                                                          TextAlign
                                                                              .center,
                                                                      fontsize:
                                                                          12,
                                                                      fontwaight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontstyle:
                                                                          FontStyle
                                                                              .normal,
                                                                    ),
                                                                  )
                                                                : const SizedBox
                                                                    .shrink(),
                                                            (myStuffProvider.watchlistModel
                                                                            .result
                                                                            ?.elementAt(
                                                                                position)
                                                                            .videoType ??
                                                                        0) !=
                                                                    2
                                                                ? (myStuffProvider.watchlistModel.result?.elementAt(position).videoDuration !=
                                                                            null &&
                                                                        (myStuffProvider.watchlistModel.result?.elementAt(position).videoDuration ??
                                                                                0) >
                                                                            0)
                                                                    ? MyText(
                                                                        color:
                                                                            otherColor,
                                                                        text: Utils.convertInMin(
                                                                            myStuffProvider.watchlistModel.result?.elementAt(position).videoDuration ??
                                                                                0),
                                                                        textalign:
                                                                            TextAlign.center,
                                                                        maxline:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        fontsize:
                                                                            12,
                                                                        fontwaight:
                                                                            FontWeight.normal,
                                                                        fontstyle:
                                                                            FontStyle.normal,
                                                                      )
                                                                    : const SizedBox
                                                                        .shrink()
                                                                : const SizedBox
                                                                    .shrink(),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        /* Prime TAG  & Rent TAG */
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            /* Prime TAG */
                                                            (myStuffProvider.watchlistModel
                                                                            .result
                                                                            ?.elementAt(
                                                                                position)
                                                                            .isPremium ??
                                                                        0) ==
                                                                    1
                                                                ? MyText(
                                                                    color:
                                                                        primaryColor,
                                                                    text:
                                                                        primeTAG,
                                                                    textalign:
                                                                        TextAlign
                                                                            .start,
                                                                    fontsize:
                                                                        12,
                                                                    fontwaight:
                                                                        FontWeight
                                                                            .w800,
                                                                    maxline: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    fontstyle:
                                                                        FontStyle
                                                                            .normal,
                                                                  )
                                                                : const SizedBox
                                                                    .shrink(),
                                                            const SizedBox(
                                                              height: 3,
                                                            ),
                                                            /* Rent TAG */
                                                            (myStuffProvider.watchlistModel
                                                                            .result
                                                                            ?.elementAt(
                                                                                position)
                                                                            .isRent ??
                                                                        0) ==
                                                                    1
                                                                ? MyText(
                                                                    color:
                                                                        white,
                                                                    text:
                                                                        rentTAG,
                                                                    textalign:
                                                                        TextAlign
                                                                            .start,
                                                                    fontsize:
                                                                        12,
                                                                    fontwaight:
                                                                        FontWeight
                                                                            .normal,
                                                                    maxline: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    fontstyle:
                                                                        FontStyle
                                                                            .normal,
                                                                  )
                                                                : const SizedBox
                                                                    .shrink(),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Container(
                                                      width: 25,
                                                      height: 25,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 10,
                                                                right: 15),
                                                        child: MyImage(
                                                          width: 18,
                                                          height: 18,
                                                          imagePath:
                                                              "ic_more.png",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const NoData();
                              }
                            } else {
                              return const NoData();
                            }
                          }
                        },
                      ),

                      /* Purchases */
                      Consumer<MyStuffProvider>(
                        builder: (context, myStuffProvider, child) {
                          if (myStuffProvider.loading) {
                            return Utils.pageLoader();
                          } else {
                            if (myStuffProvider.rentModel.status == 200) {
                              if ((myStuffProvider.rentModel.video?.length ??
                                          0) ==
                                      0 &&
                                  (myStuffProvider.rentModel.tvshow?.length ??
                                          0) ==
                                      0) {
                                return const NoData();
                              } else {
                                if (myStuffProvider.rentModel.video != null ||
                                    myStuffProvider.rentModel.tvshow != null) {
                                  return Column(
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      ((myStuffProvider.rentModel.video
                                                      ?.length ??
                                                  0) >
                                              0)
                                          ? Column(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 30,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, right: 20),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: [
                                                      MyText(
                                                        color: white,
                                                        text: purchasedVideos,
                                                        textalign:
                                                            TextAlign.center,
                                                        fontsize: 16,
                                                        maxline: 1,
                                                        fontwaight:
                                                            FontWeight.bold,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontstyle:
                                                            FontStyle.normal,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      MyText(
                                                        color: otherColor,
                                                        text:
                                                            "(${(myStuffProvider.rentModel.video?.length ?? 0)} $videosSmall)",
                                                        textalign:
                                                            TextAlign.center,
                                                        fontsize: 13,
                                                        maxline: 1,
                                                        fontwaight:
                                                            FontWeight.normal,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontstyle:
                                                            FontStyle.normal,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: (myStuffProvider
                                                                  .rentModel
                                                                  .video
                                                                  ?.length ??
                                                              0) ==
                                                          1
                                                      ? Constant.heightLand
                                                      : ((myStuffProvider
                                                                          .rentModel
                                                                          .video
                                                                          ?.length ??
                                                                      0) >
                                                                  1 &&
                                                              (myStuffProvider
                                                                          .rentModel
                                                                          .video
                                                                          ?.length ??
                                                                      0) <
                                                                  7)
                                                          ? (Constant
                                                                  .heightLand *
                                                              2)
                                                          : (myStuffProvider
                                                                          .rentModel
                                                                          .video
                                                                          ?.length ??
                                                                      0) >
                                                                  6
                                                              ? (Constant
                                                                      .heightLand *
                                                                  3)
                                                              : (Constant
                                                                      .heightLand *
                                                                  2),
                                                  child: AlignedGridView.count(
                                                    shrinkWrap: true,
                                                    crossAxisCount: (myStuffProvider
                                                                    .rentModel
                                                                    .video
                                                                    ?.length ??
                                                                0) ==
                                                            1
                                                        ? 1
                                                        : ((myStuffProvider
                                                                            .rentModel
                                                                            .video
                                                                            ?.length ??
                                                                        0) >
                                                                    1 &&
                                                                (myStuffProvider
                                                                            .rentModel
                                                                            .video
                                                                            ?.length ??
                                                                        0) <
                                                                    7)
                                                            ? 2
                                                            : (myStuffProvider
                                                                            .rentModel
                                                                            .video
                                                                            ?.length ??
                                                                        0) >
                                                                    6
                                                                ? 3
                                                                : 2,
                                                    crossAxisSpacing: 8,
                                                    mainAxisSpacing: 8,
                                                    itemCount: (myStuffProvider
                                                            .rentModel
                                                            .video
                                                            ?.length ??
                                                        0),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20),
                                                    physics:
                                                        const AlwaysScrollableScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int position) {
                                                      return InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        onTap: () {
                                                          log("Clicked on position ==> $position");
                                                          if ((myStuffProvider
                                                                      .rentModel
                                                                      .video
                                                                      ?.elementAt(
                                                                          position)
                                                                      .videoType ??
                                                                  0) ==
                                                              1) {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                                  return MovieDetails(
                                                                    myStuffProvider
                                                                            .rentModel
                                                                            .video
                                                                            ?.elementAt(position)
                                                                            .id ??
                                                                        0,
                                                                    myStuffProvider
                                                                            .rentModel
                                                                            .video
                                                                            ?.elementAt(position)
                                                                            .videoType ??
                                                                        0,
                                                                    myStuffProvider
                                                                            .rentModel
                                                                            .video
                                                                            ?.elementAt(position)
                                                                            .typeId ??
                                                                        0,
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          } else if ((myStuffProvider
                                                                      .rentModel
                                                                      .video
                                                                      ?.elementAt(
                                                                          position)
                                                                      .videoType ??
                                                                  0) ==
                                                              2) {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                                  return TvShowDetails(
                                                                    myStuffProvider
                                                                            .rentModel
                                                                            .video
                                                                            ?.elementAt(position)
                                                                            .id ??
                                                                        0,
                                                                    myStuffProvider
                                                                            .rentModel
                                                                            .video
                                                                            ?.elementAt(position)
                                                                            .videoType ??
                                                                        0,
                                                                    myStuffProvider
                                                                            .rentModel
                                                                            .video
                                                                            ?.elementAt(position)
                                                                            .typeId ??
                                                                        0,
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        child: Container(
                                                          width: Constant
                                                              .widthLand,
                                                          height: Constant
                                                              .heightLand,
                                                          alignment:
                                                              Alignment.center,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                            child:
                                                                MyNetworkImage(
                                                              imageUrl: myStuffProvider
                                                                      .rentModel
                                                                      .video
                                                                      ?.elementAt(
                                                                          position)
                                                                      .landscape
                                                                      .toString() ??
                                                                  "",
                                                              fit: BoxFit.cover,
                                                              imgHeight:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height,
                                                              imgWidth:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const SizedBox.shrink(),
                                      const SizedBox(
                                        height: 22,
                                      ),
                                      ((myStuffProvider.rentModel.tvshow
                                                      ?.length ??
                                                  0) >
                                              0)
                                          ? Column(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 30,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, right: 20),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: [
                                                      MyText(
                                                        color: white,
                                                        text: purchasedShows,
                                                        textalign:
                                                            TextAlign.center,
                                                        fontsize: 16,
                                                        maxline: 1,
                                                        fontwaight:
                                                            FontWeight.bold,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontstyle:
                                                            FontStyle.normal,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      MyText(
                                                        color: otherColor,
                                                        text:
                                                            "(${(myStuffProvider.rentModel.tvshow?.length ?? 0)} $showsSmall)",
                                                        textalign:
                                                            TextAlign.center,
                                                        fontsize: 13,
                                                        maxline: 1,
                                                        fontwaight:
                                                            FontWeight.normal,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontstyle:
                                                            FontStyle.normal,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: (myStuffProvider
                                                                  .rentModel
                                                                  .tvshow
                                                                  ?.length ??
                                                              0) ==
                                                          1
                                                      ? Constant.heightLand
                                                      : ((myStuffProvider
                                                                          .rentModel
                                                                          .tvshow
                                                                          ?.length ??
                                                                      0) >
                                                                  1 &&
                                                              (myStuffProvider
                                                                          .rentModel
                                                                          .tvshow
                                                                          ?.length ??
                                                                      0) <
                                                                  7)
                                                          ? (Constant
                                                                  .heightLand *
                                                              2)
                                                          : (myStuffProvider
                                                                          .rentModel
                                                                          .tvshow
                                                                          ?.length ??
                                                                      0) >
                                                                  6
                                                              ? (Constant
                                                                      .heightLand *
                                                                  3)
                                                              : (Constant
                                                                      .heightLand *
                                                                  2),
                                                  child: AlignedGridView.count(
                                                    shrinkWrap: true,
                                                    crossAxisCount: (myStuffProvider
                                                                    .rentModel
                                                                    .tvshow
                                                                    ?.length ??
                                                                0) ==
                                                            1
                                                        ? 1
                                                        : ((myStuffProvider
                                                                            .rentModel
                                                                            .tvshow
                                                                            ?.length ??
                                                                        0) >
                                                                    1 &&
                                                                (myStuffProvider
                                                                            .rentModel
                                                                            .tvshow
                                                                            ?.length ??
                                                                        0) <
                                                                    7)
                                                            ? 2
                                                            : (myStuffProvider
                                                                            .rentModel
                                                                            .tvshow
                                                                            ?.length ??
                                                                        0) >
                                                                    6
                                                                ? 3
                                                                : 2,
                                                    crossAxisSpacing: 8,
                                                    mainAxisSpacing: 8,
                                                    itemCount: (myStuffProvider
                                                            .rentModel
                                                            .tvshow
                                                            ?.length ??
                                                        0),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20),
                                                    physics:
                                                        const AlwaysScrollableScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int position) {
                                                      return InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        onTap: () {
                                                          log("Clicked on position ==> $position");
                                                          if ((myStuffProvider
                                                                      .rentModel
                                                                      .tvshow
                                                                      ?.elementAt(
                                                                          position)
                                                                      .videoType ??
                                                                  0) ==
                                                              1) {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                                  return MovieDetails(
                                                                    myStuffProvider
                                                                            .rentModel
                                                                            .tvshow
                                                                            ?.elementAt(position)
                                                                            .id ??
                                                                        0,
                                                                    myStuffProvider
                                                                            .rentModel
                                                                            .tvshow
                                                                            ?.elementAt(position)
                                                                            .videoType ??
                                                                        0,
                                                                    myStuffProvider
                                                                            .rentModel
                                                                            .tvshow
                                                                            ?.elementAt(position)
                                                                            .typeId ??
                                                                        0,
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          } else if ((myStuffProvider
                                                                      .rentModel
                                                                      .tvshow
                                                                      ?.elementAt(
                                                                          position)
                                                                      .videoType ??
                                                                  0) ==
                                                              2) {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                                  return TvShowDetails(
                                                                    myStuffProvider
                                                                            .rentModel
                                                                            .tvshow
                                                                            ?.elementAt(position)
                                                                            .id ??
                                                                        0,
                                                                    myStuffProvider
                                                                            .rentModel
                                                                            .tvshow
                                                                            ?.elementAt(position)
                                                                            .videoType ??
                                                                        0,
                                                                    myStuffProvider
                                                                            .rentModel
                                                                            .tvshow
                                                                            ?.elementAt(position)
                                                                            .typeId ??
                                                                        0,
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        child: Container(
                                                          width: Constant
                                                              .widthLand,
                                                          height: Constant
                                                              .heightLand,
                                                          alignment:
                                                              Alignment.center,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                            child:
                                                                MyNetworkImage(
                                                              imageUrl: myStuffProvider
                                                                      .rentModel
                                                                      .tvshow
                                                                      ?.elementAt(
                                                                          position)
                                                                      .landscape
                                                                      .toString() ??
                                                                  "",
                                                              fit: BoxFit.cover,
                                                              imgHeight:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height,
                                                              imgWidth:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const SizedBox.shrink(),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  );
                                } else {
                                  return const NoData();
                                }
                              }
                            } else {
                              return const NoData();
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
