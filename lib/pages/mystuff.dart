import 'dart:developer';
import 'dart:io';

import 'package:dtlive/pages/loginsocial.dart';
import 'package:dtlive/pages/moviedetails.dart';
import 'package:dtlive/utils/dimens.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:dtlive/widget/nodata.dart';
import 'package:dtlive/pages/setting.dart';
import 'package:dtlive/pages/tvshowdetails.dart';
import 'package:dtlive/provider/mystuffprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:social_share/social_share.dart';

class MyStuff extends StatefulWidget {
  const MyStuff({Key? key}) : super(key: key);

  @override
  State<MyStuff> createState() => MyStuffState();
}

class MyStuffState extends State<MyStuff> with TickerProviderStateMixin {
  late MyStuffProvider myStuffProvider;
  late TabController tabController =
      TabController(length: tabname.length, vsync: this);

  List<String> tabname = <String>[
    "downloads",
    "watchlist",
    "parchases",
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
    myStuffProvider = Provider.of<MyStuffProvider>(context, listen: false);
    if (Constant.userID != null) {
      _getData();
    } else {
      myStuffProvider.clearProvider();
      Future.delayed(Duration.zero).then((value) {
        if (mounted) return setState(() {});
      });
    }
  }

  void _getData() async {
    await myStuffProvider.getProfile();
    await myStuffProvider.getWatchlist();
    await myStuffProvider.getUserRentVideoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: appBgColor,
                  toolbarHeight: 90,
                  title: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
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
                                      imageUrl:
                                          myStuffProvider.profileModel.status ==
                                                  200
                                              ? myStuffProvider.profileModel
                                                          .result !=
                                                      null
                                                  ? (myStuffProvider
                                                          .profileModel
                                                          .result
                                                          ?.image
                                                          .toString() ??
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
                                    text: myStuffProvider.profileModel.status ==
                                            200
                                        ? myStuffProvider.profileModel.result !=
                                                null
                                            ? (myStuffProvider.profileModel
                                                    .result?.name ??
                                                guestUser)
                                            : guestUser
                                        : guestUser,
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
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const Setting();
                                },
                              ),
                            );
                            if (Constant.userID != null) {
                              _getData();
                            } else {
                              myStuffProvider.clearProvider();
                              Future.delayed(Duration.zero)
                                  .then((value) {
                                if (mounted) return setState(() {});
                              });
                            }
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
                  expandedHeight: 0,
                  forceElevated: innerBoxIsScrolled,
                ),
              ),
            ];
          },
          body: Column(
            children: [
              TabBar(
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
                        multilanguage: true,
                        overflow: TextOverflow.ellipsis,
                        fontwaight: FontWeight.w600,
                        textalign: TextAlign.center,
                        fontstyle: FontStyle.normal,
                      ),
                    );
                  },
                ),
              ),
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
                        if (myStuffProvider.loadingDownload) {
                          return Utils.pageLoader();
                        } else {
                          if (myStuffProvider.profileModel.status == 200) {
                            return _buildDownloadlist();
                          } else {
                            return const NoData(
                              title: 'no_downloads',
                              subTitle: '',
                            );
                          }
                        }
                      },
                    ),

                    /* WatchList */
                    Consumer<MyStuffProvider>(
                      builder: (context, myStuffProvider, child) {
                        if (myStuffProvider.loadingWatchlist) {
                          return Utils.pageLoader();
                        } else {
                          if (myStuffProvider.watchlistModel.status == 200 &&
                              myStuffProvider.watchlistModel.result != null) {
                            if ((myStuffProvider
                                        .watchlistModel.result?.length ??
                                    0) >
                                0) {
                              return _buildWatchlist();
                            } else {
                              return const NoData(
                                title: 'browse_now_watch_later',
                                subTitle: 'watchlist_note',
                              );
                            }
                          } else {
                            return const NoData(
                              title: 'browse_now_watch_later',
                              subTitle: 'watchlist_note',
                            );
                          }
                        }
                      },
                    ),

                    /* Purchases */
                    Consumer<MyStuffProvider>(
                      builder: (context, myStuffProvider, child) {
                        if (myStuffProvider.loadingPurchase) {
                          return Utils.pageLoader();
                        } else {
                          if (myStuffProvider.rentModel.status == 200) {
                            if ((myStuffProvider.rentModel.video?.length ??
                                        0) ==
                                    0 &&
                                (myStuffProvider.rentModel.tvshow?.length ??
                                        0) ==
                                    0) {
                              return const NoData(
                                title: 'rent_and_buy_your_favorites',
                                subTitle: 'no_purchases_note',
                              );
                            } else {
                              if (myStuffProvider.rentModel.video != null ||
                                  myStuffProvider.rentModel.tvshow != null) {
                                return _buildPurchaselist();
                              } else {
                                return const NoData(
                                  title: 'rent_and_buy_your_favorites',
                                  subTitle: 'no_purchases_note',
                                );
                              }
                            }
                          } else {
                            return const NoData(
                              title: 'rent_and_buy_your_favorites',
                              subTitle: 'no_purchases_note',
                            );
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
    );
  }

  Widget _buildDownloadlist() {
    return AlignedGridView.count(
      shrinkWrap: true,
      crossAxisCount: 1,
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      crossAxisSpacing: 0,
      mainAxisSpacing: 8,
      itemCount: downloadList.length,
      itemBuilder: (BuildContext context, int position) {
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
                width: MediaQuery.of(context).size.width * 0.44,
                height: MediaQuery.of(context).size.height,
                child: MyImage(
                  fit: BoxFit.fill,
                  imagePath: downloadList[position],
                  width: MediaQuery.of(context).size.width,
                  height: 95,
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              color: white,
                              text: downloadTitleList[position],
                              multilanguage: false,
                              textalign: TextAlign.center,
                              maxline: 3,
                              overflow: TextOverflow.ellipsis,
                              fontsize: 14,
                              fontwaight: FontWeight.w700,
                              fontstyle: FontStyle.normal,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Visibility(
                                  visible: (position == 1 || position == 2)
                                      ? true
                                      : false,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    child: MyText(
                                      color: otherColor,
                                      multilanguage: false,
                                      text: "Season 1",
                                      maxline: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textalign: TextAlign.center,
                                      fontsize: 12,
                                      fontwaight: FontWeight.normal,
                                      fontstyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: MyText(
                                    color: otherColor,
                                    text: "140 min",
                                    multilanguage: false,
                                    maxline: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textalign: TextAlign.center,
                                    fontsize: 12,
                                    fontwaight: FontWeight.normal,
                                    fontstyle: FontStyle.normal,
                                  ),
                                ),
                                MyText(
                                  color: otherColor,
                                  text: "140 MB",
                                  textalign: TextAlign.center,
                                  multilanguage: false,
                                  maxline: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontsize: 12,
                                  fontwaight: FontWeight.normal,
                                  fontstyle: FontStyle.normal,
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
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 25,
                          height: 25,
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10, right: 15),
                            child: MyImage(
                              width: 18,
                              height: 18,
                              imagePath: (position == 1 || position == 2)
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
  }

  Widget _buildPurchaselist() {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        ((myStuffProvider.rentModel.video?.length ?? 0) > 0)
            ? Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        MyText(
                          color: white,
                          text: "purchasvideo",
                          multilanguage: true,
                          textalign: TextAlign.center,
                          fontsize: 16,
                          maxline: 1,
                          fontwaight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                          fontstyle: FontStyle.normal,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        MyText(
                          color: otherColor,
                          text: (myStuffProvider.rentModel.video?.length ?? 0) >
                                  1
                              ? "(${(myStuffProvider.rentModel.video?.length ?? 0)} videos)"
                              : "(${(myStuffProvider.rentModel.video?.length ?? 0)} video)",
                          textalign: TextAlign.center,
                          fontsize: 13,
                          maxline: 1,
                          fontwaight: FontWeight.normal,
                          overflow: TextOverflow.ellipsis,
                          fontstyle: FontStyle.normal,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: (myStuffProvider.rentModel.video?.length ?? 0) == 1
                        ? Dimens.heightLand
                        : ((myStuffProvider.rentModel.video?.length ?? 0) > 1 &&
                                (myStuffProvider.rentModel.video?.length ?? 0) <
                                    7)
                            ? (Dimens.heightLand * 2)
                            : (myStuffProvider.rentModel.video?.length ?? 0) > 6
                                ? (Dimens.heightLand * 3)
                                : (Dimens.heightLand * 2),
                    child: AlignedGridView.count(
                      shrinkWrap: true,
                      crossAxisCount: (myStuffProvider
                                      .rentModel.video?.length ??
                                  0) ==
                              1
                          ? 1
                          : ((myStuffProvider.rentModel.video?.length ?? 0) >
                                      1 &&
                                  (myStuffProvider.rentModel.video?.length ??
                                          0) <
                                      7)
                              ? 2
                              : (myStuffProvider.rentModel.video?.length ?? 0) >
                                      6
                                  ? 3
                                  : 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      itemCount: (myStuffProvider.rentModel.video?.length ?? 0),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int position) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: () {
                            log("Clicked on position ==> $position");
                            if ((myStuffProvider
                                        .rentModel.video?[position].videoType ??
                                    0) ==
                                1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MovieDetails(
                                      myStuffProvider
                                              .rentModel.video?[position].id ??
                                          0,
                                      myStuffProvider.rentModel.video?[position]
                                              .videoType ??
                                          0,
                                      myStuffProvider.rentModel.video?[position]
                                              .typeId ??
                                          0,
                                    );
                                  },
                                ),
                              );
                            } else if ((myStuffProvider
                                        .rentModel.video?[position].videoType ??
                                    0) ==
                                2) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return TvShowDetails(
                                      myStuffProvider
                                              .rentModel.video?[position].id ??
                                          0,
                                      myStuffProvider.rentModel.video?[position]
                                              .videoType ??
                                          0,
                                      myStuffProvider.rentModel.video?[position]
                                              .typeId ??
                                          0,
                                    );
                                  },
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: Dimens.widthLand,
                            height: Dimens.heightLand,
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: MyNetworkImage(
                                imageUrl: myStuffProvider
                                        .rentModel.video?[position].landscape
                                        .toString() ??
                                    "",
                                fit: BoxFit.cover,
                                imgHeight: MediaQuery.of(context).size.height,
                                imgWidth: MediaQuery.of(context).size.width,
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
        ((myStuffProvider.rentModel.tvshow?.length ?? 0) > 0)
            ? Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        MyText(
                          color: white,
                          text: "purchaschow",
                          textalign: TextAlign.center,
                          multilanguage: true,
                          fontsize: 16,
                          maxline: 1,
                          fontwaight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                          fontstyle: FontStyle.normal,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        MyText(
                          color: otherColor,
                          text: (myStuffProvider.rentModel.tvshow?.length ??
                                      0) >
                                  1
                              ? "(${(myStuffProvider.rentModel.tvshow?.length ?? 0)} shows)"
                              : "(${(myStuffProvider.rentModel.tvshow?.length ?? 0)} show)",
                          textalign: TextAlign.center,
                          fontsize: 13,
                          maxline: 1,
                          fontwaight: FontWeight.normal,
                          overflow: TextOverflow.ellipsis,
                          fontstyle: FontStyle.normal,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: (myStuffProvider.rentModel.tvshow?.length ?? 0) == 1
                        ? Dimens.heightLand
                        : ((myStuffProvider.rentModel.tvshow?.length ?? 0) >
                                    1 &&
                                (myStuffProvider.rentModel.tvshow?.length ??
                                        0) <
                                    7)
                            ? (Dimens.heightLand * 2)
                            : (myStuffProvider.rentModel.tvshow?.length ?? 0) >
                                    6
                                ? (Dimens.heightLand * 3)
                                : (Dimens.heightLand * 2),
                    child: AlignedGridView.count(
                      shrinkWrap: true,
                      crossAxisCount:
                          (myStuffProvider.rentModel.tvshow?.length ?? 0) == 1
                              ? 1
                              : ((myStuffProvider.rentModel.tvshow?.length ??
                                              0) >
                                          1 &&
                                      (myStuffProvider
                                                  .rentModel.tvshow?.length ??
                                              0) <
                                          7)
                                  ? 2
                                  : (myStuffProvider.rentModel.tvshow?.length ??
                                              0) >
                                          6
                                      ? 3
                                      : 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      itemCount:
                          (myStuffProvider.rentModel.tvshow?.length ?? 0),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int position) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: () {
                            log("Clicked on position ==> $position");
                            if ((myStuffProvider.rentModel.tvshow?[position]
                                        .videoType ??
                                    0) ==
                                1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MovieDetails(
                                      myStuffProvider
                                              .rentModel.tvshow?[position].id ??
                                          0,
                                      myStuffProvider.rentModel
                                              .tvshow?[position].videoType ??
                                          0,
                                      myStuffProvider.rentModel
                                              .tvshow?[position].typeId ??
                                          0,
                                    );
                                  },
                                ),
                              );
                            } else if ((myStuffProvider.rentModel
                                        .tvshow?[position].videoType ??
                                    0) ==
                                2) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return TvShowDetails(
                                      myStuffProvider
                                              .rentModel.tvshow?[position].id ??
                                          0,
                                      myStuffProvider.rentModel
                                              .tvshow?[position].videoType ??
                                          0,
                                      myStuffProvider.rentModel
                                              .tvshow?[position].typeId ??
                                          0,
                                    );
                                  },
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: Dimens.widthLand,
                            height: Dimens.heightLand,
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: MyNetworkImage(
                                imageUrl: myStuffProvider
                                        .rentModel.tvshow?[position].landscape
                                        .toString() ??
                                    "",
                                fit: BoxFit.cover,
                                imgHeight: MediaQuery.of(context).size.height,
                                imgWidth: MediaQuery.of(context).size.width,
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
  }

  Widget _buildWatchlist() {
    return AlignedGridView.count(
      shrinkWrap: true,
      crossAxisCount: 1,
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      crossAxisSpacing: 0,
      mainAxisSpacing: 8,
      itemCount: myStuffProvider.watchlistModel.result?.length ?? 0,
      itemBuilder: (BuildContext context, int position) {
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
                width: MediaQuery.of(context).size.width * 0.44,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(0),
                      onTap: () {
                        log("Clicked on position ==> $position");
                        if ((myStuffProvider.watchlistModel.result?[position]
                                    .videoType ??
                                0) ==
                            1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MovieDetails(
                                  myStuffProvider.watchlistModel
                                          .result?[position].id ??
                                      0,
                                  myStuffProvider.watchlistModel
                                          .result?[position].videoType ??
                                      0,
                                  myStuffProvider.watchlistModel
                                          .result?[position].typeId ??
                                      0,
                                );
                              },
                            ),
                          );
                        } else if ((myStuffProvider.watchlistModel
                                    .result?[position].videoType ??
                                0) ==
                            2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return TvShowDetails(
                                  myStuffProvider.watchlistModel
                                          .result?[position].id ??
                                      0,
                                  myStuffProvider.watchlistModel
                                          .result?[position].videoType ??
                                      0,
                                  myStuffProvider.watchlistModel
                                          .result?[position].typeId ??
                                      0,
                                );
                              },
                            ),
                          );
                        }
                      },
                      child: MyNetworkImage(
                        imageUrl: (myStuffProvider.watchlistModel
                                        .result?[position].landscape ??
                                    "")
                                .isNotEmpty
                            ? (myStuffProvider.watchlistModel.result?[position]
                                    .landscape ??
                                "")
                            : (myStuffProvider.watchlistModel.result?[position]
                                    .thumbnail ??
                                ""),
                        fit: BoxFit.fill,
                        imgWidth: MediaQuery.of(context).size.width,
                        imgHeight: 95,
                      ),
                    ),
                    ((myStuffProvider.watchlistModel.result?[position]
                                    .videoType ??
                                0) !=
                            2)
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 5),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    Map<String, String> qualityUrlList =
                                        <String, String>{
                                      '320p': myStuffProvider.watchlistModel
                                              .result?[position].video320 ??
                                          '',
                                      '480p': myStuffProvider.watchlistModel
                                              .result?[position].video480 ??
                                          '',
                                      '720p': myStuffProvider.watchlistModel
                                              .result?[position].video720 ??
                                          '',
                                      '1080p': myStuffProvider.watchlistModel
                                              .result?[position].video1080 ??
                                          '',
                                    };
                                    debugPrint(
                                        "qualityUrlList ==========> ${qualityUrlList.length}");
                                    Constant.resolutionsUrls = qualityUrlList;
                                    debugPrint(
                                        "resolutionsUrls ==========> ${Constant.resolutionsUrls.length}");
                                    var isContinues = await Utils.openPlayer(
                                        context: context,
                                        playType: "Video",
                                        videoId: myStuffProvider.watchlistModel.result?[position].id ??
                                            0,
                                        videoType: myStuffProvider
                                                .watchlistModel
                                                .result?[position]
                                                .videoType ??
                                            0,
                                        typeId: myStuffProvider.watchlistModel
                                                .result?[position].typeId ??
                                            0,
                                        videoUrl: myStuffProvider.watchlistModel
                                                .result?[position].video320 ??
                                            "",
                                        trailerUrl: myStuffProvider
                                                .watchlistModel
                                                .result?[position]
                                                .trailerUrl ??
                                            "",
                                        uploadType: myStuffProvider.watchlistModel.result?[position].videoUploadType ?? "",
                                        vSubtitle: myStuffProvider.watchlistModel.result?[position].subtitle ?? "",
                                        vStopTime: myStuffProvider.watchlistModel.result?[position].stopTime ?? 0);
                                    if (isContinues != null &&
                                        isContinues == true) {
                                      await myStuffProvider.getWatchlist();
                                    }
                                  },
                                  child: MyImage(
                                    width: 30,
                                    height: 30,
                                    imagePath: "play.png",
                                  ),
                                ),
                              ),
                              ((myStuffProvider.watchlistModel.result?[position]
                                              .videoDuration) !=
                                          null &&
                                      (myStuffProvider.watchlistModel
                                                  .result?[position].stopTime ??
                                              0) >
                                          0)
                                  ? Container(
                                      constraints:
                                          const BoxConstraints(minWidth: 0),
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(3),
                                      child: LinearPercentIndicator(
                                        padding: const EdgeInsets.all(0),
                                        barRadius: const Radius.circular(2),
                                        lineHeight: 4,
                                        percent: Utils.getPercentage(
                                            myStuffProvider
                                                    .watchlistModel
                                                    .result?[position]
                                                    .videoDuration ??
                                                0,
                                            myStuffProvider
                                                    .watchlistModel
                                                    .result?[position]
                                                    .stopTime ??
                                                0),
                                        backgroundColor: secProgressColor,
                                        progressColor: primaryColor,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              (myStuffProvider.watchlistModel.result?[position]
                                              .releaseTag !=
                                          null &&
                                      (myStuffProvider
                                                  .watchlistModel
                                                  .result?[position]
                                                  .releaseTag ??
                                              "")
                                          .isNotEmpty)
                                  ? Container(
                                      decoration: const BoxDecoration(
                                        color: black,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(4),
                                          bottomRight: Radius.circular(4),
                                        ),
                                        shape: BoxShape.rectangle,
                                      ),
                                      width: 172,
                                      height: 12,
                                      child: MyText(
                                        color: white,
                                        text: myStuffProvider.watchlistModel
                                                .result?[position].releaseTag ??
                                            "",
                                        textalign: TextAlign.center,
                                        fontsize: 6,
                                        maxline: 1,
                                        fontwaight: FontWeight.normal,
                                        overflow: TextOverflow.ellipsis,
                                        fontstyle: FontStyle.normal,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /* Title */
                            MyText(
                              color: white,
                              text: myStuffProvider
                                      .watchlistModel.result?[position].name ??
                                  "",
                              textalign: TextAlign.center,
                              maxline: 3,
                              overflow: TextOverflow.ellipsis,
                              fontsize: 14,
                              fontwaight: FontWeight.w700,
                              fontstyle: FontStyle.normal,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            /* Release Year & Video Duration */
                            Row(
                              children: [
                                (myStuffProvider
                                                .watchlistModel
                                                .result?[position]
                                                .releaseYear ??
                                            "")
                                        .isNotEmpty
                                    ? Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        child: MyText(
                                          color: otherColor,
                                          text: myStuffProvider
                                                  .watchlistModel
                                                  .result?[position]
                                                  .releaseYear ??
                                              "",
                                          maxline: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textalign: TextAlign.center,
                                          fontsize: 12,
                                          fontwaight: FontWeight.normal,
                                          fontstyle: FontStyle.normal,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                (myStuffProvider.watchlistModel
                                                .result?[position].videoType ??
                                            0) !=
                                        2
                                    ? (myStuffProvider
                                                    .watchlistModel
                                                    .result?[position]
                                                    .videoDuration !=
                                                null &&
                                            (myStuffProvider
                                                        .watchlistModel
                                                        .result?[position]
                                                        .videoDuration ??
                                                    0) >
                                                0)
                                        ? MyText(
                                            color: otherColor,
                                            text: Utils.convertInMin(
                                                myStuffProvider
                                                        .watchlistModel
                                                        .result?[position]
                                                        .videoDuration ??
                                                    0),
                                            textalign: TextAlign.center,
                                            maxline: 1,
                                            overflow: TextOverflow.ellipsis,
                                            fontsize: 12,
                                            fontwaight: FontWeight.normal,
                                            fontstyle: FontStyle.normal,
                                          )
                                        : const SizedBox.shrink()
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            /* Prime TAG  & Rent TAG */
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /* Prime TAG */
                                (myStuffProvider.watchlistModel
                                                .result?[position].isPremium ??
                                            0) ==
                                        1
                                    ? MyText(
                                        color: primaryColor,
                                        text: "primetag",
                                        multilanguage: true,
                                        textalign: TextAlign.start,
                                        fontsize: 12,
                                        fontwaight: FontWeight.w800,
                                        maxline: 1,
                                        overflow: TextOverflow.ellipsis,
                                        fontstyle: FontStyle.normal,
                                      )
                                    : const SizedBox.shrink(),
                                const SizedBox(
                                  height: 3,
                                ),
                                /* Rent TAG */
                                (myStuffProvider.watchlistModel
                                                .result?[position].isRent ??
                                            0) ==
                                        1
                                    ? MyText(
                                        color: white,
                                        text: "renttag",
                                        multilanguage: true,
                                        textalign: TextAlign.start,
                                        fontsize: 12,
                                        fontwaight: FontWeight.normal,
                                        maxline: 1,
                                        overflow: TextOverflow.ellipsis,
                                        fontstyle: FontStyle.normal,
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            _buildVideoMoreDialog(position);
                          },
                          child: Container(
                            width: 25,
                            height: 25,
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, right: 15),
                              child: MyImage(
                                width: 18,
                                height: 18,
                                imagePath: "ic_more.png",
                              ),
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
  }

  _buildVideoMoreDialog(position) {
    showModalBottomSheet(
      context: context,
      backgroundColor: lightBlack,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(0),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(23),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /* Title */
                  MyText(
                    text:
                        myStuffProvider.watchlistModel.result?[position].name ??
                            "",
                    multilanguage: false,
                    fontsize: 18,
                    color: white,
                    fontstyle: FontStyle.normal,
                    fontwaight: FontWeight.w700,
                    maxline: 2,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  /* Release year, Video duration & Comment Icon */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (myStuffProvider.watchlistModel.result?[position]
                                      .releaseYear ??
                                  "")
                              .isNotEmpty
                          ? Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: MyText(
                                color: otherColor,
                                text: myStuffProvider.watchlistModel
                                        .result?[position].releaseYear ??
                                    "",
                                maxline: 1,
                                overflow: TextOverflow.ellipsis,
                                textalign: TextAlign.center,
                                fontsize: 12,
                                fontwaight: FontWeight.w500,
                                fontstyle: FontStyle.normal,
                              ),
                            )
                          : const SizedBox.shrink(),
                      (myStuffProvider.watchlistModel.result?[position]
                                      .videoType ??
                                  0) !=
                              2
                          ? (myStuffProvider.watchlistModel.result?[position]
                                          .videoDuration !=
                                      null &&
                                  (myStuffProvider
                                              .watchlistModel
                                              .result?[position]
                                              .videoDuration ??
                                          0) >
                                      0)
                              ? Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: MyText(
                                    color: otherColor,
                                    text: Utils.convertInMin(myStuffProvider
                                            .watchlistModel
                                            .result?[position]
                                            .videoDuration ??
                                        0),
                                    textalign: TextAlign.center,
                                    maxline: 1,
                                    overflow: TextOverflow.ellipsis,
                                    fontsize: 12,
                                    fontwaight: FontWeight.w500,
                                    fontstyle: FontStyle.normal,
                                  ),
                                )
                              : const SizedBox.shrink()
                          : const SizedBox.shrink(),
                      MyImage(
                        width: 18,
                        height: 18,
                        imagePath: "ic_comment.png",
                        fit: BoxFit.fill,
                        color: lightGray,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  /* Prime TAG  & Rent TAG */
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* Prime TAG */
                      (myStuffProvider.watchlistModel.result?[position]
                                      .isPremium ??
                                  0) ==
                              1
                          ? MyText(
                              color: primaryColor,
                              text: "primetag",
                              multilanguage: true,
                              textalign: TextAlign.start,
                              fontsize: 12,
                              fontwaight: FontWeight.w800,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal,
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: 5,
                      ),
                      /* Rent TAG */
                      (myStuffProvider.watchlistModel.result?[position]
                                      .isRent ??
                                  0) ==
                              1
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: complimentryColor,
                                    borderRadius: BorderRadius.circular(10),
                                    shape: BoxShape.rectangle,
                                  ),
                                  margin: const EdgeInsets.only(right: 5),
                                  alignment: Alignment.center,
                                  child: MyText(
                                    color: white,
                                    text: Constant.currencySymbol,
                                    textalign: TextAlign.center,
                                    fontsize: 10,
                                    multilanguage: false,
                                    fontwaight: FontWeight.w800,
                                    maxline: 1,
                                    overflow: TextOverflow.ellipsis,
                                    fontstyle: FontStyle.normal,
                                  ),
                                ),
                                MyText(
                                  color: white,
                                  text: "renttag",
                                  multilanguage: true,
                                  textalign: TextAlign.start,
                                  fontsize: 12,
                                  fontwaight: FontWeight.normal,
                                  maxline: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontstyle: FontStyle.normal,
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),

                  /* Watch Now / Resume */
                  ((myStuffProvider
                                  .watchlistModel.result?[position].videoType ??
                              0) !=
                          2)
                      ? InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () async {
                            Navigator.pop(context);
                            Map<String, String> qualityUrlList =
                                <String, String>{
                              '320p': myStuffProvider.watchlistModel
                                      .result?[position].video320 ??
                                  '',
                              '480p': myStuffProvider.watchlistModel
                                      .result?[position].video480 ??
                                  '',
                              '720p': myStuffProvider.watchlistModel
                                      .result?[position].video720 ??
                                  '',
                              '1080p': myStuffProvider.watchlistModel
                                      .result?[position].video1080 ??
                                  '',
                            };
                            debugPrint(
                                "qualityUrlList ==========> ${qualityUrlList.length}");
                            Constant.resolutionsUrls = qualityUrlList;
                            debugPrint(
                                "resolutionsUrls ==========> ${Constant.resolutionsUrls.length}");
                            var isContinues = await Utils.openPlayer(
                                context: context,
                                playType: "Video",
                                videoId:
                                    myStuffProvider.watchlistModel.result?[position].id ??
                                        0,
                                videoType: myStuffProvider.watchlistModel
                                        .result?[position].videoType ??
                                    0,
                                typeId: myStuffProvider.watchlistModel
                                        .result?[position].typeId ??
                                    0,
                                videoUrl: myStuffProvider.watchlistModel
                                        .result?[position].video320 ??
                                    "",
                                trailerUrl: myStuffProvider.watchlistModel
                                        .result?[position].trailerUrl ??
                                    "",
                                uploadType: myStuffProvider.watchlistModel.result?[position].videoUploadType ?? "",
                                vSubtitle: myStuffProvider.watchlistModel.result?[position].subtitle ?? "",
                                vStopTime: myStuffProvider.watchlistModel.result?[position].stopTime ?? 0);
                            if (isContinues != null && isContinues == true) {
                              await myStuffProvider.getWatchlist();
                            }
                          },
                          child: Container(
                            height: Dimens.minHtDialogContent,
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyImage(
                                  width: Dimens.dialogIconSize,
                                  height: Dimens.dialogIconSize,
                                  imagePath: (myStuffProvider.watchlistModel
                                                  .result?[position].stopTime ??
                                              0) >
                                          0
                                      ? "ic_resume.png"
                                      : "ic_play.png",
                                  fit: BoxFit.contain,
                                  color: otherColor,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: MyText(
                                    text: (myStuffProvider
                                                    .watchlistModel
                                                    .result?[position]
                                                    .stopTime ??
                                                0) >
                                            0
                                        ? "resume"
                                        : "watch_now",
                                    multilanguage: true,
                                    fontsize: 16,
                                    color: white,
                                    fontstyle: FontStyle.normal,
                                    fontwaight: FontWeight.normal,
                                    maxline: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textalign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),

                  /* Start Over */
                  ((myStuffProvider.watchlistModel.result?[position].stopTime ??
                                  0) >
                              0 &&
                          (myStuffProvider.watchlistModel.result?[position]
                                      .videoType ??
                                  0) !=
                              2)
                      ? InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () async {
                            Navigator.pop(context);
                            Map<String, String> qualityUrlList =
                                <String, String>{
                              '320p': myStuffProvider.watchlistModel
                                      .result?[position].video320 ??
                                  '',
                              '480p': myStuffProvider.watchlistModel
                                      .result?[position].video480 ??
                                  '',
                              '720p': myStuffProvider.watchlistModel
                                      .result?[position].video720 ??
                                  '',
                              '1080p': myStuffProvider.watchlistModel
                                      .result?[position].video1080 ??
                                  '',
                            };
                            debugPrint(
                                "qualityUrlList ==========> ${qualityUrlList.length}");
                            Constant.resolutionsUrls = qualityUrlList;
                            debugPrint(
                                "resolutionsUrls ==========> ${Constant.resolutionsUrls.length}");
                            var isContinues = await Utils.openPlayer(
                                context: context,
                                playType: "startOver",
                                videoId:
                                    myStuffProvider.watchlistModel.result?[position].id ??
                                        0,
                                videoType: myStuffProvider.watchlistModel
                                        .result?[position].videoType ??
                                    0,
                                typeId: myStuffProvider.watchlistModel
                                        .result?[position].typeId ??
                                    0,
                                videoUrl: myStuffProvider.watchlistModel
                                        .result?[position].video320 ??
                                    "",
                                trailerUrl: myStuffProvider.watchlistModel
                                        .result?[position].trailerUrl ??
                                    "",
                                uploadType: myStuffProvider.watchlistModel.result?[position].videoUploadType ?? "",
                                vSubtitle: myStuffProvider.watchlistModel.result?[position].subtitle ?? "",
                                vStopTime: 0);
                            if (isContinues != null && isContinues == true) {
                              await myStuffProvider.getWatchlist();
                            }
                          },
                          child: Container(
                            height: Dimens.minHtDialogContent,
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyImage(
                                  width: Dimens.dialogIconSize,
                                  height: Dimens.dialogIconSize,
                                  imagePath: "ic_restart.png",
                                  fit: BoxFit.contain,
                                  color: otherColor,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: MyText(
                                    text: "startover",
                                    multilanguage: true,
                                    fontsize: 16,
                                    color: white,
                                    fontstyle: FontStyle.normal,
                                    fontwaight: FontWeight.normal,
                                    maxline: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textalign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),

                  /* Watch Trailer */
                  ((myStuffProvider
                                  .watchlistModel.result?[position].videoType ??
                              0) !=
                          2)
                      ? InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () async {
                            Navigator.pop(context);
                            await Utils.openPlayer(
                                context: context,
                                playType: "Trailer",
                                videoId: myStuffProvider
                                        .watchlistModel.result?[position].id ??
                                    0,
                                videoType: myStuffProvider.watchlistModel
                                        .result?[position].videoType ??
                                    0,
                                typeId: myStuffProvider.watchlistModel
                                        .result?[position].typeId ??
                                    0,
                                videoUrl: "",
                                trailerUrl: myStuffProvider.watchlistModel
                                        .result?[position].trailerUrl ??
                                    "",
                                uploadType: myStuffProvider.watchlistModel
                                        .result?[position].videoUploadType ??
                                    "",
                                vSubtitle: "",
                                vStopTime: 0);
                          },
                          child: Container(
                            height: Dimens.minHtDialogContent,
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyImage(
                                  width: Dimens.dialogIconSize,
                                  height: Dimens.dialogIconSize,
                                  imagePath: "ic_borderplay.png",
                                  fit: BoxFit.contain,
                                  color: otherColor,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: MyText(
                                    text: "watch_trailer",
                                    multilanguage: true,
                                    fontsize: 16,
                                    color: white,
                                    fontstyle: FontStyle.normal,
                                    fontwaight: FontWeight.normal,
                                    maxline: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textalign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),

                  /* Add to Watchlist / Remove from Watchlist */
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () async {
                      Navigator.pop(context);
                      log("isBookmark ====> ${myStuffProvider.watchlistModel.result?[position].isBookmark ?? 0}");
                      if (Constant.userID != null) {
                        await myStuffProvider.setBookMark(
                          context,
                          position,
                          myStuffProvider
                                  .watchlistModel.result?[position].typeId ??
                              0,
                          myStuffProvider
                                  .watchlistModel.result?[position].videoType ??
                              0,
                          myStuffProvider.watchlistModel.result?[position].id ??
                              0,
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LoginSocial();
                            },
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: Dimens.minHtDialogContent,
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyImage(
                            width: Dimens.dialogIconSize,
                            height: Dimens.dialogIconSize,
                            imagePath: ((myStuffProvider.watchlistModel
                                            .result?[position].isBookmark ??
                                        0) ==
                                    1)
                                ? "watchlist_remove.png"
                                : "ic_plus.png",
                            fit: BoxFit.contain,
                            color: otherColor,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: MyText(
                              text: ((myStuffProvider.watchlistModel
                                              .result?[position].isBookmark ??
                                          0) ==
                                      1)
                                  ? "remove_from_watchlist"
                                  : "add_to_watchlist",
                              multilanguage: true,
                              fontsize: 16,
                              color: white,
                              fontstyle: FontStyle.normal,
                              fontwaight: FontWeight.normal,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              textalign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /* Download Add/Delete */
                  ((myStuffProvider
                                  .watchlistModel.result?[position].videoType ??
                              0) !=
                          2)
                      ? InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: Dimens.minHtDialogContent,
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyImage(
                                  width: Dimens.dialogIconSize,
                                  height: Dimens.dialogIconSize,
                                  imagePath: "ic_download.png",
                                  fit: BoxFit.contain,
                                  color: otherColor,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: MyText(
                                    text: "download",
                                    multilanguage: true,
                                    fontsize: 16,
                                    color: white,
                                    fontstyle: FontStyle.normal,
                                    fontwaight: FontWeight.normal,
                                    maxline: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textalign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),

                  /* Video Share */
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () async {
                      Navigator.pop(context);
                      _buildShareWithDialog(position);
                    },
                    child: Container(
                      height: Dimens.minHtDialogContent,
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyImage(
                            width: Dimens.dialogIconSize,
                            height: Dimens.dialogIconSize,
                            imagePath: "ic_share.png",
                            fit: BoxFit.contain,
                            color: otherColor,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: MyText(
                              text: "share",
                              multilanguage: true,
                              fontsize: 16,
                              color: white,
                              fontstyle: FontStyle.normal,
                              fontwaight: FontWeight.normal,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              textalign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /* View Details */
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () async {
                      Navigator.pop(context);
                      log("Clicked on position :==> $position");
                      if ((myStuffProvider
                                  .watchlistModel.result?[position].videoType ??
                              0) ==
                          1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MovieDetails(
                                myStuffProvider
                                        .watchlistModel.result?[position].id ??
                                    0,
                                myStuffProvider.watchlistModel.result?[position]
                                        .videoType ??
                                    0,
                                myStuffProvider.watchlistModel.result?[position]
                                        .typeId ??
                                    0,
                              );
                            },
                          ),
                        );
                      } else if ((myStuffProvider
                                  .watchlistModel.result?[position].videoType ??
                              0) ==
                          2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return TvShowDetails(
                                myStuffProvider
                                        .watchlistModel.result?[position].id ??
                                    0,
                                myStuffProvider.watchlistModel.result?[position]
                                        .videoType ??
                                    0,
                                myStuffProvider.watchlistModel.result?[position]
                                        .typeId ??
                                    0,
                              );
                            },
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: Dimens.minHtDialogContent,
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyImage(
                            width: Dimens.dialogIconSize,
                            height: Dimens.dialogIconSize,
                            imagePath: "ic_info.png",
                            fit: BoxFit.contain,
                            color: otherColor,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: MyText(
                              text: "view_details",
                              multilanguage: true,
                              fontsize: 16,
                              color: white,
                              fontstyle: FontStyle.normal,
                              fontwaight: FontWeight.normal,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              textalign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  _buildShareWithDialog(position) {
    showModalBottomSheet(
      context: context,
      backgroundColor: lightBlack,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(0),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(23),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyText(
                    text:
                        myStuffProvider.watchlistModel.result?[position].name ??
                            "",
                    multilanguage: false,
                    fontsize: 18,
                    color: white,
                    fontstyle: FontStyle.normal,
                    fontwaight: FontWeight.w700,
                    maxline: 2,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (myStuffProvider.watchlistModel.result?[position]
                                      .ageRestriction ??
                                  "")
                              .isNotEmpty
                          ? Container(
                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              margin: const EdgeInsets.only(right: 8),
                              decoration: Utils.setBGWithBorder(
                                  transparentColor, otherColor, 3, 0.7),
                              child: MyText(
                                text: myStuffProvider.watchlistModel
                                        .result?[position].ageRestriction ??
                                    "",
                                multilanguage: false,
                                fontsize: 10,
                                color: otherColor,
                                fontstyle: FontStyle.normal,
                                fontwaight: FontWeight.normal,
                                maxline: 1,
                                overflow: TextOverflow.ellipsis,
                                textalign: TextAlign.start,
                              ),
                            )
                          : const SizedBox.shrink(),
                      MyImage(
                        width: 18,
                        height: 18,
                        imagePath: "ic_comment.png",
                        fit: BoxFit.fill,
                        color: lightGray,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),

                  /* SMS */
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      Navigator.pop(context);
                      if (Platform.isAndroid) {
                        Utils.redirectToUrl(
                            'sms:?body=${Uri.encodeComponent("Hey! I'm watching ${myStuffProvider.watchlistModel.result?[position].name ?? ""}. Check it out now on ${Constant.appName}! \nhttps://play.google.com/store/apps/details?id=${Constant.appPackageName} \n")}');
                      } else if (Platform.isIOS) {
                        Utils.redirectToUrl(
                            'sms:&body=${Uri.encodeComponent("Hey! I'm watching ${myStuffProvider.watchlistModel.result?[position].name ?? ""}. Check it out now on ${Constant.appName}! \nhttps://apps.apple.com/us/app/${Constant.appName?.toLowerCase()}/${Constant.appPackageName} \n")}');
                      }
                    },
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyImage(
                            width: 22,
                            height: 22,
                            imagePath: "ic_sms.png",
                            fit: BoxFit.fill,
                            color: lightGray,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: MyText(
                              text: "sms",
                              multilanguage: true,
                              fontsize: 16,
                              color: white,
                              fontstyle: FontStyle.normal,
                              fontwaight: FontWeight.normal,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              textalign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /* Instgram Stories */
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      Navigator.pop(context);
                      Utils.shareApp(Platform.isIOS
                          ? "Hey! I'm watching ${myStuffProvider.watchlistModel.result?[position].name ?? ""}. Check it out now on ${Constant.appName}! \nhttps://apps.apple.com/us/app/${Constant.appName?.toLowerCase()}/${Constant.appPackageName} \n"
                          : "Hey! I'm watching ${myStuffProvider.watchlistModel.result?[position].name ?? ""}. Check it out now on ${Constant.appName}! \nhttps://play.google.com/store/apps/details?id=${Constant.appPackageName} \n");
                    },
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyImage(
                            width: 22,
                            height: 22,
                            imagePath: "ic_insta.png",
                            fit: BoxFit.fill,
                            color: lightGray,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: MyText(
                              text: "instagram_stories",
                              multilanguage: true,
                              fontsize: 16,
                              color: white,
                              fontstyle: FontStyle.normal,
                              fontwaight: FontWeight.normal,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              textalign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /* Copy Link */
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      Navigator.pop(context);
                      SocialShare.copyToClipboard(
                        text: Platform.isIOS
                            ? "Hey! I'm watching ${myStuffProvider.watchlistModel.result?[position].name ?? ""}. Check it out now on ${Constant.appName}! \nhttps://apps.apple.com/us/app/${Constant.appName?.toLowerCase()}/${Constant.appPackageName} \n"
                            : "Hey! I'm watching ${myStuffProvider.watchlistModel.result?[position].name ?? ""}. Check it out now on ${Constant.appName}! \nhttps://play.google.com/store/apps/details?id=${Constant.appPackageName} \n",
                      ).then((data) {
                        debugPrint(data);
                        Utils.showSnackbar(context, "success", "link_copied");
                      });
                    },
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyImage(
                            width: 22,
                            height: 22,
                            imagePath: "ic_link.png",
                            fit: BoxFit.fill,
                            color: lightGray,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: MyText(
                              text: "copy_link",
                              multilanguage: true,
                              fontsize: 16,
                              color: white,
                              fontstyle: FontStyle.normal,
                              fontwaight: FontWeight.normal,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              textalign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /* More */
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      Navigator.pop(context);
                      Utils.shareApp(Platform.isIOS
                          ? "Hey! I'm watching ${myStuffProvider.watchlistModel.result?[position].name ?? ""}. Check it out now on ${Constant.appName}! \nhttps://apps.apple.com/us/app/${Constant.appName?.toLowerCase()}/${Constant.appPackageName} \n"
                          : "Hey! I'm watching ${myStuffProvider.watchlistModel.result?[position].name ?? ""}. Check it out now on ${Constant.appName}! \nhttps://play.google.com/store/apps/details?id=${Constant.appPackageName} \n");
                    },
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyImage(
                            width: 22,
                            height: 22,
                            imagePath: "ic_dots_h.png",
                            fit: BoxFit.fill,
                            color: lightGray,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: MyText(
                              text: "more",
                              multilanguage: true,
                              fontsize: 16,
                              color: white,
                              fontstyle: FontStyle.normal,
                              fontwaight: FontWeight.normal,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              textalign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
