import 'dart:async';
import 'dart:developer';

import 'package:dtlive/model/channelsectionmodel.dart';
import 'package:dtlive/model/channelsectionmodel.dart' as list;
import 'package:dtlive/model/channelsectionmodel.dart' as banner;
import 'package:dtlive/pages/moviedetails.dart';
import 'package:dtlive/widget/nodata.dart';
import 'package:dtlive/pages/player.dart';
import 'package:dtlive/pages/tvshowdetails.dart';
import 'package:dtlive/pages/vimeoplayer.dart';
import 'package:dtlive/pages/youtubevideo.dart';
import 'package:dtlive/provider/channelsectionprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Channels extends StatefulWidget {
  const Channels({Key? key}) : super(key: key);

  @override
  State<Channels> createState() => ChannelsState();
}

class ChannelsState extends State<Channels> {
  Timer? _timer;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    final channelSectionProvider =
        Provider.of<ChannelSectionProvider>(context, listen: false);
    await channelSectionProvider.getChannelSection();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final channelSectionProvider =
        Provider.of<ChannelSectionProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: appBgColor,
      body: channelSectionProvider.loading
          ? Utils.pageLoader()
          : (channelSectionProvider.channelSectionModel.status == 200 &&
                  (channelSectionProvider.channelSectionModel.result != null ||
                      channelSectionProvider.channelSectionModel.liveUrl !=
                          null))
              ? SafeArea(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        /* Banner */
                        (channelSectionProvider.channelSectionModel.liveUrl !=
                                null)
                            ? channelbanner(channelSectionProvider
                                .channelSectionModel.liveUrl)
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: 20,
                        ),
                        /* Remaining Data */
                        (channelSectionProvider.channelSectionModel.result !=
                                null)
                            ? setSectionByType(channelSectionProvider
                                .channelSectionModel.result)
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                )
              : const NoData(
                  title: '',
                  subTitle: '',
                ),
    );
  }

  Widget channelbanner(List<banner.LiveUrl>? sectionBannerList) {
    if ((sectionBannerList?.length ?? 0) > 0) {
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   _timer = Timer.periodic(const Duration(seconds: 8), (Timer timer) {
      //     log("timer isActive ====> ${timer.isActive}");
      //     if (_currentPage < (sectionBannerList?.length ?? 0)) {
      //       _currentPage++;
      //     } else {
      //       _currentPage = 0;
      //     }
      //
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
            height: Constant.channelBanner,
            child: PageView.builder(
              itemCount: (sectionBannerList?.length ?? 0),
              controller: pageController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    log("Clicked on index ==> $index");
                    if ((sectionBannerList?[index].link ?? "").isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            if ((sectionBannerList?[index].link ?? "")
                                .contains("youtube")) {
                              return YoutubeVideo(
                                videoUrl: sectionBannerList?[index].link,
                              );
                            } else if ((sectionBannerList?[index].link ?? "")
                                .contains("vimeo")) {
                              return VimeoPlayerPage(
                                url: sectionBannerList?[index].link,
                              );
                            } else {
                              return PlayerPage(
                                MediaQuery.of(context).size.height,
                                0,
                                0,
                                0,
                                sectionBannerList?[index].link ?? "",
                                sectionBannerList?[index].name ?? "0",
                              );
                            }
                          },
                        ),
                      );
                    }
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: Constant.homeBanner,
                    child: MyNetworkImage(
                      imageUrl: sectionBannerList?[index].image ?? "",
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
    return ListView.separated(
      itemCount: sectionList?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      itemBuilder: (BuildContext context, int index) {
        if (sectionList?[index].data != null &&
            (sectionList?[index].data?.length ?? 0) > 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: MyText(
                  color: otherColor,
                  text: sectionList?[index].channelName.toString() ?? "",
                  textalign: TextAlign.center,
                  fontsize: 10,
                  multilanguage: false,
                  maxline: 1,
                  fontwaight: FontWeight.w700,
                  overflow: TextOverflow.ellipsis,
                  fontstyle: FontStyle.normal,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: MyText(
                  color: white,
                  text: sectionList?[index].title.toString() ?? "",
                  textalign: TextAlign.center,
                  fontsize: 16,
                  multilanguage: false,
                  maxline: 1,
                  fontwaight: FontWeight.bold,
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
                    /* video_type =>  1-video,  2-show */
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
        padding: const EdgeInsets.only(left: 20, right: 20),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(
          width: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
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
                        1,
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
                        4,
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: MyNetworkImage(
                  imageUrl: sectionDataList?[index].landscape.toString() ?? "",
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
                        1,
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
                        4,
                      );
                    },
                  ),
                );
              }
            },
            child: Container(
              width: Constant.widthPort,
              height: Constant.heightPort,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: MyNetworkImage(
                  imageUrl: sectionDataList?[index].thumbnail.toString() ?? "",
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
                        1,
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
                        4,
                      );
                    },
                  ),
                );
              }
            },
            child: Container(
              width: Constant.widthSquare,
              height: Constant.heightSquare,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: MyNetworkImage(
                  imageUrl: sectionDataList?[index].thumbnail.toString() ?? "",
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
}
