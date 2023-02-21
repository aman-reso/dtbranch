import 'dart:developer';
import 'dart:io';
import 'package:dtlive/provider/downloadprovider.dart';
import 'package:dtlive/webwidget/footerweb.dart';
import 'package:dtlive/webwidget/playerweb.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

import 'package:dtlive/model/sectiondetailmodel.dart';
import 'package:dtlive/pages/castdetails.dart';
import 'package:dtlive/pages/loginsocial.dart';
import 'package:dtlive/pages/subscription.dart';
import 'package:dtlive/utils/dimens.dart';
import 'package:dtlive/widget/nodata.dart';
import 'package:dtlive/pages/player.dart';
import 'package:dtlive/pages/vimeoplayer.dart';
import 'package:dtlive/pages/youtubevideo.dart';
import 'package:dtlive/provider/videodetailsprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:social_share/social_share.dart';

class MovieDetails extends StatefulWidget {
  final int videoId, videoType, typeId;
  const MovieDetails(this.videoId, this.videoType, this.typeId, {Key? key})
      : super(key: key);

  @override
  State<MovieDetails> createState() => MovieDetailsState();
}

class MovieDetailsState extends State<MovieDetails> {
  /* Download init */
  late bool _permissionReady;
  late DownloadProvider downloadProvider;

  String? audioLanguages;
  List<Cast>? directorList;
  late VideoDetailsProvider videoDetailsProvider;
  Map<String, String> qualityUrlList = <String, String>{};

  @override
  void initState() {
    videoDetailsProvider =
        Provider.of<VideoDetailsProvider>(context, listen: false);
    downloadProvider = Provider.of<DownloadProvider>(context, listen: false);
    super.initState();
    log("initState videoId ==> ${widget.videoId}");
    log("initState videoType ==> ${widget.videoType}");
    log("initState typeId ==> ${widget.typeId}");
    _getData();
  }

  void _getData() async {
    Utils.getCurrencySymbol();
    await videoDetailsProvider.getSectionDetails(
        widget.typeId, widget.videoType, widget.videoId);

    if (videoDetailsProvider.sectionDetailModel.status == 200) {
      if (videoDetailsProvider.sectionDetailModel.result != null) {
        qualityUrlList = <String, String>{
          '320p':
              videoDetailsProvider.sectionDetailModel.result?.video320 ?? '',
          '480p':
              videoDetailsProvider.sectionDetailModel.result?.video480 ?? '',
          '720p':
              videoDetailsProvider.sectionDetailModel.result?.video720 ?? '',
          '1080p':
              videoDetailsProvider.sectionDetailModel.result?.video1080 ?? '',
        };
        debugPrint("qualityUrlList ==========> ${qualityUrlList.length}");
        Constant.resolutionsUrls = qualityUrlList;
        debugPrint(
            "resolutionsUrls ==========> ${Constant.resolutionsUrls.length}");
      }
    }

    Future.delayed(const Duration(seconds: 1)).then((value) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    videoDetailsProvider.clearProvider();
  }

  @override
  Widget build(BuildContext context) {
    final videoDetailsProvider =
        Provider.of<VideoDetailsProvider>(context, listen: false);
    if (videoDetailsProvider.sectionDetailModel.status == 200) {
      if (videoDetailsProvider.sectionDetailModel.result != null) {
        if (videoDetailsProvider.sectionDetailModel.cast != null &&
            (videoDetailsProvider.sectionDetailModel.cast?.length ?? 0) > 0) {
          directorList = <Cast>[];
          for (int i = 0;
              i < (videoDetailsProvider.sectionDetailModel.cast?.length ?? 0);
              i++) {
            if (videoDetailsProvider.sectionDetailModel.cast?[i].type ==
                "Director") {
              Cast cast = Cast();
              cast.id =
                  videoDetailsProvider.sectionDetailModel.cast?[i].id ?? 0;
              cast.name =
                  videoDetailsProvider.sectionDetailModel.cast?[i].name ?? "";
              cast.image =
                  videoDetailsProvider.sectionDetailModel.cast?[i].image ?? "";
              cast.type =
                  videoDetailsProvider.sectionDetailModel.cast?[i].type ?? "";
              cast.personalInfo = videoDetailsProvider
                      .sectionDetailModel.cast?[i].personalInfo ??
                  "";
              cast.status =
                  videoDetailsProvider.sectionDetailModel.cast?[i].status ?? "";
              cast.createdAt =
                  videoDetailsProvider.sectionDetailModel.cast?[i].createdAt ??
                      "";
              cast.updatedAt =
                  videoDetailsProvider.sectionDetailModel.cast?[i].updatedAt ??
                      "";
              directorList?.add(cast);
              log("directorList size ===> ${directorList?.length ?? 0}");
            }
          }
        }
        if ((videoDetailsProvider.sectionDetailModel.language?.length ?? 0) >
            0) {
          for (int i = 0;
              i <
                  (videoDetailsProvider.sectionDetailModel.language?.length ??
                      0);
              i++) {
            if (i == 0) {
              audioLanguages =
                  videoDetailsProvider.sectionDetailModel.language?[i].name ??
                      "";
            } else {
              audioLanguages =
                  "$audioLanguages, ${videoDetailsProvider.sectionDetailModel.language?[i].name ?? ""}";
            }
          }
        }
      }
    }
    return Scaffold(
      key: widget.key,
      backgroundColor: appBgColor,
      body: SafeArea(
        child: (videoDetailsProvider.loading)
            ? Utils.pageLoader()
            : (videoDetailsProvider.sectionDetailModel.status == 200 &&
                    videoDetailsProvider.sectionDetailModel.result != null)
                ? SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: (kIsWeb && MediaQuery.of(context).size.width > 720)
                        ? _buildWebPoster()
                        : _buildMobilePoster(),
                  )
                : const NoData(
                    title: '',
                    subTitle: '',
                  ),
      ),
    );
  }

