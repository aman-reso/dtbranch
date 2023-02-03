import 'dart:async';
import 'dart:developer';

import 'package:dtlive/model/sectionlistmodel.dart';
import 'package:dtlive/model/sectiontypemodel.dart' as type;
import 'package:dtlive/model/sectionlistmodel.dart' as list;
import 'package:dtlive/model/sectionbannermodel.dart' as banner;
import 'package:dtlive/pages/moviedetails.dart';
import 'package:dtlive/widget/nodata.dart';
import 'package:dtlive/pages/tvshowdetails.dart';
import 'package:dtlive/pages/videosbyid.dart';
import 'package:dtlive/provider/homeprovider.dart';
import 'package:dtlive/provider/sectiondataprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin<Home> {
  TabController? tabController;
  PageController pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    Utils.getCurrencySymbol();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    await homeProvider.getSectionType();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    if (!homeProvider.loading) {
      if (homeProvider.sectionTypeModel.status == 200 &&
          homeProvider.sectionTypeModel.result != null) {
        if ((homeProvider.sectionTypeModel.result?.length ?? 0) > 0) {
          tabController = TabController(
            vsync: this,
            length: (homeProvider.sectionTypeModel.result?.length ?? 0) + 1,
          );
          log("tabController index ==> ${(tabController?.index ?? 0)}");
          if ((tabController?.index ?? 0) == 0) {
            getTabData(0, homeProvider.sectionTypeModel.result);
          }
          tabController?.addListener(() {
            log("tabController Size ==> ${(tabController?.length ?? 0)}");
            getTabData(tabController?.index ?? 0,
                homeProvider.sectionTypeModel.result);
          });
        }
      }
    }
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: appBgColor,
          title: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: MyImage(width: 80, height: 80, imagePath: "appicon.png"),
          ),
        ),
      ),
      body: homeProvider.loading
          ? Utils.pageLoader()
          : (homeProvider.sectionTypeModel.status == 200 &&
                  homeProvider.sectionTypeModel.result != null)
              ? (homeProvider.sectionTypeModel.result?.length ?? 0) > 0
                  ? Column(
                      children: [
                        tabTitle(homeProvider.sectionTypeModel.result),
                        tabItem(homeProvider.sectionTypeModel.result),
                      ],
                    )
                  : const NoData(
                      title: '',
                      subTitle: '',
                    )
              : const NoData(
                  title: '',
                  subTitle: '',
                ),
    );
  }

  Widget tabTitle(List<type.Result>? sectionTypeList) {
    return Container(
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
        tabs: List<Widget>.generate(
          (sectionTypeList?.length ?? 0) + 1,
          (int index) {
            return Tab(
              child: MyText(
                color: white,
                multilanguage: false,
                text: index == 0
                    ? "All"
                    : index > 0
                        ? (sectionTypeList
                                ?.elementAt(index - 1)
                                .name
                                .toString() ??
                            "")
                        : "",
                fontsize: 12,
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
    );
  }

  Widget tabItem(List<type.Result>? sectionTypeList) {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: TabBarView(
          controller: tabController,
          physics: const AlwaysScrollableScrollPhysics(),
          children: List<Widget>.generate(
            (sectionTypeList?.length ?? 0) + 1,
            (int index) {
              return Consumer<SectionDataProvider>(
                builder: (context, sectionDataProvider, child) {
                  log("sectionDataProvider status :=======> ${sectionDataProvider.sectionBannerModel.status}");
                  if (sectionDataProvider.loading) {
                    return Utils.pageLoader();
                  } else {
                    if ((sectionDataProvider.sectionBannerModel.status == 200 &&
                            sectionDataProvider.sectionBannerModel.result !=
                                null) ||
                        (sectionDataProvider.sectionListModel.status == 200 &&
                            sectionDataProvider.sectionListModel.result !=
                                null)) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            /* Banner */
                            (sectionDataProvider.sectionBannerModel.status ==
                                        200 &&
                                    sectionDataProvider
                                            .sectionBannerModel.result !=
                                        null)
                                ? homebanner(sectionDataProvider
                                    .sectionBannerModel.result)
                                : const SizedBox.shrink(),
                            // /* Continue Watching */
                            (sectionDataProvider
                                        .sectionListModel.continueWatching !=
                                    null)
                                ? continueWatchingLayout(sectionDataProvider
                                    .sectionListModel.continueWatching)
                                : const SizedBox.shrink(),
                            /* Remaining Data */
                            (sectionDataProvider.sectionListModel.status ==
                                        200 &&
                                    sectionDataProvider
                                            .sectionListModel.result !=
                                        null)
                                ? setSectionByType(
                                    sectionDataProvider.sectionListModel.result)
                                : const SizedBox.shrink(),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const NoData(
                        title: '',
                        subTitle: '',
                      );
                    }
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> getTabData(
      int position, List<type.Result>? sectionTypeList) async {
    final sectionDataProvider =
        Provider.of<SectionDataProvider>(context, listen: false);
    await sectionDataProvider.getSectionBanner(
        position == 0 ? "0" : (sectionTypeList?[position - 1].id),
        position == 0 ? "1" : "2");
    await sectionDataProvider.getSectionList(
        position == 0 ? "0" : (sectionTypeList?[position - 1].id),
        position == 0 ? "1" : "2");
  }

  // void _animateSlider(List<banner.Result>? sectionBannerList) {
  //   Future.delayed(const Duration(seconds: 2)).then((_) {
  //     int nextPage = pageController.page?.round() ?? 0 + 1;
  //     if (nextPage == (sectionBannerList?.length ?? 0)) {
  //       nextPage = 0;
  //     }
  //     pageController
  //         .animateToPage(nextPage,
  //             duration: const Duration(seconds: 1), curve: Curves.linear)
  //         .then((_) => _animateSlider(sectionBannerList));
  //   });
  // }

  Widget homebanner(List<banner.Result>? sectionBannerList) {
    if ((sectionBannerList?.length ?? 0) > 0) {
      //_animateSlider(sectionBannerList);
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: Constant.homeBanner,
            child: PageView.builder(
              itemCount: (sectionBannerList?.length ?? 0),
              controller: pageController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    log("Clicked on index ==> $index");
                    if ((sectionBannerList?[index].videoType ?? 0) == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MovieDetails(
                              sectionBannerList?[index].id ?? 0,
                              sectionBannerList?[index].videoType ?? 0,
                              sectionBannerList?[index].typeId ?? 0,
                            );
                          },
                        ),
                      );
                    } else if ((sectionBannerList?[index].videoType ?? 0) ==
                        2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return TvShowDetails(
                              sectionBannerList?[index].id ?? 0,
                              sectionBannerList?[index].videoType ?? 0,
                              sectionBannerList?[index].typeId ?? 0,
                            );
                          },
                        ),
                      );
                    }
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: Constant.homeBanner,
                    child: MyNetworkImage(
                      imageUrl: sectionBannerList?[index].landscape ??
                          Constant.placeHolderLand,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 10,
            child: SmoothPageIndicator(
              controller: pageController,
              count: (sectionBannerList?.length ?? 0),
              axisDirection: Axis.horizontal,
              effect: const ExpandingDotsEffect(
                spacing: 4,
                radius: 4,
                dotWidth: 8,
                dotHeight: 8,
                dotColor: gray,
                activeDotColor: lightBlack,
              ),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget continueWatchingLayout(List<ContinueWatching>? continueWatchingList) {
    if ((continueWatchingList?.length ?? 0) > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: MyText(
              color: white,
              text: "continuewatching",
              multilanguage: true,
              textalign: TextAlign.center,
              fontsize: 16,
              maxline: 1,
              fontwaight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
              fontstyle: FontStyle.normal,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: Constant.heightContiLand,
            child: ListView.separated(
              itemCount: (continueWatchingList?.length ?? 0),
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 20, right: 20),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(
                width: 5,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(4),
                      onTap: () {
                        log("Clicked on index ==> $index");
                        if ((continueWatchingList?[index].videoType ?? 0) ==
                            1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MovieDetails(
                                  continueWatchingList?[index].id ?? 0,
                                  continueWatchingList?[index].videoType ?? 0,
                                  continueWatchingList?[index].typeId ?? 0,
                                );
                              },
                            ),
                          );
                        } else if ((continueWatchingList?[index].videoType ??
                                0) ==
                            2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return TvShowDetails(
                                  continueWatchingList?[index].id ?? 0,
                                  continueWatchingList?[index].videoType ?? 0,
                                  continueWatchingList?[index].typeId ?? 0,
                                );
                              },
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: Constant.widthContiLand,
                        height: Constant.heightContiLand,
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: MyNetworkImage(
                            imageUrl: continueWatchingList?[index].landscape ??
                                Constant.placeHolderLand,
                            fit: BoxFit.cover,
                            imgHeight: MediaQuery.of(context).size.height,
                            imgWidth: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 8),
                          child: MyImage(
                            width: 30,
                            height: 30,
                            imagePath: "play.png",
                          ),
                        ),
                        Container(
                          width: Constant.widthContiLand,
                          constraints: const BoxConstraints(minWidth: 0),
                          padding: const EdgeInsets.all(3),
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.all(0),
                            barRadius: const Radius.circular(2),
                            lineHeight: 4,
                            percent: Utils.getPercentage(
                                continueWatchingList?[index].videoDuration ?? 0,
                                continueWatchingList?[index].stopTime ?? 0),
                            backgroundColor: secProgressColor,
                            progressColor: primaryColor,
                          ),
                        ),
                        Visibility(
                          visible: (continueWatchingList![index].releaseTag !=
                                      null &&
                                  continueWatchingList[index]
                                      .releaseTag!
                                      .isEmpty)
                              ? false
                              : true,
                          child: Container(
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
                              multilanguage: false,
                              text:
                                  continueWatchingList[index].releaseTag ?? "",
                              textalign: TextAlign.center,
                              fontsize: 6,
                              maxline: 1,
                              fontwaight: FontWeight.normal,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget setSectionByType(List<list.Result>? sectionList) {
    return ListView.builder(
      itemCount: sectionList?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (sectionList?[index].data != null &&
            (sectionList?[index].data?.length ?? 0) > 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: MyText(
                  color: white,
                  text: sectionList?[index].title.toString() ?? "",
                  textalign: TextAlign.center,
                  fontsize: 16,
                  multilanguage: false,
                  maxline: 1,
                  fontwaight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  fontstyle: FontStyle.normal,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: getRemainingDataHeight(
                  sectionList?[index].videoType ?? "",
                  sectionList?[index].screenLayout ?? "",
                ),
                child: ListView.separated(
                  itemCount: (sectionList?[index].data?.length ?? 0),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 5,
                  ),
                  itemBuilder: (BuildContext context, int postion) {
                    /* video_type =>  1-video,  2-show,  3-language,  4-category */
                    /* screen_layout =>  landscape, potrait, square */
                    if ((sectionList?[index].videoType ?? "") == "1") {
                      if ((sectionList?[index].screenLayout ?? "") ==
                          "landscape") {
                        return landscape(sectionList?[index].data);
                      } else if ((sectionList?[index].screenLayout ?? "") ==
                          "potrait") {
                        return portrait(sectionList?[index].data);
                      } else if ((sectionList?[index].screenLayout ?? "") ==
                          "square") {
                        return square(sectionList?[index].data);
                      } else {
                        return landscape(sectionList?[index].data);
                      }
                    } else if ((sectionList?[index].videoType ?? "") == "2") {
                      if ((sectionList?[index].screenLayout ?? "") ==
                          "landscape") {
                        return landscape(sectionList?[index].data);
                      } else if ((sectionList?[index].screenLayout ?? "") ==
                          "potrait") {
                        return portrait(sectionList?[index].data);
                      } else if ((sectionList?[index].screenLayout ?? "") ==
                          "square") {
                        return square(sectionList?[index].data);
                      } else {
                        return landscape(sectionList?[index].data);
                      }
                    } else if ((sectionList?[index].videoType ?? "") == "3") {
                      return languageLayout(sectionList?[index].data);
                    } else if ((sectionList?[index].videoType ?? "") == "4") {
                      return genresLayout(sectionList?[index].data);
                    } else {
                      if ((sectionList?[index].screenLayout ?? "") ==
                          "landscape") {
                        return landscape(sectionList?[index].data);
                      } else if ((sectionList?[index].screenLayout ?? "") ==
                          "potrait") {
                        return portrait(sectionList?[index].data);
                      } else if ((sectionList?[index].screenLayout ?? "") ==
                          "square") {
                        return square(sectionList?[index].data);
                      } else {
                        return landscape(sectionList?[index].data);
                      }
                    }
                  },
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  double getRemainingDataHeight(String? videoType, String? layoutType) {
    if (videoType == "1" || videoType == "2") {
      if (layoutType == "landscape") {
        return Constant.heightLand;
      } else if (layoutType == "potrait") {
        return Constant.heightPort;
      } else if (layoutType == "square") {
        return Constant.heightSquare;
      } else {
        return Constant.heightLand;
      }
    } else if (videoType == "3" || videoType == "4") {
      return Constant.heightLangGen;
    } else {
      if (layoutType == "landscape") {
        return Constant.heightLand;
      } else if (layoutType == "potrait") {
        return Constant.heightPort;
      } else if (layoutType == "square") {
        return Constant.heightSquare;
      } else {
        return Constant.heightLand;
      }
    }
  }

  Widget landscape(List<Datum>? sectionDataList) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: Constant.heightLand,
      child: ListView.separated(
        itemCount: sectionDataList?.length ?? 0,
        shrinkWrap: true,
        physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.only(left: 20, right: 20),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(
          width: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              log("Clicked on index ==> $index");
              if ((sectionDataList?[index].videoType ?? 0) == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MovieDetails(
                        sectionDataList?[index].id ?? 0,
                        sectionDataList?[index].videoType ?? 0,
                        sectionDataList?[index].typeId ?? 0,
                      );
                    },
                  ),
                );
              } else if ((sectionDataList?[index].videoType ?? 0) == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TvShowDetails(
                        sectionDataList?[index].id ?? 0,
                        sectionDataList?[index].videoType ?? 0,
                        sectionDataList?[index].typeId ?? 0,
                      );
                    },
                  ),
                );
              }
            },
            child: Container(
              width: Constant.widthLand,
              height: Constant.heightLand,
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: MyNetworkImage(
                  imageUrl: sectionDataList?[index].landscape.toString() ??
                      Constant.placeHolderLand,
                  fit: BoxFit.cover,
                  imgHeight: MediaQuery.of(context).size.height,
                  imgWidth: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget portrait(List<Datum>? sectionDataList) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: Constant.heightPort,
      child: ListView.separated(
        itemCount: sectionDataList?.length ?? 0,
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 20, right: 20),
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
        separatorBuilder: (context, index) => const SizedBox(
          width: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              log("Clicked on index ==> $index");
              if ((sectionDataList?[index].videoType ?? 0) == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MovieDetails(
                        sectionDataList?[index].id ?? 0,
                        sectionDataList?[index].videoType ?? 0,
                        sectionDataList?[index].typeId ?? 0,
                      );
                    },
                  ),
                );
              } else if ((sectionDataList?[index].videoType ?? 0) == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TvShowDetails(
                        sectionDataList?[index].id ?? 0,
                        sectionDataList?[index].videoType ?? 0,
                        sectionDataList?[index].typeId ?? 0,
                      );
                    },
                  ),
                );
              }
            },
            child: Container(
              width: Constant.widthPort,
              height: Constant.heightPort,
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: MyNetworkImage(
                  imageUrl: sectionDataList?[index].thumbnail.toString() ??
                      Constant.placeHolderPort,
                  fit: BoxFit.cover,
                  imgHeight: MediaQuery.of(context).size.height,
                  imgWidth: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget square(List<Datum>? sectionDataList) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: Constant.heightSquare,
      child: ListView.separated(
        itemCount: sectionDataList?.length ?? 0,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.only(left: 20, right: 20),
        separatorBuilder: (context, index) => const SizedBox(
          width: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              log("Clicked on index ==> $index");
              if ((sectionDataList?[index].videoType ?? 0) == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MovieDetails(
                        sectionDataList?[index].id ?? 0,
                        sectionDataList?[index].videoType ?? 0,
                        sectionDataList?[index].typeId ?? 0,
                      );
                    },
                  ),
                );
              } else if ((sectionDataList?[index].videoType ?? 0) == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TvShowDetails(
                        sectionDataList?[index].id ?? 0,
                        sectionDataList?[index].videoType ?? 0,
                        sectionDataList?[index].typeId ?? 0,
                      );
                    },
                  ),
                );
              }
            },
            child: Container(
              width: Constant.widthSquare,
              height: Constant.heightSquare,
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: MyNetworkImage(
                  imageUrl: sectionDataList?[index].thumbnail.toString() ??
                      Constant.placeHolderLand,
                  fit: BoxFit.cover,
                  imgHeight: MediaQuery.of(context).size.height,
                  imgWidth: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget languageLayout(List<Datum>? sectionDataList) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: Constant.heightLangGen,
      child: ListView.separated(
        itemCount: sectionDataList?.length ?? 0,
        shrinkWrap: true,
        physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.only(left: 20, right: 20),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(
          width: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () {
                  log("Clicked on index ==> $index");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return VideosByID(
                          sectionDataList?[index].id ?? 0,
                          sectionDataList?[index].name ?? "",
                          "ByLanguage",
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  width: Constant.widthLangGen,
                  height: Constant.heightLangGen,
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: MyNetworkImage(
                      imageUrl: sectionDataList?[index].image.toString() ??
                          Constant.placeHolderLand,
                      fit: BoxFit.cover,
                      imgHeight: MediaQuery.of(context).size.height,
                      imgWidth: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3),
                child: MyText(
                  color: white,
                  text: sectionDataList?[index].name.toString() ?? "",
                  textalign: TextAlign.center,
                  fontsize: 14,
                  multilanguage: false,
                  maxline: 1,
                  fontwaight: FontWeight.normal,
                  overflow: TextOverflow.ellipsis,
                  fontstyle: FontStyle.normal,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget genresLayout(List<Datum>? sectionDataList) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: Constant.heightLangGen,
      child: ListView.separated(
        itemCount: sectionDataList?.length ?? 0,
        shrinkWrap: true,
        physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.only(left: 20, right: 20),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(
          width: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () {
                  log("Clicked on index ==> $index");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return VideosByID(
                          sectionDataList?[index].id ?? 0,
                          sectionDataList?[index].name ?? "",
                          "ByCategory",
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  width: Constant.widthLangGen,
                  height: Constant.heightLangGen,
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: MyNetworkImage(
                      imageUrl: sectionDataList?[index].image.toString() ??
                          Constant.placeHolderLand,
                      fit: BoxFit.cover,
                      imgHeight: MediaQuery.of(context).size.height,
                      imgWidth: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3),
                child: MyText(
                  color: white,
                  text: sectionDataList?[index].name.toString() ?? "",
                  textalign: TextAlign.center,
                  fontsize: 14,
                  multilanguage: false,
                  maxline: 1,
                  fontwaight: FontWeight.normal,
                  overflow: TextOverflow.ellipsis,
                  fontstyle: FontStyle.normal,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
