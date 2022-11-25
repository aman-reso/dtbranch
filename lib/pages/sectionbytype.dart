import 'dart:async';
import 'dart:developer';

import 'package:dtlive/model/sectionlistmodel.dart';
import 'package:dtlive/model/sectionlistmodel.dart' as list;
import 'package:dtlive/model/sectionbannermodel.dart' as banner;
import 'package:dtlive/pages/moviedetails.dart';
import 'package:dtlive/pages/nodata.dart';
import 'package:dtlive/pages/tvshowdetails.dart';
import 'package:dtlive/pages/videosbyid.dart';
import 'package:dtlive/provider/sectionbytypeprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SectionByType extends StatefulWidget {
  final String appBarTitle, isHomePage;
  final int typeId;
  const SectionByType(
    this.typeId,
    this.appBarTitle,
    this.isHomePage, {
    Key? key,
  }) : super(key: key);

  @override
  State<SectionByType> createState() => SectionByTypeState();
}

class SectionByTypeState extends State<SectionByType> {
  PageController pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    Utils.getCurrencySymbol();
    final sectionByTypeProvider =
        Provider.of<SectionByTypeProvider>(context, listen: false);
    await sectionByTypeProvider.getSectionBanner(
        widget.typeId.toString(), widget.isHomePage.toString());
    await sectionByTypeProvider.getSectionList(
        widget.typeId.toString(), widget.isHomePage.toString());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final sectionByTypeProvider =
        Provider.of<SectionByTypeProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: appBgColor,
        centerTitle: true,
        title: MyText(
          color: primaryColor,
          text: widget.appBarTitle,
          multilanguage: false,
          fontsize: 17,
          maxline: 1,
          overflow: TextOverflow.ellipsis,
          fontwaight: FontWeight.bold,
          textalign: TextAlign.center,
          fontstyle: FontStyle.normal,
        ),
      ),
      // Utils.myAppBar(context, widget.appBarTitle),
      body: sectionByTypeProvider.loading
          ? Utils.pageLoader()
          : (sectionByTypeProvider.sectionBannerModel.status == 200 ||
                  sectionByTypeProvider.sectionListModel.status == 200)
              ? SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      /* Banner */
                      (sectionByTypeProvider.sectionBannerModel.result != null)
                          ? homebanner(
                              sectionByTypeProvider.sectionBannerModel.result)
                          : const SizedBox.shrink(),
                      /* Remaining Data */
                      (sectionByTypeProvider.sectionListModel.status == 200 &&
                              sectionByTypeProvider.sectionListModel.result !=
                                  null)
                          ? setSectionByType(
                              sectionByTypeProvider.sectionListModel.result)
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              : const NoData(),
    );
  }

  Widget homebanner(List<banner.Result>? sectionBannerList) {
    if ((sectionBannerList?.length ?? 0) > 0) {
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   _timer = Timer.periodic(const Duration(seconds: 8), (Timer timer) {
      //     log("timer isActive ====> ${timer.isActive}");
      //     if (_currentPage < (sectionBannerList?.length ?? 0)) {
      //       _currentPage++;
      //     } else {
      //       _currentPage = 0;
      //     }
      //     if (pageController.hasClients) {
      //       pageController.animateToPage(
      //         _currentPage,
      //         duration: const Duration(milliseconds: 500),
      //         curve: Curves.easeIn,
      //       );
      //     }
      //   });
      // });
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
                    if ((sectionBannerList?.elementAt(index).videoType ?? 0) ==
                        1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MovieDetails(
                              sectionBannerList?.elementAt(index).id ?? 0,
                              sectionBannerList?.elementAt(index).videoType ??
                                  0,
                              sectionBannerList?.elementAt(index).typeId ?? 0,
                            );
                          },
                        ),
                      );
                    } else if ((sectionBannerList?.elementAt(index).videoType ??
                            0) ==
                        2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return TvShowDetails(
                              sectionBannerList?.elementAt(index).id ?? 0,
                              sectionBannerList?.elementAt(index).videoType ??
                                  0,
                              sectionBannerList?.elementAt(index).typeId ?? 0,
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
                      imageUrl: sectionBannerList?.elementAt(index).landscape ??
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

  Widget setSectionByType(List<list.Result>? sectionList) {
    return ListView.builder(
      itemCount: sectionList?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (sectionList?.elementAt(index).data != null &&
            (sectionList?.elementAt(index).data?.length ?? 0) > 0) {
          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 55,
                padding: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.bottomLeft,
                child: MyText(
                  color: white,
                  text: sectionList?.elementAt(index).title.toString() ?? "",
                  textalign: TextAlign.center,
                  multilanguage: false,
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
                height: getRemainingDataHeight(
                  sectionList?.elementAt(index).videoType ?? "",
                  sectionList?.elementAt(index).screenLayout ?? "",
                ),
                child: ListView.separated(
                  itemCount: (sectionList?.elementAt(index).data?.length ?? 0),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 5,
                  ),
                  itemBuilder: (BuildContext context, int postion) {
                    /* video_type =>  1-video,  2-show,  3-language,  4-category */
                    /* screen_layout =>  landscape, potrait, square */
                    if ((sectionList?.elementAt(index).videoType ?? "") ==
                        "1") {
                      if ((sectionList?.elementAt(index).screenLayout ?? "") ==
                          "landscape") {
                        return landscape(sectionList?.elementAt(index).data);
                      } else if ((sectionList?.elementAt(index).screenLayout ??
                              "") ==
                          "potrait") {
                        return portrait(sectionList?.elementAt(index).data);
                      } else if ((sectionList?.elementAt(index).screenLayout ??
                              "") ==
                          "square") {
                        return square(sectionList?.elementAt(index).data);
                      } else {
                        return landscape(sectionList?.elementAt(index).data);
                      }
                    } else if ((sectionList?.elementAt(index).videoType ??
                            "") ==
                        "2") {
                      if ((sectionList?.elementAt(index).screenLayout ?? "") ==
                          "landscape") {
                        return landscape(sectionList?.elementAt(index).data);
                      } else if ((sectionList?.elementAt(index).screenLayout ??
                              "") ==
                          "potrait") {
                        return portrait(sectionList?.elementAt(index).data);
                      } else if ((sectionList?.elementAt(index).screenLayout ??
                              "") ==
                          "square") {
                        return square(sectionList?.elementAt(index).data);
                      } else {
                        return landscape(sectionList?.elementAt(index).data);
                      }
                    } else if ((sectionList?.elementAt(index).videoType ??
                            "") ==
                        "3") {
                      return languageLayout(sectionList?.elementAt(index).data);
                    } else if ((sectionList?.elementAt(index).videoType ??
                            "") ==
                        "4") {
                      return genresLayout(sectionList?.elementAt(index).data);
                    } else {
                      if ((sectionList?.elementAt(index).screenLayout ?? "") ==
                          "landscape") {
                        return landscape(sectionList?.elementAt(index).data);
                      } else if ((sectionList?.elementAt(index).screenLayout ??
                              "") ==
                          "potrait") {
                        return portrait(sectionList?.elementAt(index).data);
                      } else if ((sectionList?.elementAt(index).screenLayout ??
                              "") ==
                          "square") {
                        return square(sectionList?.elementAt(index).data);
                      } else {
                        return landscape(sectionList?.elementAt(index).data);
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
              if ((sectionDataList?.elementAt(index).videoType ?? 0) == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MovieDetails(
                        sectionDataList?.elementAt(index).id ?? 0,
                        sectionDataList?.elementAt(index).videoType ?? 0,
                        sectionDataList?.elementAt(index).typeId ?? 0,
                      );
                    },
                  ),
                );
              } else if ((sectionDataList?.elementAt(index).videoType ?? 0) ==
                  2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TvShowDetails(
                        sectionDataList?.elementAt(index).id ?? 0,
                        sectionDataList?.elementAt(index).videoType ?? 0,
                        sectionDataList?.elementAt(index).typeId ?? 0,
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
                child: MyNetworkImage(
                  imageUrl:
                      sectionDataList?.elementAt(index).landscape.toString() ??
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
        separatorBuilder: (context, index) => const SizedBox(
          width: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              log("Clicked on index ==> $index");
              if ((sectionDataList?.elementAt(index).videoType ?? 0) == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MovieDetails(
                        sectionDataList?.elementAt(index).id ?? 0,
                        sectionDataList?.elementAt(index).videoType ?? 0,
                        sectionDataList?.elementAt(index).typeId ?? 0,
                      );
                    },
                  ),
                );
              } else if ((sectionDataList?.elementAt(index).videoType ?? 0) ==
                  2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TvShowDetails(
                        sectionDataList?.elementAt(index).id ?? 0,
                        sectionDataList?.elementAt(index).videoType ?? 0,
                        sectionDataList?.elementAt(index).typeId ?? 0,
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
                child: MyNetworkImage(
                  imageUrl:
                      sectionDataList?.elementAt(index).thumbnail.toString() ??
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
        padding: const EdgeInsets.only(left: 20, right: 20),
        separatorBuilder: (context, index) => const SizedBox(
          width: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              log("Clicked on index ==> $index");
              if ((sectionDataList?.elementAt(index).videoType ?? 0) == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MovieDetails(
                        sectionDataList?.elementAt(index).id ?? 0,
                        sectionDataList?.elementAt(index).videoType ?? 0,
                        sectionDataList?.elementAt(index).typeId ?? 0,
                      );
                    },
                  ),
                );
              } else if ((sectionDataList?.elementAt(index).videoType ?? 0) ==
                  2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TvShowDetails(
                        sectionDataList?.elementAt(index).id ?? 0,
                        sectionDataList?.elementAt(index).videoType ?? 0,
                        sectionDataList?.elementAt(index).typeId ?? 0,
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
                child: MyNetworkImage(
                  imageUrl:
                      sectionDataList?.elementAt(index).thumbnail.toString() ??
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
                          sectionDataList?.elementAt(index).id ?? 0,
                          sectionDataList?.elementAt(index).name ?? "",
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
                    child: MyNetworkImage(
                      imageUrl:
                          sectionDataList?.elementAt(index).image.toString() ??
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
                  text: sectionDataList?.elementAt(index).name.toString() ?? "",
                  textalign: TextAlign.center,
                  multilanguage: false,
                  fontsize: 14,
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
                          sectionDataList?.elementAt(index).id ?? 0,
                          sectionDataList?.elementAt(index).name ?? "",
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
                    child: MyNetworkImage(
                      imageUrl:
                          sectionDataList?.elementAt(index).image.toString() ??
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
                  text: sectionDataList?.elementAt(index).name.toString() ?? "",
                  textalign: TextAlign.center,
                  fontsize: 14,
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