  Widget _buildMobilePoster() {
    return Column(
      children: [
        if (kIsWeb) SizedBox(height: Dimens.homeTabHeight),

        /* Poster */
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(0),
              width: MediaQuery.of(context).size.width,
              height: kIsWeb ? Dimens.detailWebPoster : Dimens.detailPoster,
              color: white,
              child: MyNetworkImage(
                fit: BoxFit.fill,
                imageUrl:
                    videoDetailsProvider.sectionDetailModel.result?.landscape !=
                            ""
                        ? (videoDetailsProvider
                                .sectionDetailModel.result?.landscape ??
                            "")
                        : (videoDetailsProvider
                                .sectionDetailModel.result?.thumbnail ??
                            ""),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(0),
              width: MediaQuery.of(context).size.width,
              height: kIsWeb ? Dimens.detailWebPoster : Dimens.detailPoster,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    transparentColor,
                    transparentColor,
                    appBgColor,
                  ],
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                openPlayer("Trailer");
              },
              child: MyImage(
                fit: BoxFit.fill,
                height: 60,
                width: 60,
                imagePath: "play_new.png",
              ),
            ),
          ],
        ),

        /* Other Details */
        Container(
          transform: Matrix4.translationValues(0, -kToolbarHeight, 0),
          child: Column(
            children: [
              /* Small Poster, Main title, ReleaseYear, Duration, Age Restriction, Video Quality */
              Container(
                width: MediaQuery.of(context).size.width,
                constraints: const BoxConstraints(minHeight: 85),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 65,
                      height: 85,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: MyNetworkImage(
                          fit: BoxFit.cover,
                          imgHeight: 85,
                          imgWidth: 65,
                          imageUrl: videoDetailsProvider
                                  .sectionDetailModel.result?.thumbnail ??
                              "",
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          MyText(
                            color: white,
                            text: videoDetailsProvider
                                    .sectionDetailModel.result?.name ??
                                "",
                            textalign: TextAlign.start,
                            fontsizeNormal: 24,
                            fontsizeWeb: 24,
                            fontweight: FontWeight.w800,
                            maxline: 2,
                            multilanguage: false,
                            overflow: TextOverflow.ellipsis,
                            fontstyle: FontStyle.normal,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              /* Release Year */
                              (videoDetailsProvider.sectionDetailModel.result
                                              ?.releaseYear !=
                                          null &&
                                      videoDetailsProvider.sectionDetailModel
                                              .result?.releaseYear !=
                                          "")
                                  ? Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      child: MyText(
                                        color: whiteLight,
                                        text: videoDetailsProvider
                                                .sectionDetailModel
                                                .result
                                                ?.releaseYear ??
                                            "",
                                        textalign: TextAlign.center,
                                        fontsizeNormal: 13,
                                        fontsizeWeb: 15,
                                        fontweight: FontWeight.w500,
                                        multilanguage: false,
                                        maxline: 1,
                                        overflow: TextOverflow.ellipsis,
                                        fontstyle: FontStyle.normal,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              /* Duration */
                              (videoDetailsProvider.sectionDetailModel.result
                                          ?.videoDuration !=
                                      null)
                                  ? Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      child: MyText(
                                        color: otherColor,
                                        multilanguage: false,
                                        text: ((videoDetailsProvider
                                                        .sectionDetailModel
                                                        .result
                                                        ?.videoDuration ??
                                                    0) >
                                                0)
                                            ? Utils.convertTimeToText(
                                                videoDetailsProvider
                                                        .sectionDetailModel
                                                        .result
                                                        ?.videoDuration ??
                                                    0)
                                            : "",
                                        textalign: TextAlign.center,
                                        fontsizeNormal: 13,
                                        fontsizeWeb: 15,
                                        fontweight: FontWeight.w500,
                                        maxline: 1,
                                        overflow: TextOverflow.ellipsis,
                                        fontstyle: FontStyle.normal,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              /* MaxQuality */
                              (videoDetailsProvider.sectionDetailModel.result
                                              ?.maxVideoQuality !=
                                          null &&
                                      videoDetailsProvider.sectionDetailModel
                                              .result?.maxVideoQuality !=
                                          "")
                                  ? Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 1, 5, 1),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: otherColor,
                                          width: .7,
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: MyText(
                                        color: otherColor,
                                        text: videoDetailsProvider
                                                .sectionDetailModel
                                                .result
                                                ?.maxVideoQuality ??
                                            "",
                                        textalign: TextAlign.center,
                                        fontsizeNormal: 10,
                                        fontsizeWeb: 12,
                                        fontweight: FontWeight.normal,
                                        multilanguage: false,
                                        maxline: 1,
                                        overflow: TextOverflow.ellipsis,
                                        fontstyle: FontStyle.normal,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /* Prime TAG */
              (videoDetailsProvider.sectionDetailModel.result?.isPremium ??
                          0) ==
                      1
                  ? Container(
                      margin: const EdgeInsets.only(top: 11),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          MyText(
                            color: primaryColor,
                            text: "primetag",
                            textalign: TextAlign.start,
                            fontsizeNormal: 16,
                            fontsizeWeb: 17,
                            fontweight: FontWeight.w700,
                            multilanguage: true,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            fontstyle: FontStyle.normal,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          MyText(
                            color: white,
                            text: "primetagdesc",
                            multilanguage: true,
                            textalign: TextAlign.center,
                            fontsizeNormal: 12,
                            fontsizeWeb: 14,
                            fontweight: FontWeight.w400,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            fontstyle: FontStyle.normal,
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),

              /* Rent TAG */
              (videoDetailsProvider.sectionDetailModel.result?.isRent ?? 0) == 1
                  ? Container(
                      margin: const EdgeInsets.only(top: 8),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: complimentryColor,
                              borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.rectangle,
                            ),
                            alignment: Alignment.center,
                            child: MyText(
                              color: white,
                              text: Constant.currencySymbol,
                              textalign: TextAlign.center,
                              fontsizeNormal: 11,
                              fontsizeWeb: 13,
                              fontweight: FontWeight.w800,
                              multilanguage: false,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: MyText(
                              color: white,
                              text: "renttag",
                              textalign: TextAlign.center,
                              fontsizeNormal: 12,
                              fontsizeWeb: 13,
                              multilanguage: true,
                              fontweight: FontWeight.normal,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),

              /* Continue Watching Button */
              /* Watch Now button */
              if (!kIsWeb) _buildPlayWithSubsCheck(),

              /* Included Features buttons */
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: kIsWeb
                      ? (MediaQuery.of(context).size.width / 2)
                      : MediaQuery.of(context).size.width,
                  constraints: const BoxConstraints(minHeight: 0),
                  margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Consumer<VideoDetailsProvider>(
                          builder: (context, videoDetailsProvider, child) {
                            if ((videoDetailsProvider.sectionDetailModel.result
                                            ?.stopTime ??
                                        0) >
                                    0 &&
                                videoDetailsProvider.sectionDetailModel.result
                                        ?.videoDuration !=
                                    null) {
                              /* Start Over */
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(
                                        Dimens.featureSize / 2),
                                    onTap: () async {
                                      if (Constant.userID != null) {
                                        openPlayer("startOver");
                                      } else {
                                        if (kIsWeb) {
                                          Utils.buildWebAlertDialog(
                                              context, "login", "");
                                          return;
                                        }
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
                                      width: Dimens.featureSize,
                                      height: Dimens.featureSize,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: primaryLight,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            Dimens.featureSize / 2),
                                      ),
                                      child: MyImage(
                                        width: Dimens.featureIconSize,
                                        height: Dimens.featureIconSize,
                                        color: lightGray,
                                        imagePath: "ic_restart.png",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  MyText(
                                    color: white,
                                    text: "startover",
                                    multilanguage: true,
                                    fontsizeNormal: 12,
                                    fontsizeWeb: 14,
                                    fontweight: FontWeight.w500,
                                    maxline: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textalign: TextAlign.center,
                                    fontstyle: FontStyle.normal,
                                  ),
                                ],
                              );
                            } else {
                              /* Trailer */
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(
                                        Dimens.featureSize / 2),
                                    onTap: () {
                                      openPlayer("Trailer");
                                    },
                                    child: Container(
                                      width: Dimens.featureSize,
                                      height: Dimens.featureSize,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: primaryLight,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            Dimens.featureSize / 2),
                                      ),
                                      child: MyImage(
                                        width: Dimens.featureIconSize,
                                        height: Dimens.featureIconSize,
                                        color: lightGray,
                                        imagePath: "ic_borderplay.png",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  MyText(
                                    color: white,
                                    text: "trailer",
                                    fontsizeNormal: 12,
                                    fontsizeWeb: 14,
                                    fontweight: FontWeight.w500,
                                    multilanguage: true,
                                    maxline: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textalign: TextAlign.center,
                                    fontstyle: FontStyle.normal,
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),

                      /* Rent Button */
                      _buildRentBtn(),

                      /* Download */
                      if (!kIsWeb) _buildDownloadWithSubCheck(),

                      /* Watchlist */
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                log("isBookmark ====> ${videoDetailsProvider.sectionDetailModel.result?.isBookmark ?? 0}");
                                if (Constant.userID != null) {
                                  await videoDetailsProvider.setBookMark(
                                    context,
                                    widget.typeId,
                                    widget.videoType,
                                    widget.videoId,
                                  );
                                } else {
                                  if (kIsWeb) {
                                    Utils.buildWebAlertDialog(
                                        context, "login", "");
                                    return;
                                  }
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
                              borderRadius:
                                  BorderRadius.circular(Dimens.featureSize / 2),
                              child: Container(
                                width: Dimens.featureSize,
                                height: Dimens.featureSize,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: primaryLight,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      Dimens.featureSize / 2),
                                ),
                                child: Consumer<VideoDetailsProvider>(
                                  builder:
                                      (context, videoDetailsProvider, child) {
                                    return MyImage(
                                      width: Dimens.featureIconSize,
                                      height: Dimens.featureIconSize,
                                      color: lightGray,
                                      imagePath: (videoDetailsProvider
                                                      .sectionDetailModel
                                                      .result
                                                      ?.isBookmark ??
                                                  0) ==
                                              1
                                          ? "watchlist_remove.png"
                                          : "ic_plus.png",
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            MyText(
                              color: white,
                              text: "watchlist",
                              fontsizeNormal: 12,
                              fontsizeWeb: 14,
                              fontweight: FontWeight.w500,
                              multilanguage: true,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              textalign: TextAlign.center,
                              fontstyle: FontStyle.normal,
                            ),
                          ],
                        ),
                      ),

                      /* More */
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              borderRadius:
                                  BorderRadius.circular(Dimens.featureSize / 2),
                              onTap: () {
                                buildMoreDialog(videoDetailsProvider
                                        .sectionDetailModel.result?.stopTime ??
                                    0);
                              },
                              child: Container(
                                width: Dimens.featureSize,
                                height: Dimens.featureSize,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: primaryLight,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      Dimens.featureSize / 2),
                                ),
                                child: MyImage(
                                  width: Dimens.featureIconSize,
                                  height: Dimens.featureIconSize,
                                  color: lightGray,
                                  imagePath: "ic_more.png",
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            MyText(
                              color: white,
                              multilanguage: true,
                              text: "more",
                              fontsizeNormal: 12,
                              fontsizeWeb: 14,
                              fontweight: FontWeight.w500,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              textalign: TextAlign.center,
                              fontstyle: FontStyle.normal,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /* Description, IMDb, Languages & Subtitles */
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      constraints: const BoxConstraints(minHeight: 0),
                      alignment: Alignment.centerLeft,
                      child: ExpandableText(
                        videoDetailsProvider
                                .sectionDetailModel.result?.description ??
                            "",
                        expandText: more,
                        collapseText: less_,
                        maxLines: kIsWeb ? 50 : 3,
                        linkColor: otherColor,
                        style: const TextStyle(
                          fontSize: kIsWeb ? 13 : 14,
                          fontStyle: FontStyle.normal,
                          color: otherColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        MyImage(
                          width: 50,
                          height: 23,
                          imagePath: "imdb.png",
                        ),
                        const SizedBox(width: 5),
                        MyText(
                          color: otherColor,
                          text:
                              "${videoDetailsProvider.sectionDetailModel.result?.imdbRating ?? 0}",
                          textalign: TextAlign.start,
                          fontsizeNormal: 14,
                          fontsizeWeb: 16,
                          fontweight: FontWeight.w600,
                          multilanguage: false,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontstyle: FontStyle.normal,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      constraints: const BoxConstraints(minHeight: 30),
                      child: Row(
                        children: [
                          MyText(
                            color: white,
                            text: "language_",
                            textalign: TextAlign.center,
                            fontsizeNormal: 14,
                            fontweight: FontWeight.w600,
                            fontsizeWeb: 15,
                            maxline: 1,
                            multilanguage: true,
                            overflow: TextOverflow.ellipsis,
                            fontstyle: FontStyle.normal,
                          ),
                          const SizedBox(width: 5),
                          MyText(
                            color: white,
                            text: ":",
                            textalign: TextAlign.center,
                            fontsizeNormal: 14,
                            fontweight: FontWeight.w500,
                            fontsizeWeb: 15,
                            maxline: 1,
                            multilanguage: false,
                            overflow: TextOverflow.ellipsis,
                            fontstyle: FontStyle.normal,
                          ),
                          const SizedBox(width: 5),
                          MyText(
                            color: white,
                            text: audioLanguages ?? "",
                            textalign: TextAlign.center,
                            fontsizeNormal: 13,
                            fontweight: FontWeight.w500,
                            fontsizeWeb: 14,
                            multilanguage: false,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            fontstyle: FontStyle.normal,
                          ),
                        ],
                      ),
                    ),
                    (videoDetailsProvider.sectionDetailModel.result?.subtitle ??
                                "")
                            .isNotEmpty
                        ? Container(
                            constraints: const BoxConstraints(minHeight: 30),
                            child: Row(
                              children: [
                                MyText(
                                  color: white,
                                  text: "subtitle",
                                  textalign: TextAlign.center,
                                  fontsizeNormal: 14,
                                  fontweight: FontWeight.w500,
                                  fontsizeWeb: 15,
                                  maxline: 1,
                                  multilanguage: true,
                                  overflow: TextOverflow.ellipsis,
                                  fontstyle: FontStyle.normal,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                MyText(
                                  color: white,
                                  text: ":",
                                  textalign: TextAlign.center,
                                  fontsizeNormal: 14,
                                  fontweight: FontWeight.w500,
                                  fontsizeWeb: 15,
                                  maxline: 1,
                                  multilanguage: false,
                                  overflow: TextOverflow.ellipsis,
                                  fontstyle: FontStyle.normal,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                MyText(
                                  color: white,
                                  text: "Available",
                                  textalign: TextAlign.center,
                                  fontsizeNormal: 13,
                                  fontweight: FontWeight.w500,
                                  fontsizeWeb: 14,
                                  maxline: 1,
                                  multilanguage: false,
                                  overflow: TextOverflow.ellipsis,
                                  fontstyle: FontStyle.normal,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),

              /* Related ~ More Details */
              Consumer<VideoDetailsProvider>(
                builder: (context, videoDetailsProvider, child) {
                  return _buildTabs();
                },
              ),
              const SizedBox(height: 20),

              /* Web Footer */
              kIsWeb ? const FooterWeb() : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWebPoster() {
    return Column(
      children: [
        if (kIsWeb) SizedBox(height: Dimens.homeTabHeight),

        /* Poster */
        ClipRRect(
          borderRadius: BorderRadius.circular(0),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              /* Poster */
              Container(
                padding: const EdgeInsets.all(0),
                width:
                    MediaQuery.of(context).size.width * (Dimens.webBannerImgPr),
                height: Dimens.detailWebPoster,
                child: Stack(
                  children: [
                    MyNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: videoDetailsProvider
                                  .sectionDetailModel.result?.landscape !=
                              ""
                          ? (videoDetailsProvider
                                  .sectionDetailModel.result?.landscape ??
                              "")
                          : (videoDetailsProvider
                                  .sectionDetailModel.result?.thumbnail ??
                              ""),
                    ),
                    Container(
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      height: Dimens.detailWebPoster,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          colors: [
                            transparentColor,
                            transparentColor,
                            appBgColor,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /* Gradient */
              Container(
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: Dimens.detailWebPoster,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      appBgColor,
                      appBgColor,
                      appBgColor,
                      appBgColor,
                      transparentColor,
                      transparentColor,
                      transparentColor,
                      transparentColor,
                    ],
                  ),
                ),
              ),

              /* Details */
              Container(
                width: MediaQuery.of(context).size.width,
                height: Dimens.detailWebPoster + 30,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /* Small Poster, Main title, ReleaseYear, Duration, Age Restriction, Video Quality */
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                constraints: const BoxConstraints(minHeight: 0),
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    MyText(
                                      color: white,
                                      text: videoDetailsProvider
                                              .sectionDetailModel
                                              .result
                                              ?.name ??
                                          "",
                                      textalign: TextAlign.start,
                                      fontsizeNormal: 24,
                                      fontsizeWeb: 24,
                                      fontweight: FontWeight.w800,
                                      maxline: 2,
                                      multilanguage: false,
                                      overflow: TextOverflow.ellipsis,
                                      fontstyle: FontStyle.normal,
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        /* Release Year */
                                        (videoDetailsProvider.sectionDetailModel
                                                        .result?.releaseYear !=
                                                    null &&
                                                videoDetailsProvider
                                                        .sectionDetailModel
                                                        .result
                                                        ?.releaseYear !=
                                                    "")
                                            ? Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                child: MyText(
                                                  color: whiteLight,
                                                  text: videoDetailsProvider
                                                          .sectionDetailModel
                                                          .result
                                                          ?.releaseYear ??
                                                      "",
                                                  textalign: TextAlign.center,
                                                  fontsizeNormal: 13,
                                                  fontsizeWeb: 13,
                                                  fontweight: FontWeight.w500,
                                                  multilanguage: false,
                                                  maxline: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontstyle: FontStyle.normal,
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                        /* Duration */
                                        (videoDetailsProvider.sectionDetailModel
                                                    .result?.videoDuration !=
                                                null)
                                            ? Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                child: MyText(
                                                  color: otherColor,
                                                  multilanguage: false,
                                                  text: ((videoDetailsProvider
                                                                  .sectionDetailModel
                                                                  .result
                                                                  ?.videoDuration ??
                                                              0) >
                                                          0)
                                                      ? Utils.convertTimeToText(
                                                          videoDetailsProvider
                                                                  .sectionDetailModel
                                                                  .result
                                                                  ?.videoDuration ??
                                                              0)
                                                      : "",
                                                  textalign: TextAlign.center,
                                                  fontsizeNormal: 13,
                                                  fontsizeWeb: 13,
                                                  fontweight: FontWeight.w500,
                                                  maxline: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontstyle: FontStyle.normal,
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                        /* MaxQuality */
                                        (videoDetailsProvider
                                                        .sectionDetailModel
                                                        .result
                                                        ?.maxVideoQuality !=
                                                    null &&
                                                videoDetailsProvider
                                                        .sectionDetailModel
                                                        .result
                                                        ?.maxVideoQuality !=
                                                    "")
                                            ? Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 1, 5, 1),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: otherColor,
                                                    width: .7,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: MyText(
                                                  color: otherColor,
                                                  text: videoDetailsProvider
                                                          .sectionDetailModel
                                                          .result
                                                          ?.maxVideoQuality ??
                                                      "",
                                                  textalign: TextAlign.center,
                                                  fontsizeNormal: 10,
                                                  fontsizeWeb: 12,
                                                  fontweight: FontWeight.normal,
                                                  multilanguage: false,
                                                  maxline: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontstyle: FontStyle.normal,
                                                ),
                                              )
                                            : const SizedBox.shrink(),

                                        /* IMDb */
                                        MyImage(
                                          width: 40,
                                          height: 15,
                                          imagePath: "imdb.png",
                                        ),
                                        MyText(
                                          color: otherColor,
                                          text:
                                              "${videoDetailsProvider.sectionDetailModel.result?.imdbRating ?? 0}",
                                          textalign: TextAlign.start,
                                          fontsizeNormal: 14,
                                          fontsizeWeb: 14,
                                          fontweight: FontWeight.w600,
                                          multilanguage: false,
                                          maxline: 1,
                                          overflow: TextOverflow.ellipsis,
                                          fontstyle: FontStyle.normal,
                                        ),
                                        /* IMDb */
                                      ],
                                    ),

                                    /* Prime TAG */
                                    (videoDetailsProvider.sectionDetailModel
                                                    .result?.isPremium ??
                                                0) ==
                                            1
                                        ? Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                MyText(
                                                  color: primaryColor,
                                                  text: "primetag",
                                                  textalign: TextAlign.start,
                                                  fontsizeNormal: 12,
                                                  fontsizeWeb: 12,
                                                  fontweight: FontWeight.w700,
                                                  multilanguage: true,
                                                  maxline: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontstyle: FontStyle.normal,
                                                ),
                                                const SizedBox(height: 2),
                                                MyText(
                                                  color: white,
                                                  text: "primetagdesc",
                                                  multilanguage: true,
                                                  textalign: TextAlign.center,
                                                  fontsizeNormal: 12,
                                                  fontsizeWeb: 12,
                                                  fontweight: FontWeight.w400,
                                                  maxline: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontstyle: FontStyle.normal,
                                                ),
                                              ],
                                            ),
                                          )
                                        : const SizedBox.shrink(),

                                    /* Rent TAG */
                                    (videoDetailsProvider.sectionDetailModel
                                                    .result?.isRent ??
                                                0) ==
                                            1
                                        ? Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 18,
                                                  height: 18,
                                                  decoration: BoxDecoration(
                                                    color: complimentryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: MyText(
                                                    color: white,
                                                    text:
                                                        Constant.currencySymbol,
                                                    textalign: TextAlign.center,
                                                    fontsizeNormal: 11,
                                                    fontsizeWeb: 11,
                                                    fontweight: FontWeight.w700,
                                                    multilanguage: false,
                                                    maxline: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontstyle: FontStyle.normal,
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5),
                                                  child: MyText(
                                                    color: white,
                                                    text: "renttag",
                                                    textalign: TextAlign.center,
                                                    fontsizeNormal: 12,
                                                    fontsizeWeb: 13,
                                                    multilanguage: true,
                                                    fontweight:
                                                        FontWeight.normal,
                                                    maxline: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontstyle: FontStyle.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const SizedBox.shrink(),

                                    /* Description, Languages & Subtitles */
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.only(top: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            constraints: const BoxConstraints(
                                                minHeight: 0),
                                            alignment: Alignment.centerLeft,
                                            child: ExpandableText(
                                              videoDetailsProvider
                                                      .sectionDetailModel
                                                      .result
                                                      ?.description ??
                                                  "",
                                              expandText: more,
                                              collapseText: less_,
                                              maxLines: kIsWeb ? 3 : 3,
                                              linkColor: primaryColor,
                                              style: const TextStyle(
                                                fontSize: kIsWeb ? 12 : 13,
                                                fontStyle: FontStyle.normal,
                                                color: white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Container(
                                            constraints: const BoxConstraints(
                                                minHeight: 0),
                                            child: Row(
                                              children: [
                                                MyText(
                                                  color: white,
                                                  text: "language_",
                                                  textalign: TextAlign.center,
                                                  fontsizeNormal: 14,
                                                  fontweight: FontWeight.w500,
                                                  fontsizeWeb: 14,
                                                  maxline: 1,
                                                  multilanguage: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontstyle: FontStyle.normal,
                                                ),
                                                const SizedBox(width: 5),
                                                MyText(
                                                  color: white,
                                                  text: ":",
                                                  textalign: TextAlign.center,
                                                  fontsizeNormal: 14,
                                                  fontweight: FontWeight.w500,
                                                  fontsizeWeb: 14,
                                                  maxline: 1,
                                                  multilanguage: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontstyle: FontStyle.normal,
                                                ),
                                                const SizedBox(width: 5),
                                                MyText(
                                                  color: white,
                                                  text: audioLanguages ?? "",
                                                  textalign: TextAlign.center,
                                                  fontsizeNormal: 13,
                                                  fontweight: FontWeight.w500,
                                                  fontsizeWeb: 13,
                                                  multilanguage: false,
                                                  maxline: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontstyle: FontStyle.normal,
                                                ),
                                              ],
                                            ),
                                          ),
                                          (videoDetailsProvider
                                                          .sectionDetailModel
                                                          .result
                                                          ?.subtitle ??
                                                      "")
                                                  .isNotEmpty
                                              ? Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                          minHeight: 0),
                                                  margin: const EdgeInsets.only(
                                                      top: 8),
                                                  child: Row(
                                                    children: [
                                                      MyText(
                                                        color: white,
                                                        text: "subtitle",
                                                        textalign:
                                                            TextAlign.center,
                                                        fontsizeNormal: 14,
                                                        fontweight:
                                                            FontWeight.w500,
                                                        fontsizeWeb: 14,
                                                        maxline: 1,
                                                        multilanguage: true,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontstyle:
                                                            FontStyle.normal,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      MyText(
                                                        color: white,
                                                        text: ":",
                                                        textalign:
                                                            TextAlign.center,
                                                        fontsizeNormal: 14,
                                                        fontweight:
                                                            FontWeight.w500,
                                                        fontsizeWeb: 14,
                                                        maxline: 1,
                                                        multilanguage: false,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontstyle:
                                                            FontStyle.normal,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      MyText(
                                                        color: white,
                                                        text: "Available",
                                                        textalign:
                                                            TextAlign.center,
                                                        fontsizeNormal: 13,
                                                        fontweight:
                                                            FontWeight.w500,
                                                        fontsizeWeb: 13,
                                                        maxline: 1,
                                                        multilanguage: false,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontstyle:
                                                            FontStyle.normal,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /* Continue Watching Button */
                            /* Watch Now button */
                            if ((videoDetailsProvider.sectionDetailModel.result
                                            ?.stopTime ??
                                        0) >
                                    0 &&
                                videoDetailsProvider.sectionDetailModel.result
                                        ?.videoDuration !=
                                    null)
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(20, 18, 20, 0),
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  onTap: () async {
                                    if (Constant.userID != null) {
                                      if ((videoDetailsProvider
                                                      .sectionDetailModel
                                                      .result
                                                      ?.isBuy ??
                                                  0) ==
                                              1 ||
                                          (videoDetailsProvider
                                                      .sectionDetailModel
                                                      .result
                                                      ?.rentBuy ??
                                                  0) ==
                                              1) {
                                        openPlayer("Video");
                                      } else {
                                        dynamic isRented =
                                            await Utils.paymentForRent(
                                          context: context,
                                          videoId: videoDetailsProvider
                                                  .sectionDetailModel.result?.id
                                                  .toString() ??
                                              '',
                                          rentPrice: videoDetailsProvider
                                                  .sectionDetailModel
                                                  .result
                                                  ?.rentPrice
                                                  .toString() ??
                                              '',
                                          vTitle: videoDetailsProvider
                                                  .sectionDetailModel
                                                  .result
                                                  ?.name
                                                  .toString() ??
                                              '',
                                          typeId: videoDetailsProvider
                                                  .sectionDetailModel
                                                  .result
                                                  ?.typeId
                                                  .toString() ??
                                              '',
                                          vType: videoDetailsProvider
                                                  .sectionDetailModel
                                                  .result
                                                  ?.videoType
                                                  .toString() ??
                                              '',
                                        );
                                        if (isRented != null &&
                                            isRented == true) {
                                          _getData();
                                        }
                                      }
                                    } else {
                                      if (kIsWeb) {
                                        Utils.buildWebAlertDialog(
                                            context, "login", "");
                                        return;
                                      }
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
                                  borderRadius: BorderRadius.circular(4),
                                  child: Container(
                                    height: 35,
                                    constraints:
                                        const BoxConstraints(minWidth: 170),
                                    decoration: BoxDecoration(
                                      color: primaryDark,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(width: 20),
                                              MyImage(
                                                width: 18,
                                                height: 18,
                                                imagePath: "ic_play.png",
                                              ),
                                              const SizedBox(width: 12),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  MyText(
                                                    color: white,
                                                    text: "continuewatching",
                                                    multilanguage: true,
                                                    textalign: TextAlign.start,
                                                    fontsizeNormal: 14,
                                                    fontweight: FontWeight.w600,
                                                    fontsizeWeb: 13,
                                                    maxline: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontstyle: FontStyle.normal,
                                                  ),
                                                  Row(
                                                    children: [
                                                      MyText(
                                                        color: white,
                                                        text: Utils.remainTimeInMin(((videoDetailsProvider
                                                                        .sectionDetailModel
                                                                        .result
                                                                        ?.videoDuration ??
                                                                    0) -
                                                                (videoDetailsProvider
                                                                        .sectionDetailModel
                                                                        .result
                                                                        ?.stopTime ??
                                                                    0))
                                                            .abs()),
                                                        textalign:
                                                            TextAlign.start,
                                                        fontsizeNormal: 10,
                                                        fontsizeWeb: 11,
                                                        multilanguage: false,
                                                        fontweight:
                                                            FontWeight.normal,
                                                        maxline: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontstyle:
                                                            FontStyle.normal,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      MyText(
                                                        color: white,
                                                        text: "left",
                                                        textalign:
                                                            TextAlign.start,
                                                        fontsizeNormal: 10,
                                                        fontsizeWeb: 11,
                                                        fontweight:
                                                            FontWeight.w600,
                                                        multilanguage: true,
                                                        maxline: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontstyle:
                                                            FontStyle.normal,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 20),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 4,
                                          constraints:
                                              const BoxConstraints(minWidth: 0),
                                          margin: const EdgeInsets.all(3),
                                          child: LinearPercentIndicator(
                                            padding: const EdgeInsets.all(0),
                                            barRadius: const Radius.circular(2),
                                            lineHeight: 4,
                                            percent: Utils.getPercentage(
                                                videoDetailsProvider
                                                        .sectionDetailModel
                                                        .result
                                                        ?.videoDuration ??
                                                    0,
                                                videoDetailsProvider
                                                        .sectionDetailModel
                                                        .result
                                                        ?.stopTime ??
                                                    0),
                                            backgroundColor: secProgressColor,
                                            progressColor: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            else
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(20, 18, 20, 0),
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  onTap: () {
                                    if (Constant.userID != null) {
                                      openPlayer("Video");
                                    } else {
                                      if (kIsWeb) {
                                        Utils.buildWebAlertDialog(
                                            context, "login", "");
                                        return;
                                      }
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
                                  borderRadius: BorderRadius.circular(4),
                                  child: Container(
                                    height: 35,
                                    constraints:
                                        const BoxConstraints(maxWidth: 150),
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    decoration: BoxDecoration(
                                      color: primaryDark,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        MyImage(
                                          width: 18,
                                          height: 18,
                                          imagePath: "ic_play.png",
                                        ),
                                        const SizedBox(width: 12),
                                        MyText(
                                          color: white,
                                          text: "watch_now",
                                          multilanguage: true,
                                          textalign: TextAlign.start,
                                          fontsizeNormal: 14,
                                          fontweight: FontWeight.w600,
                                          fontsizeWeb: 13,
                                          maxline: 1,
                                          overflow: TextOverflow.ellipsis,
                                          fontstyle: FontStyle.normal,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            /* Included Features buttons */
                            Container(
                              width: MediaQuery.of(context).size.width,
                              constraints: const BoxConstraints(minHeight: 0),
                              margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  /* Trailer & StartOver Button */
                                  Container(
                                    constraints:
                                        const BoxConstraints(minWidth: 50),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Consumer<VideoDetailsProvider>(
                                      builder: (context, videoDetailsProvider,
                                          child) {
                                        if ((videoDetailsProvider
                                                        .sectionDetailModel
                                                        .result
                                                        ?.stopTime ??
                                                    0) >
                                                0 &&
                                            videoDetailsProvider
                                                    .sectionDetailModel
                                                    .result
                                                    ?.videoDuration !=
                                                null) {
                                          /* Start Over */
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimens.featureSize / 2),
                                                onTap: () async {
                                                  if (Constant.userID != null) {
                                                    openPlayer("startOver");
                                                  } else {
                                                    if (kIsWeb) {
                                                      Utils.buildWebAlertDialog(
                                                          context, "login", "");
                                                      return;
                                                    }
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
                                                  width: Dimens.featureWebSize,
                                                  height: Dimens.featureWebSize,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: primaryLight,
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .circular(Dimens
                                                                .featureWebSize /
                                                            2),
                                                  ),
                                                  child: MyImage(
                                                    width: Dimens
                                                        .featureIconWebSize,
                                                    height: Dimens
                                                        .featureIconWebSize,
                                                    color: lightGray,
                                                    imagePath: "ic_restart.png",
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              MyText(
                                                color: white,
                                                text: "startover",
                                                multilanguage: true,
                                                fontsizeNormal: 12,
                                                fontsizeWeb: 12,
                                                fontweight: FontWeight.w500,
                                                maxline: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textalign: TextAlign.center,
                                                fontstyle: FontStyle.normal,
                                              ),
                                            ],
                                          );
                                        } else {
                                          /* Trailer */
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimens.featureSize / 2),
                                                onTap: () {
                                                  openPlayer("Trailer");
                                                },
                                                child: Container(
                                                  width: Dimens.featureWebSize,
                                                  height: Dimens.featureWebSize,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: primaryLight,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimens.featureSize /
                                                                2),
                                                  ),
                                                  child: MyImage(
                                                    width: Dimens
                                                        .featureIconWebSize,
                                                    height: Dimens
                                                        .featureIconWebSize,
                                                    color: lightGray,
                                                    imagePath:
                                                        "ic_borderplay.png",
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              MyText(
                                                color: white,
                                                text: "trailer",
                                                fontsizeNormal: 12,
                                                fontsizeWeb: 12,
                                                fontweight: FontWeight.w500,
                                                multilanguage: true,
                                                maxline: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textalign: TextAlign.center,
                                                fontstyle: FontStyle.normal,
                                              ),
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  ),

                                  /* Rent Button */
                                  Container(
                                    constraints:
                                        const BoxConstraints(minWidth: 50),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          borderRadius: BorderRadius.circular(
                                              Dimens.featureWebSize / 2),
                                          onTap: () async {
                                            if (Constant.userID != null) {
                                              dynamic isRented =
                                                  await Utils.paymentForRent(
                                                context: context,
                                                videoId: videoDetailsProvider
                                                        .sectionDetailModel
                                                        .result
                                                        ?.id
                                                        .toString() ??
                                                    '',
                                                rentPrice: videoDetailsProvider
                                                        .sectionDetailModel
                                                        .result
                                                        ?.rentPrice
                                                        .toString() ??
                                                    '',
                                                vTitle: videoDetailsProvider
                                                        .sectionDetailModel
                                                        .result
                                                        ?.name
                                                        .toString() ??
                                                    '',
                                                typeId: videoDetailsProvider
                                                        .sectionDetailModel
                                                        .result
                                                        ?.typeId
                                                        .toString() ??
                                                    '',
                                                vType: videoDetailsProvider
                                                        .sectionDetailModel
                                                        .result
                                                        ?.videoType
                                                        .toString() ??
                                                    '',
                                              );
                                              if (isRented != null &&
                                                  isRented == true) {
                                                _getData();
                                              }
                                            } else {
                                              if (kIsWeb) {
                                                Utils.buildWebAlertDialog(
                                                    context, "login", "");
                                                return;
                                              }
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
                                            width: Dimens.featureWebSize,
                                            height: Dimens.featureWebSize,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: primaryLight),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimens.featureWebSize /
                                                          2),
                                            ),
                                            child: MyImage(
                                              width: Dimens.featureIconWebSize,
                                              height: Dimens.featureIconWebSize,
                                              color: lightGray,
                                              imagePath: "ic_store.png",
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        MyText(
                                          color: white,
                                          multilanguage: false,
                                          text:
                                              "Rent at just ${Constant.currencySymbol}${videoDetailsProvider.sectionDetailModel.result?.rentPrice ?? 0}",
                                          fontsizeNormal: 12,
                                          fontweight: FontWeight.w500,
                                          fontsizeWeb: 12,
                                          maxline: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textalign: TextAlign.center,
                                          fontstyle: FontStyle.normal,
                                        ),
                                      ],
                                    ),
                                  ),

                                  /* Watchlist */
                                  Container(
                                    constraints:
                                        const BoxConstraints(minWidth: 50),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            log("isBookmark ====> ${videoDetailsProvider.sectionDetailModel.result?.isBookmark ?? 0}");
                                            if (Constant.userID != null) {
                                              await videoDetailsProvider
                                                  .setBookMark(
                                                context,
                                                widget.typeId,
                                                widget.videoType,
                                                widget.videoId,
                                              );
                                            } else {
                                              if (kIsWeb) {
                                                Utils.buildWebAlertDialog(
                                                    context, "login", "");
                                                return;
                                              }
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
                                          borderRadius: BorderRadius.circular(
                                              Dimens.featureWebSize / 2),
                                          child: Container(
                                            width: Dimens.featureWebSize,
                                            height: Dimens.featureWebSize,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: primaryLight,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimens.featureSize / 2),
                                            ),
                                            child:
                                                Consumer<VideoDetailsProvider>(
                                              builder: (context,
                                                  videoDetailsProvider, child) {
                                                return MyImage(
                                                  width:
                                                      Dimens.featureIconWebSize,
                                                  height:
                                                      Dimens.featureIconWebSize,
                                                  color: lightGray,
                                                  imagePath: (videoDetailsProvider
                                                                  .sectionDetailModel
                                                                  .result
                                                                  ?.isBookmark ??
                                                              0) ==
                                                          1
                                                      ? "watchlist_remove.png"
                                                      : "ic_plus.png",
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        MyText(
                                          color: white,
                                          text: "watchlist",
                                          fontsizeNormal: 12,
                                          fontsizeWeb: 12,
                                          fontweight: FontWeight.w500,
                                          multilanguage: true,
                                          maxline: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textalign: TextAlign.center,
                                          fontstyle: FontStyle.normal,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        /* Other Details */
        /* Related ~ More Details */
        Consumer<VideoDetailsProvider>(
          builder: (context, videoDetailsProvider, child) {
            return _buildTabs();
          },
        ),
        const SizedBox(height: 20),

        /* Web Footer */
        kIsWeb ? const FooterWeb() : const SizedBox.shrink(),
      ],
    );
  }

  double getDynamicHeight(String? videoType, String? layoutType) {
    if (videoType == "1" || videoType == "2") {
      if (layoutType == "landscape") {
        return Dimens.heightLand;
      } else if (layoutType == "potrait") {
        return Dimens.heightPort;
      } else if (layoutType == "square") {
        return Dimens.heightSquare;
      } else {
        return Dimens.heightLand;
      }
    } else if (videoType == "3" || videoType == "4") {
      return Dimens.heightLangGen;
    } else {
      if (layoutType == "landscape") {
        return Dimens.heightLand;
      } else if (layoutType == "potrait") {
        return Dimens.heightPort;
      } else if (layoutType == "square") {
        return Dimens.heightSquare;
      } else {
        return Dimens.heightLand;
      }
    }
  }

  Widget _buildPlayWithSubsCheck() {
    if ((videoDetailsProvider.sectionDetailModel.result?.isPremium ?? 0) == 1) {
      if ((videoDetailsProvider.sectionDetailModel.result?.stopTime ?? 0) > 0 &&
          videoDetailsProvider.sectionDetailModel.result?.videoDuration !=
              null) {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.fromLTRB(20, 18, 20, 0),
          child: InkWell(
            onTap: () async {
              if (Constant.userID != null) {
                if ((videoDetailsProvider
                            .sectionDetailModel.result?.isPremium ??
                        0) ==
                    1) {
                  if ((videoDetailsProvider.sectionDetailModel.result?.isBuy ??
                              0) ==
                          1 ||
                      (videoDetailsProvider
                                  .sectionDetailModel.result?.rentBuy ??
                              0) ==
                          1) {
                    openPlayer("Video");
                  } else {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const Subscription();
                        },
                      ),
                    );
                    _getData();
                  }
                }
              } else {
                if (kIsWeb) {
                  Utils.buildWebAlertDialog(context, "login", "");
                  return;
                }
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
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: 55,
              constraints: BoxConstraints(
                maxWidth: kIsWeb
                    ? (MediaQuery.of(context).size.width * 0.4)
                    : MediaQuery.of(context).size.width,
              ),
              decoration: BoxDecoration(
                color: primaryDark,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        MyImage(
                          width: 20,
                          height: 20,
                          imagePath: "ic_play.png",
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MyText(
                              color: white,
                              text: "continuewatching",
                              multilanguage: true,
                              textalign: TextAlign.start,
                              fontsizeNormal: 15,
                              fontweight: FontWeight.w600,
                              fontsizeWeb: 16,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal,
                            ),
                            Row(
                              children: [
                                MyText(
                                  color: white,
                                  text: Utils.remainTimeInMin(
                                      ((videoDetailsProvider.sectionDetailModel
                                                      .result?.videoDuration ??
                                                  0) -
                                              (videoDetailsProvider
                                                      .sectionDetailModel
                                                      .result
                                                      ?.stopTime ??
                                                  0))
                                          .abs()),
                                  textalign: TextAlign.start,
                                  fontsizeNormal: 10,
                                  fontweight: FontWeight.w500,
                                  fontsizeWeb: 12,
                                  multilanguage: false,
                                  maxline: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontstyle: FontStyle.normal,
                                ),
                                const SizedBox(width: 5),
                                MyText(
                                  color: white,
                                  text: "left",
                                  textalign: TextAlign.start,
                                  fontsizeNormal: 10,
                                  fontweight: FontWeight.w500,
                                  fontsizeWeb: 12,
                                  multilanguage: true,
                                  maxline: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontstyle: FontStyle.normal,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 4,
                    constraints: const BoxConstraints(minWidth: 0),
                    margin: const EdgeInsets.all(3),
                    child: LinearPercentIndicator(
                      padding: const EdgeInsets.all(0),
                      barRadius: const Radius.circular(2),
                      lineHeight: 4,
                      percent: Utils.getPercentage(
                          videoDetailsProvider
                                  .sectionDetailModel.result?.videoDuration ??
                              0,
                          videoDetailsProvider
                                  .sectionDetailModel.result?.stopTime ??
                              0),
                      backgroundColor: secProgressColor,
                      progressColor: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.fromLTRB(20, 18, 20, 0),
          child: InkWell(
            onTap: () async {
              if (Constant.userID != null) {
                if ((videoDetailsProvider
                            .sectionDetailModel.result?.isPremium ??
                        0) ==
                    1) {
                  if ((videoDetailsProvider.sectionDetailModel.result?.isBuy ??
                              0) ==
                          1 ||
                      (videoDetailsProvider
                                  .sectionDetailModel.result?.rentBuy ??
                              0) ==
                          1) {
                    openPlayer("Video");
                  } else {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const Subscription();
                        },
                      ),
                    );
                    _getData();
                  }
                }
              } else {
                if (kIsWeb) {
                  Utils.buildWebAlertDialog(context, "login", "");
                  return;
                }
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
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: 50,
              constraints: BoxConstraints(
                maxWidth: kIsWeb
                    ? (MediaQuery.of(context).size.width * 0.4)
                    : MediaQuery.of(context).size.width,
              ),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                color: primaryDark,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyImage(
                    width: 20,
                    height: 20,
                    imagePath: "ic_play.png",
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  MyText(
                    color: white,
                    text: "watch_now",
                    multilanguage: true,
                    textalign: TextAlign.start,
                    fontsizeNormal: 15,
                    fontweight: FontWeight.w600,
                    fontsizeWeb: 16,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    fontstyle: FontStyle.normal,
                  ),
                ],
              ),
            ),
          ),
        );
      }
    } else if ((videoDetailsProvider.sectionDetailModel.result?.isRent ?? 0) ==
        1) {
      if ((videoDetailsProvider.sectionDetailModel.result?.stopTime ?? 0) > 0 &&
          videoDetailsProvider.sectionDetailModel.result?.videoDuration !=
              null) {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.fromLTRB(20, 18, 20, 0),
          child: InkWell(
            onTap: () async {
              if (Constant.userID != null) {
                if ((videoDetailsProvider.sectionDetailModel.result?.isBuy ??
                            0) ==
                        1 ||
                    (videoDetailsProvider.sectionDetailModel.result?.rentBuy ??
                            0) ==
                        1) {
                  openPlayer("Video");
                } else {
                  dynamic isRented = await Utils.paymentForRent(
                    context: context,
                    videoId: videoDetailsProvider.sectionDetailModel.result?.id
                            .toString() ??
                        '',
                    rentPrice: videoDetailsProvider
                            .sectionDetailModel.result?.rentPrice
                            .toString() ??
                        '',
                    vTitle: videoDetailsProvider.sectionDetailModel.result?.name
                            .toString() ??
                        '',
                    typeId: videoDetailsProvider
                            .sectionDetailModel.result?.typeId
                            .toString() ??
                        '',
                    vType: videoDetailsProvider
                            .sectionDetailModel.result?.videoType
                            .toString() ??
                        '',
                  );
                  if (isRented != null && isRented == true) {
                    _getData();
                  }
                }
              } else {
                if (kIsWeb) {
                  Utils.buildWebAlertDialog(context, "login", "");
                  return;
                }
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
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: 55,
              constraints: BoxConstraints(
                maxWidth: kIsWeb
                    ? (MediaQuery.of(context).size.width * 0.4)
                    : MediaQuery.of(context).size.width,
              ),
              decoration: BoxDecoration(
                color: primaryDark,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        MyImage(
                            width: 20, height: 20, imagePath: "ic_play.png"),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MyText(
                              color: white,
                              text: "continuewatching",
                              multilanguage: true,
                              textalign: TextAlign.start,
                              fontsizeNormal: 15,
                              fontweight: FontWeight.w600,
                              fontsizeWeb: 16,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal,
                            ),
                            Row(
                              children: [
                                MyText(
                                  color: white,
                                  text: Utils.remainTimeInMin(
                                      ((videoDetailsProvider.sectionDetailModel
                                                      .result?.videoDuration ??
                                                  0) -
                                              (videoDetailsProvider
                                                      .sectionDetailModel
                                                      .result
                                                      ?.stopTime ??
                                                  0))
                                          .abs()),
                                  textalign: TextAlign.start,
                                  fontsizeNormal: 10,
                                  multilanguage: false,
                                  fontweight: FontWeight.normal,
                                  maxline: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontstyle: FontStyle.normal,
                                ),
                                const SizedBox(width: 5),
                                MyText(
                                  color: white,
                                  text: "left",
                                  textalign: TextAlign.start,
                                  fontsizeNormal: 10,
                                  fontweight: FontWeight.w600,
                                  fontsizeWeb: 11,
                                  multilanguage: true,
                                  maxline: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontstyle: FontStyle.normal,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 4,
                    constraints: const BoxConstraints(minWidth: 0),
                    margin: const EdgeInsets.all(3),
                    child: LinearPercentIndicator(
                      padding: const EdgeInsets.all(0),
                      barRadius: const Radius.circular(2),
                      lineHeight: 4,
                      percent: Utils.getPercentage(
                          videoDetailsProvider
                                  .sectionDetailModel.result?.videoDuration ??
                              0,
                          videoDetailsProvider
                                  .sectionDetailModel.result?.stopTime ??
                              0),
                      backgroundColor: secProgressColor,
                      progressColor: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return Container(
          margin: const EdgeInsets.fromLTRB(20, 18, 20, 0),
          child: InkWell(
            onTap: () {
              if (Constant.userID != null) {
                openPlayer("Video");
              } else {
                if (kIsWeb) {
                  Utils.buildWebAlertDialog(context, "login", "");
                  return;
                }
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
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: 50,
              constraints: BoxConstraints(
                maxWidth: kIsWeb
                    ? (MediaQuery.of(context).size.width * 0.4)
                    : MediaQuery.of(context).size.width,
              ),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                color: primaryDark,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyImage(
                    width: 20,
                    height: 20,
                    imagePath: "ic_play.png",
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  MyText(
                    color: white,
                    text: "watch_now",
                    multilanguage: true,
                    textalign: TextAlign.start,
                    fontsizeNormal: 15,
                    fontweight: FontWeight.w600,
                    fontsizeWeb: 16,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    fontstyle: FontStyle.normal,
                  ),
                ],
              ),
            ),
          ),
        );
      }
    } else {
      if ((videoDetailsProvider.sectionDetailModel.result?.stopTime ?? 0) > 0 &&
          videoDetailsProvider.sectionDetailModel.result?.videoDuration !=
              null) {
        return Container(
          margin: const EdgeInsets.fromLTRB(20, 18, 20, 0),
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              if (Constant.userID != null) {
                openPlayer("Video");
              } else {
                if (kIsWeb) {
                  Utils.buildWebAlertDialog(context, "login", "");
                  return;
                }
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
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: 55,
              constraints: BoxConstraints(
                maxWidth: kIsWeb
                    ? (MediaQuery.of(context).size.width * 0.4)
                    : MediaQuery.of(context).size.width,
              ),
              decoration: BoxDecoration(
                color: primaryDark,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        MyImage(
                            width: 20, height: 20, imagePath: "ic_play.png"),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MyText(
                              color: white,
                              text: "continuewatching",
                              multilanguage: true,
                              textalign: TextAlign.start,
                              fontsizeNormal: 15,
                              fontweight: FontWeight.w600,
                              fontsizeWeb: 16,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal,
                            ),
                            Row(
                              children: [
                                MyText(
                                  color: white,
                                  text: Utils.remainTimeInMin(
                                      ((videoDetailsProvider.sectionDetailModel
                                                      .result?.videoDuration ??
                                                  0) -
                                              (videoDetailsProvider
                                                      .sectionDetailModel
                                                      .result
                                                      ?.stopTime ??
                                                  0))
                                          .abs()),
                                  textalign: TextAlign.start,
                                  fontsizeNormal: 10,
                                  fontweight: FontWeight.w500,
                                  fontsizeWeb: 11,
                                  multilanguage: false,
                                  maxline: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontstyle: FontStyle.normal,
                                ),
                                const SizedBox(width: 5),
                                MyText(
                                  color: white,
                                  text: "left",
                                  textalign: TextAlign.start,
                                  fontsizeNormal: 10,
                                  fontweight: FontWeight.w500,
                                  fontsizeWeb: 11,
                                  multilanguage: true,
                                  maxline: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontstyle: FontStyle.normal,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 4,
                    constraints: const BoxConstraints(minWidth: 0),
                    margin: const EdgeInsets.all(3),
                    child: LinearPercentIndicator(
                      padding: const EdgeInsets.all(0),
                      barRadius: const Radius.circular(2),
                      lineHeight: 4,
                      percent: Utils.getPercentage(
                          videoDetailsProvider
                                  .sectionDetailModel.result?.videoDuration ??
                              0,
                          videoDetailsProvider
                                  .sectionDetailModel.result?.stopTime ??
                              0),
                      backgroundColor: secProgressColor,
                      progressColor: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return Container(
          margin: const EdgeInsets.fromLTRB(20, 18, 20, 0),
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              if (Constant.userID != null) {
                openPlayer("Video");
              } else {
                if (kIsWeb) {
                  Utils.buildWebAlertDialog(context, "login", "");
                  return;
                }
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
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: 50,
              constraints: BoxConstraints(
                maxWidth: kIsWeb
                    ? (MediaQuery.of(context).size.width * 0.4)
                    : MediaQuery.of(context).size.width,
              ),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                color: primaryDark,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyImage(
                    width: 20,
                    height: 20,
                    imagePath: "ic_play.png",
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  MyText(
                    color: white,
                    text: "watch_now",
                    multilanguage: true,
                    textalign: TextAlign.start,
                    fontsizeNormal: 15,
                    fontweight: FontWeight.w600,
                    fontsizeWeb: 16,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    fontstyle: FontStyle.normal,
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
  }

  Widget _buildRentBtn() {
    if ((videoDetailsProvider.sectionDetailModel.result?.isPremium ?? 0) == 1 &&
        (videoDetailsProvider.sectionDetailModel.result?.isRent ?? 0) == 1) {
      if ((videoDetailsProvider.sectionDetailModel.result?.isBuy ?? 0) == 1 ||
          (videoDetailsProvider.sectionDetailModel.result?.rentBuy ?? 0) == 1) {
        return const SizedBox.shrink();
      } else {
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(Dimens.featureSize / 2),
                onTap: () async {
                  if (Constant.userID != null) {
                    dynamic isRented = await Utils.paymentForRent(
                      context: context,
                      videoId: videoDetailsProvider
                              .sectionDetailModel.result?.id
                              .toString() ??
                          '',
                      rentPrice: videoDetailsProvider
                              .sectionDetailModel.result?.rentPrice
                              .toString() ??
                          '',
                      vTitle: videoDetailsProvider
                              .sectionDetailModel.result?.name
                              .toString() ??
                          '',
                      typeId: videoDetailsProvider
                              .sectionDetailModel.result?.typeId
                              .toString() ??
                          '',
                      vType: videoDetailsProvider
                              .sectionDetailModel.result?.videoType
                              .toString() ??
                          '',
                    );
                    if (isRented != null && isRented == true) {
                      _getData();
                    }
                  } else {
                    if (kIsWeb) {
                      Utils.buildWebAlertDialog(context, "login", "");
                      return;
                    }
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
                  width: Dimens.featureSize,
                  height: Dimens.featureSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryLight),
                    borderRadius: BorderRadius.circular(Dimens.featureSize / 2),
                  ),
                  child: MyImage(
                    width: Dimens.featureIconSize,
                    height: Dimens.featureIconSize,
                    color: lightGray,
                    imagePath: "ic_store.png",
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              MyText(
                color: white,
                multilanguage: false,
                text:
                    "Rent at just ${Constant.currencySymbol}${videoDetailsProvider.sectionDetailModel.result?.rentPrice ?? 0}",
                fontsizeNormal: 12,
                fontweight: FontWeight.w500,
                fontsizeWeb: 14,
                maxline: 2,
                overflow: TextOverflow.ellipsis,
                textalign: TextAlign.center,
                fontstyle: FontStyle.normal,
              ),
            ],
          ),
        );
      }
    } else if ((videoDetailsProvider.sectionDetailModel.result?.isRent ?? 0) ==
        1) {
      if ((videoDetailsProvider.sectionDetailModel.result?.isBuy ?? 0) == 1 ||
          (videoDetailsProvider.sectionDetailModel.result?.rentBuy ?? 0) == 1) {
        return const SizedBox.shrink();
      } else {
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(Dimens.featureSize / 2),
                onTap: () async {
                  if (Constant.userID != null) {
                    dynamic isRented = await Utils.paymentForRent(
                      context: context,
                      videoId: videoDetailsProvider
                              .sectionDetailModel.result?.id
                              .toString() ??
                          '',
                      rentPrice: videoDetailsProvider
                              .sectionDetailModel.result?.rentPrice
                              .toString() ??
                          '',
                      vTitle: videoDetailsProvider
                              .sectionDetailModel.result?.name
                              .toString() ??
                          '',
                      typeId: videoDetailsProvider
                              .sectionDetailModel.result?.typeId
                              .toString() ??
                          '',
                      vType: videoDetailsProvider
                              .sectionDetailModel.result?.videoType
                              .toString() ??
                          '',
                    );
                    if (isRented != null && isRented == true) {
                      _getData();
                    }
                  } else {
                    if (kIsWeb) {
                      Utils.buildWebAlertDialog(context, "login", "");
                      return;
                    }
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
                  width: Dimens.featureSize,
                  height: Dimens.featureSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryLight,
                    ),
                    borderRadius: BorderRadius.circular(Dimens.featureSize / 2),
                  ),
                  child: MyImage(
                    width: Dimens.featureIconSize,
                    height: Dimens.featureIconSize,
                    color: lightGray,
                    imagePath: "ic_store.png",
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              MyText(
                color: white,
                multilanguage: false,
                text:
                    "Rent at just ${Constant.currencySymbol}${videoDetailsProvider.sectionDetailModel.result?.rentPrice ?? 0}",
                fontsizeNormal: 12,
                fontweight: FontWeight.w500,
                fontsizeWeb: 14,
                maxline: 2,
                overflow: TextOverflow.ellipsis,
                textalign: TextAlign.center,
                fontstyle: FontStyle.normal,
              ),
            ],
          ),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildTabs() {
    return Container(
      margin: kIsWeb
          ? const EdgeInsets.fromLTRB(20, 0, 20, 0)
          : const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: kIsWeb
                  ? (MediaQuery.of(context).size.width * 0.5)
                  : MediaQuery.of(context).size.width,
            ),
            height: kIsWeb ? 35 : Dimens.detailTabs,
            child: Row(
              children: [
                /* Related */
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () async {
                      await videoDetailsProvider.setTabClick("related");
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: MyText(
                              color:
                                  videoDetailsProvider.tabClickedOn != "related"
                                      ? otherColor
                                      : white,
                              text: "related",
                              multilanguage: true,
                              textalign: TextAlign.center,
                              fontsizeNormal: 16,
                              fontweight: FontWeight.w600,
                              fontsizeWeb: 16,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              videoDetailsProvider.tabClickedOn == "related",
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 2,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                /* More Details */
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () async {
                      await videoDetailsProvider.setTabClick("moredetails");
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: MyText(
                              color: videoDetailsProvider.tabClickedOn !=
                                      "moredetails"
                                  ? otherColor
                                  : white,
                              text: "moredetails",
                              textalign: TextAlign.center,
                              fontsizeNormal: 16,
                              fontweight: FontWeight.w600,
                              fontsizeWeb: 16,
                              multilanguage: true,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: videoDetailsProvider.tabClickedOn ==
                              "moredetails",
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 2,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.5,
            color: otherColor,
            constraints: BoxConstraints(
              maxWidth: kIsWeb
                  ? (MediaQuery.of(context).size.width * 0.5)
                  : MediaQuery.of(context).size.width,
            ),
          ),
          /* Data */
          (videoDetailsProvider.tabClickedOn == "related")
              ? Column(
                  children: [
                    /* Customers also watched */
                    _buildRelatedVideos(),

                    /* Cast & Crew */
                    const SizedBox(height: 25),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: MyText(
                        color: white,
                        text: "castandcrew",
                        multilanguage: true,
                        textalign: TextAlign.start,
                        fontsizeNormal: 16,
                        fontweight: FontWeight.w600,
                        fontsizeWeb: 17,
                        maxline: 1,
                        overflow: TextOverflow.ellipsis,
                        fontstyle: FontStyle.normal,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: MyText(
                              color: otherColor,
                              text: "detailsfrom",
                              multilanguage: true,
                              textalign: TextAlign.center,
                              fontsizeNormal: 13,
                              fontweight: FontWeight.w500,
                              fontsizeWeb: 14,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: otherColor,
                                width: .7,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              shape: BoxShape.rectangle,
                            ),
                            child: MyText(
                              color: otherColor,
                              text: "IMDb",
                              multilanguage: false,
                              textalign: TextAlign.center,
                              fontsizeNormal: 12,
                              fontweight: FontWeight.w700,
                              fontsizeWeb: 13,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildCastAndCrew(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 0.7,
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      color: primaryColor,
                    ),
                    const SizedBox(height: 15),

                    /* Director */
                    _buildDirector(),
                  ],
                )
              : ((videoDetailsProvider.sectionDetailModel.moreDetails != null)
                  ? /* More Details */
                  _buildMoreDetails()
                  : const NoData(
                      title: '',
                      subTitle: '',
                    ))
        ],
      ),
    );
  }

  Widget _buildRelatedVideos() {
    if (videoDetailsProvider.sectionDetailModel.getRelatedVideo != null &&
        (videoDetailsProvider.sectionDetailModel.getRelatedVideo?.length ?? 0) >
            0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: MyText(
              color: white,
              text: "customer_also_watch",
              multilanguage: true,
              textalign: TextAlign.start,
              fontsizeNormal: 16,
              fontweight: FontWeight.w600,
              fontsizeWeb: 17,
              maxline: 1,
              overflow: TextOverflow.ellipsis,
              fontstyle: FontStyle.normal,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          /* video_type =>  1-video,  2-show,  3-language,  4-category */
          /* screen_layout =>  landscape, potrait, square */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: getDynamicHeight(
              "${videoDetailsProvider.sectionDetailModel.result?.videoType ?? ""}",
              "landscape",
            ),
            child: landscape(
                videoDetailsProvider.sectionDetailModel.getRelatedVideo),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildCastAndCrew() {
    if (videoDetailsProvider.sectionDetailModel.cast != null &&
        (videoDetailsProvider.sectionDetailModel.cast?.length ?? 0) > 0) {
      return Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
        child: ResponsiveGridList(
          minItemWidth: kIsWeb ? Dimens.widthCastWeb : Dimens.widthCast,
          verticalGridSpacing: 8,
          horizontalGridSpacing: 6,
          minItemsPerRow: 3,
          maxItemsPerRow: 6,
          listViewBuilderOptions: ListViewBuilderOptions(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
          children: List.generate(
            (videoDetailsProvider.sectionDetailModel.cast?.length ?? 0),
            (position) {
              return InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  log("Item Clicked! => $position");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CastDetails(
                          castID: videoDetailsProvider
                                  .sectionDetailModel.cast?[position].id
                                  .toString() ??
                              ""),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.antiAlias,
                  children: <Widget>[
                    SizedBox(
                      height: kIsWeb ? Dimens.heightCastWeb : Dimens.heightCast,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimens.cardRadius),
                        child: MyNetworkImage(
                          imageUrl: videoDetailsProvider
                                  .sectionDetailModel.cast?[position].image ??
                              Constant.userPlaceholder,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      height: kIsWeb ? Dimens.heightCastWeb : Dimens.heightCast,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          colors: [
                            transparentColor,
                            blackTransparent,
                            black,
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: MyText(
                        multilanguage: false,
                        text: videoDetailsProvider
                                .sectionDetailModel.cast?[position].name ??
                            "",
                        fontstyle: FontStyle.normal,
                        fontsizeNormal: 12,
                        fontweight: FontWeight.w500,
                        fontsizeWeb: 14,
                        maxline: 3,
                        overflow: TextOverflow.ellipsis,
                        textalign: TextAlign.center,
                        color: white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildDirector() {
    if (directorList != null && (directorList?.length ?? 0) > 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(
            minHeight: kIsWeb ? Dimens.heightCastWeb : Dimens.heightCast),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(Dimens.cardRadius),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CastDetails(
                        castID: directorList?[0].id.toString() ?? ""),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.antiAlias,
                children: <Widget>[
                  SizedBox(
                    height: kIsWeb ? Dimens.heightCastWeb : Dimens.heightCast,
                    width: kIsWeb ? Dimens.widthCastWeb : Dimens.widthCast,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimens.cardRadius),
                      child: MyNetworkImage(
                        imageUrl:
                            directorList?[0].image ?? Constant.userPlaceholder,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(0),
                    height: kIsWeb ? Dimens.heightCastWeb : Dimens.heightCast,
                    width: kIsWeb ? Dimens.widthCastWeb : Dimens.widthCast,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [
                          transparentColor,
                          blackTransparent,
                          black,
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: MyText(
                      multilanguage: false,
                      text: directorList?[0].name ?? "",
                      fontstyle: FontStyle.normal,
                      fontsizeNormal: 12,
                      fontweight: FontWeight.w500,
                      fontsizeWeb: 13,
                      maxline: 3,
                      overflow: TextOverflow.ellipsis,
                      textalign: TextAlign.center,
                      color: white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  MyText(
                    color: white,
                    text: "directors",
                    multilanguage: true,
                    textalign: TextAlign.start,
                    fontsizeNormal: 14,
                    fontweight: FontWeight.w600,
                    fontsizeWeb: 15,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    fontstyle: FontStyle.normal,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  MyText(
                    color: otherColor,
                    text: directorList?[0].personalInfo ?? "",
                    textalign: TextAlign.start,
                    multilanguage: false,
                    fontsizeNormal: 13,
                    fontweight: FontWeight.w500,
                    fontsizeWeb: 14,
                    maxline: 7,
                    overflow: TextOverflow.ellipsis,
                    fontstyle: FontStyle.normal,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildMoreDetails() {
    return AlignedGridView.count(
      shrinkWrap: true,
      crossAxisCount: 1,
      crossAxisSpacing: 0,
      mainAxisSpacing: 25,
      padding: const EdgeInsets.all(kIsWeb ? 30 : 20),
      itemCount:
          videoDetailsProvider.sectionDetailModel.moreDetails?.length ?? 0,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if ((videoDetailsProvider
                    .sectionDetailModel.moreDetails?[index].description ??
                "")
            .isNotEmpty) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                color: white,
                text: videoDetailsProvider
                        .sectionDetailModel.moreDetails?[index].title ??
                    "",
                textalign: TextAlign.start,
                fontsizeNormal: 14,
                fontweight: FontWeight.w600,
                fontsizeWeb: 15,
                multilanguage: false,
                maxline: 1,
                overflow: TextOverflow.ellipsis,
                fontstyle: FontStyle.normal,
              ),
              const SizedBox(
                height: 3,
              ),
              MyText(
                color: otherColor,
                text: videoDetailsProvider
                        .sectionDetailModel.moreDetails?[index].description ??
                    "",
                textalign: TextAlign.start,
                fontsizeNormal: 13,
                fontweight: FontWeight.w500,
                fontsizeWeb: 14,
                multilanguage: false,
                maxline: 20,
                overflow: TextOverflow.ellipsis,
                fontstyle: FontStyle.normal,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: kIsWeb
                      ? (MediaQuery.of(context).size.width * 0.5)
                      : MediaQuery.of(context).size.width,
                ),
                height: 0.4,
                color: otherColor,
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  /* ========= Download ========= */

  Widget _buildDownloadWithSubCheck() {
    if ((videoDetailsProvider.sectionDetailModel.result?.isPremium ?? 0) == 1) {
      if ((videoDetailsProvider.sectionDetailModel.result?.isBuy ?? 0) == 1 ||
          (videoDetailsProvider.sectionDetailModel.result?.rentBuy ?? 0) == 1) {
        return _buildDownloadBtn();
      } else {
        return const SizedBox.shrink();
      }
    } else if ((videoDetailsProvider.sectionDetailModel.result?.isRent ?? 0) ==
        1) {
      if ((videoDetailsProvider.sectionDetailModel.result?.isBuy ?? 0) == 1 ||
          (videoDetailsProvider.sectionDetailModel.result?.rentBuy ?? 0) == 1) {
        return _buildDownloadBtn();
      } else {
        return const SizedBox.shrink();
      }
    } else {
      return _buildDownloadBtn();
    }
  }

  Widget _buildDownloadBtn() {
    if (videoDetailsProvider.sectionDetailModel.result?.videoUploadType ==
        "server_video") {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(Dimens.featureSize / 2),
              onTap: () {
                if (Constant.userID != null) {
                  if (downloadProvider.currentProgress(
                          videoDetailsProvider.sectionDetailModel.result?.id ??
                              0) ==
                      0) {
                    _checkAndDownload();
                  } else {
                    Utils.showSnackbar(context, "response", "please_wait");
                  }
                } else {
                  if (kIsWeb) {
                    Utils.buildWebAlertDialog(context, "login", "");
                    return;
                  }
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
                width: Dimens.featureSize,
                height: Dimens.featureSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryLight,
                  ),
                  borderRadius: BorderRadius.circular(Dimens.featureSize / 2),
                ),
                child: Consumer<DownloadProvider>(
                  builder: (context, downloadProvider, child) {
                    if (downloadProvider.currentProgress(videoDetailsProvider
                                .sectionDetailModel.result?.id ??
                            0) >
                        0) {
                      return Center(
                        child: CircularProgressIndicator(
                          value: downloadProvider.currentProgress(
                              videoDetailsProvider
                                      .sectionDetailModel.result?.id ??
                                  0),
                        ),
                      );
                    } else {
                      return MyImage(
                        width: Dimens.featureIconSize,
                        height: Dimens.featureIconSize,
                        color: lightGray,
                        imagePath: (videoDetailsProvider
                                    .sectionDetailModel.result?.isDownloaded ==
                                1)
                            ? "ic_download_done.png"
                            : "ic_download.png",
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Consumer<DownloadProvider>(
                builder: (context, downloadProvider, child) {
              return MyText(
                color: white,
                text: (videoDetailsProvider
                            .sectionDetailModel.result?.isDownloaded ==
                        1)
                    ? "complete"
                    : "download",
                multilanguage: true,
                fontsizeNormal: 12,
                fontweight: FontWeight.w500,
                fontsizeWeb: 13,
                maxline: 1,
                overflow: TextOverflow.ellipsis,
                textalign: TextAlign.center,
                fontstyle: FontStyle.normal,
              );
            }),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  _checkAndDownload() async {
    _permissionReady = await Utils.checkPermission();
    if (_permissionReady) {
      if (videoDetailsProvider.sectionDetailModel.result?.isDownloaded == 0) {
        if ((videoDetailsProvider.sectionDetailModel.result?.video320 ?? "")
            .isNotEmpty) {
          File? mTargetFile;
          String? mFileName =
              '${(videoDetailsProvider.sectionDetailModel.result?.name ?? "").replaceAll(RegExp(r'[^\w\s]+'), '_').replaceAll(RegExp(" "), "")}'
              '${(videoDetailsProvider.sectionDetailModel.result?.id ?? 0)}${(Constant.userID)}';
          try {
            Directory? directory;
            if (Platform.isAndroid) {
              directory = await getExternalStorageDirectory();
            } else {
              directory = await getApplicationDocumentsDirectory();
            }
            String localPath = directory?.absolute.path ?? "";
            final savedDir = Directory(localPath);
            bool hasExisted = await savedDir.exists();
            if (!hasExisted) {
              savedDir.create();
            }
            log("savedDir ====> ${savedDir.absolute.path}");
            mTargetFile = File(path.join(localPath,
                '$mFileName.${(videoDetailsProvider.sectionDetailModel.result?.videoExtension ?? ".mp4")}'));
            // This is a sync operation on a real
            // app you'd probably prefer to use writeAsByte and handle its Future
          } catch (e) {
            debugPrint("saveVideoStorage Exception ===> $e");
          }
          log("mFileName ========> $mFileName");
          log("mTargetFile ========> ${mTargetFile?.absolute.path ?? ""}");
          if (mTargetFile != null) {
            try {
              downloadProvider.downloadVideo(
                mTargetFile.absolute.path,
                videoDetailsProvider.sectionDetailModel.result?.video320 ?? "",
                videoDetailsProvider.sectionDetailModel.result?.id ?? 0,
              );
              log("mTargetFile length ========> ${mTargetFile.length()}");
            } catch (e) {
              log("Downloading... Exception ======> $e");
            }
          }
        } else {
          if (!mounted) return;
          Utils.showSnackbar(context, "response", "invalid_url");
        }
      }
    }
  }
  /* ========= Download ========= */

  /* ========= Dialogs ========= */
  buildLangSubtitleDialog(List<Language>? languageList) {
    log("languageList Size ===> ${languageList?.length ?? 0}");
    String? audioLanguages;
    if ((languageList?.length ?? 0) > 0) {
      for (int i = 0; i < (languageList?.length ?? 0); i++) {
        if (i == 0) {
          audioLanguages = languageList?[i].name ?? "";
        } else {
          audioLanguages = "$audioLanguages, ${languageList?[i].name ?? ""}";
        }
      }
    }
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
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyText(
                    text: "avalablelanguage",
                    fontsizeNormal: 17,
                    fontweight: FontWeight.w700,
                    fontsizeWeb: 18,
                    fontstyle: FontStyle.normal,
                    maxline: 1,
                    multilanguage: true,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.start,
                    color: white,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MyText(
                    text: "languagechangenote",
                    fontsizeNormal: 13,
                    fontweight: FontWeight.w500,
                    fontsizeWeb: 14,
                    fontstyle: FontStyle.normal,
                    maxline: 1,
                    multilanguage: true,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.start,
                    color: otherColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyText(
                    text: "audios",
                    fontsizeNormal: 17,
                    fontweight: FontWeight.w500,
                    fontsizeWeb: 18,
                    fontstyle: FontStyle.normal,
                    maxline: 1,
                    multilanguage: true,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.start,
                    color: white,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  MyText(
                    text: audioLanguages ?? "-",
                    fontsizeNormal: 13,
                    fontweight: FontWeight.w500,
                    fontsizeWeb: 14,
                    fontstyle: FontStyle.normal,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.start,
                    color: otherColor,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 0.7,
                    margin: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                    color: otherColor,
                  ),
                  MyText(
                    text: "subtitle",
                    fontsizeNormal: 17,
                    fontweight: FontWeight.w700,
                    fontsizeWeb: 16,
                    multilanguage: true,
                    fontstyle: FontStyle.normal,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.start,
                    color: white,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  MyText(
                    text: (videoDetailsProvider
                                    .sectionDetailModel.result?.subtitle ??
                                "")
                            .isNotEmpty
                        ? "Available"
                        : "-",
                    fontsizeNormal: 16,
                    fontweight: FontWeight.w500,
                    fontsizeWeb: 17,
                    fontstyle: FontStyle.normal,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.start,
                    color: otherColor,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  buildMoreDialog(stopTime) {
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
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /* Share */
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      Navigator.pop(context);
                      buildShareWithDialog();
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
                            imagePath: "ic_share.png",
                            fit: BoxFit.fill,
                            color: lightGray,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: MyText(
                              text: "share",
                              multilanguage: true,
                              fontsizeNormal: 16,
                              fontweight: FontWeight.w500,
                              fontsizeWeb: 17,
                              color: white,
                              fontstyle: FontStyle.normal,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              textalign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /* Trailer */
                  stopTime > 0
                      ? InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {
                            Navigator.pop(context);
                            openPlayer("Trailer");
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
                                  imagePath: "ic_borderplay.png",
                                  fit: BoxFit.fill,
                                  color: lightGray,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: MyText(
                                    text: "trailer",
                                    multilanguage: true,
                                    fontsizeNormal: 16,
                                    fontweight: FontWeight.w500,
                                    fontsizeWeb: 17,
                                    color: white,
                                    fontstyle: FontStyle.normal,
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
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  buildShareWithDialog() {
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
                        videoDetailsProvider.sectionDetailModel.result?.name ??
                            "",
                    multilanguage: false,
                    fontsizeNormal: 18,
                    color: white,
                    fontstyle: FontStyle.normal,
                    fontweight: FontWeight.w700,
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
                      (videoDetailsProvider.sectionDetailModel.result
                                      ?.ageRestriction ??
                                  "")
                              .isNotEmpty
                          ? Container(
                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              margin: const EdgeInsets.only(right: 8),
                              decoration: Utils.setBGWithBorder(
                                  transparentColor, otherColor, 3, 0.7),
                              child: MyText(
                                text: videoDetailsProvider.sectionDetailModel
                                        .result?.ageRestriction ??
                                    "",
                                multilanguage: false,
                                fontsizeNormal: 10,
                                color: otherColor,
                                fontstyle: FontStyle.normal,
                                fontweight: FontWeight.normal,
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
                            'sms:?body=${Uri.encodeComponent("Hey! I'm watching ${videoDetailsProvider.sectionDetailModel.result?.name ?? ""}. Check it out now on ${Constant.appName}! \nhttps://play.google.com/store/apps/details?id=${Constant.appPackageName} \n")}');
                      } else if (Platform.isIOS) {
                        Utils.redirectToUrl(
                            'sms:&body=${Uri.encodeComponent("Hey! I'm watching ${videoDetailsProvider.sectionDetailModel.result?.name ?? ""}. Check it out now on ${Constant.appName}! \nhttps://apps.apple.com/us/app/${Constant.appName?.toLowerCase()}/${Constant.appPackageName} \n")}');
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
                              fontsizeNormal: 16,
                              color: white,
                              fontstyle: FontStyle.normal,
                              fontweight: FontWeight.normal,
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
                          ? "Hey! I'm watching ${videoDetailsProvider.sectionDetailModel.result?.name ?? ""}. Check it out now on ${Constant.appName}! \nhttps://apps.apple.com/us/app/${Constant.appName?.toLowerCase()}/${Constant.appPackageName} \n"
                          : "Hey! I'm watching ${videoDetailsProvider.sectionDetailModel.result?.name ?? ""}. Check it out now on ${Constant.appName}! \nhttps://play.google.com/store/apps/details?id=${Constant.appPackageName} \n");
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
                              fontsizeNormal: 16,
                              color: white,
                              fontstyle: FontStyle.normal,
                              fontweight: FontWeight.normal,
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
                            ? "Hey! I'm watching ${videoDetailsProvider.sectionDetailModel.result?.name ?? ""}. Check it out now on ${Constant.appName}! \nhttps://apps.apple.com/us/app/${Constant.appName?.toLowerCase()}/${Constant.appPackageName} \n"
                            : "Hey! I'm watching ${videoDetailsProvider.sectionDetailModel.result?.name ?? ""}. Check it out now on ${Constant.appName}! \nhttps://play.google.com/store/apps/details?id=${Constant.appPackageName} \n",
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
                              fontsizeNormal: 16,
                              color: white,
                              fontstyle: FontStyle.normal,
                              fontweight: FontWeight.normal,
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
                          ? "Hey! I'm watching ${videoDetailsProvider.sectionDetailModel.result?.name ?? ""}. Check it out now on ${Constant.appName}! \nhttps://apps.apple.com/us/app/${Constant.appName?.toLowerCase()}/${Constant.appPackageName} \n"
                          : "Hey! I'm watching ${videoDetailsProvider.sectionDetailModel.result?.name ?? ""}. Check it out now on ${Constant.appName}! \nhttps://play.google.com/store/apps/details?id=${Constant.appPackageName} \n");
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
                              fontsizeNormal: 16,
                              color: white,
                              fontstyle: FontStyle.normal,
                              fontweight: FontWeight.normal,
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
  /* ========= Dialogs ========= */

  Widget landscape(List<GetRelatedVideo>? relatedDataList) {
    return ListView.separated(
      itemCount: relatedDataList?.length ?? 0,
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MovieDetails(
                    relatedDataList?[index].id ?? 0,
                    relatedDataList?[index].videoType ?? 0,
                    relatedDataList?[index].typeId ?? 0,
                  );
                },
              ),
            );
          },
          child: Container(
            width: Dimens.widthLand,
            height: Dimens.heightLand,
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: MyNetworkImage(
                imageUrl: relatedDataList?[index].landscape.toString() ?? "",
                fit: BoxFit.cover,
                imgHeight: MediaQuery.of(context).size.height,
                imgWidth: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget portrait(List<GetRelatedVideo>? relatedDataList) {
    return ListView.separated(
      itemCount: relatedDataList?.length ?? 0,
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MovieDetails(
                    relatedDataList?[index].id ?? 0,
                    relatedDataList?[index].videoType ?? 0,
                    relatedDataList?[index].typeId ?? 0,
                  );
                },
              ),
            );
          },
          child: Container(
            width: Dimens.widthPort,
            height: Dimens.heightPort,
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: MyNetworkImage(
                imageUrl: relatedDataList?[index].thumbnail.toString() ?? "",
                fit: BoxFit.cover,
                imgHeight: MediaQuery.of(context).size.height,
                imgWidth: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget square(List<GetRelatedVideo>? relatedDataList) {
    return ListView.separated(
      itemCount: relatedDataList?.length ?? 0,
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MovieDetails(
                    relatedDataList?[index].id ?? 0,
                    relatedDataList?[index].videoType ?? 0,
                    relatedDataList?[index].typeId ?? 0,
                  );
                },
              ),
            );
          },
          child: Container(
            width: Dimens.widthSquare,
            height: Dimens.heightSquare,
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: MyNetworkImage(
                imageUrl: relatedDataList?[index].thumbnail.toString() ?? "",
                fit: BoxFit.cover,
                imgHeight: MediaQuery.of(context).size.height,
                imgWidth: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        );
      },
    );
  }

  /* ========= Open Player ========= */
  void openPlayer(String playType) async {
    if (!kIsWeb) Utils.deleteCacheDir();
    int? vID = (videoDetailsProvider.sectionDetailModel.result?.id ?? 0);
    int? vType =
        (videoDetailsProvider.sectionDetailModel.result?.videoType ?? 0);
    int? vTypeID = widget.typeId;

    int? stopTime;
    if (playType == "startOver") {
      stopTime = 0;
    } else {
      stopTime =
          (videoDetailsProvider.sectionDetailModel.result?.stopTime ?? 0);
    }

    String? vUrl, vSubtitle, vUploadType;
    if (playType == "Trailer") {
      vUploadType = "Trailer";
      vUrl = (videoDetailsProvider.sectionDetailModel.result?.trailerUrl ?? "");
      vSubtitle = "";
    } else {
      vUrl = (videoDetailsProvider.sectionDetailModel.result?.video320 ?? "");
      vSubtitle =
          (videoDetailsProvider.sectionDetailModel.result?.subtitle ?? "");
      vUploadType =
          (videoDetailsProvider.sectionDetailModel.result?.videoUploadType ??
              "");
    }

    log("===>vUploadType $vUploadType");
    if (vUploadType == "youtube") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return YoutubeVideo(
              videoUrl: vUrl,
            );
          },
        ),
      );
    } else if (vUploadType == "vimeo") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return VimeoPlayerPage(
              url: vUrl,
            );
          },
        ),
      );
    } else {
      if (kIsWeb) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PlayerWeb(playType == "Trailer" ? "Trailer" : "Video", vID,
                  vType, vTypeID, vUrl ?? "", vSubtitle ?? "", stopTime);
            },
          ),
        );
      } else {
        var isContinue = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PlayerPage(playType == "Trailer" ? "Trailer" : "Video",
                  vID, vType, vTypeID, vUrl ?? "", vSubtitle ?? "", stopTime);
            },
          ),
        );
        log("isContinue ===> $isContinue");
        if (isContinue != null && isContinue == true) {
          _getData();
        }
      }
    }
  }
}
