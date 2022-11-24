import 'dart:developer';

import 'package:dtlive/model/sectiondetailmodel.dart';
import 'package:dtlive/pages/nodata.dart';
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
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class MovieDetails extends StatefulWidget {
  final int videoId, videoType, typeId;
  const MovieDetails(this.videoId, this.videoType, this.typeId, {Key? key})
      : super(key: key);

  @override
  State<MovieDetails> createState() => MovieDetailsState();
}

class MovieDetailsState extends State<MovieDetails> {
  List<Cast>? directorList;
  VideoDetailsProvider videoDetailsProvider = VideoDetailsProvider();

  @override
  void initState() {
    super.initState();
    log("initState videoId ==> ${widget.videoId}");
    log("initState videoType ==> ${widget.videoType}");
    log("initState typeId ==> ${widget.typeId}");
    _getData();
  }

  void _getData() async {
    Utils.getCurrencySymbol();
    videoDetailsProvider =
        Provider.of<VideoDetailsProvider>(context, listen: false);
    await videoDetailsProvider.getSectionDetails(
        widget.typeId, widget.videoType, widget.videoId);
    Future.delayed(Duration.zero).then((value) => setState(() {}));
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
    if (videoDetailsProvider.loading) {
      return Utils.pageLoader();
    } else {
      if (videoDetailsProvider.sectionDetailModel.status == 200) {
        if (videoDetailsProvider.sectionDetailModel.result != null) {
          if (videoDetailsProvider.sectionDetailModel.cast != null &&
              (videoDetailsProvider.sectionDetailModel.cast?.length ?? 0) > 0) {
            directorList = <Cast>[];
            for (int i = 0;
                i < (videoDetailsProvider.sectionDetailModel.cast?.length ?? 0);
                i++) {
              if (videoDetailsProvider.sectionDetailModel.cast
                      ?.elementAt(i)
                      .type ==
                  "Director") {
                Cast cast = Cast();
                cast.id = videoDetailsProvider.sectionDetailModel.cast
                        ?.elementAt(i)
                        .id ??
                    0;
                cast.name = videoDetailsProvider.sectionDetailModel.cast
                        ?.elementAt(i)
                        .name ??
                    "";
                cast.image = videoDetailsProvider.sectionDetailModel.cast
                        ?.elementAt(i)
                        .image ??
                    "";
                cast.type = videoDetailsProvider.sectionDetailModel.cast
                        ?.elementAt(i)
                        .type ??
                    "";
                cast.personalInfo = videoDetailsProvider.sectionDetailModel.cast
                        ?.elementAt(i)
                        .personalInfo ??
                    "";
                cast.status = videoDetailsProvider.sectionDetailModel.cast
                        ?.elementAt(i)
                        .status ??
                    "";
                cast.createdAt = videoDetailsProvider.sectionDetailModel.cast
                        ?.elementAt(i)
                        .createdAt ??
                    "";
                cast.updatedAt = videoDetailsProvider.sectionDetailModel.cast
                        ?.elementAt(i)
                        .updatedAt ??
                    "";
                directorList?.add(cast);
                log("directorList size ===> ${directorList?.length ?? 0}");
              }
            }
          }
          return Scaffold(
            key: widget.key,
            backgroundColor: appBgColor,
            body: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    /* Poster */
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width,
                          height: Constant.detailPoster,
                          color: white,
                          child: MyNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: videoDetailsProvider
                                        .sectionDetailModel.result?.landscape !=
                                    ""
                                ? (videoDetailsProvider
                                        .sectionDetailModel.result?.landscape ??
                                    Constant.placeHolderLand)
                                : (videoDetailsProvider
                                        .sectionDetailModel.result?.thumbnail ??
                                    Constant.placeHolderLand),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width,
                          height: Constant.detailPoster,
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
                            openPlayer(
                                "Video",
                                (videoDetailsProvider
                                        .sectionDetailModel.result?.id ??
                                    0),
                                (videoDetailsProvider
                                        .sectionDetailModel.result?.videoType ??
                                    0),
                                widget.typeId,
                                (videoDetailsProvider
                                        .sectionDetailModel.result?.video ??
                                    ""),
                                (videoDetailsProvider
                                        .sectionDetailModel.result?.name ??
                                    ""),
                                (videoDetailsProvider.sectionDetailModel.result
                                        ?.videoUploadType ??
                                    ""),
                                (videoDetailsProvider
                                        .sectionDetailModel.result?.videoUrl ??
                                    ""));
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
                      transform:
                          Matrix4.translationValues(0, -kToolbarHeight, 0),
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
                                                  .sectionDetailModel
                                                  .result
                                                  ?.thumbnail !=
                                              ""
                                          ? (videoDetailsProvider
                                                  .sectionDetailModel
                                                  .result
                                                  ?.thumbnail ??
                                              Constant.placeHolderPort)
                                          : Constant.placeHolderPort,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        fontsize: 24,
                                        fontwaight: FontWeight.w800,
                                        maxline: 2,
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
                                          (videoDetailsProvider
                                                          .sectionDetailModel
                                                          .result
                                                          ?.releaseYear !=
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
                                                    fontsize: 13,
                                                    fontwaight:
                                                        FontWeight.normal,
                                                    maxline: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontstyle: FontStyle.normal,
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          /* Duration */
                                          (videoDetailsProvider
                                                      .sectionDetailModel
                                                      .result
                                                      ?.videoDuration !=
                                                  null)
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  child: MyText(
                                                    color: otherColor,
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
                                                    fontsize: 13,
                                                    fontwaight:
                                                        FontWeight.normal,
                                                    maxline: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontstyle: FontStyle.normal,
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          /* Age Limit */
                                          (videoDetailsProvider
                                                          .sectionDetailModel
                                                          .result
                                                          ?.ageRestriction !=
                                                      null &&
                                                  videoDetailsProvider
                                                          .sectionDetailModel
                                                          .result
                                                          ?.ageRestriction !=
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
                                                        BorderRadius.circular(
                                                            4),
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  child: MyText(
                                                    color: otherColor,
                                                    text: videoDetailsProvider
                                                            .sectionDetailModel
                                                            .result
                                                            ?.ageRestriction ??
                                                        "",
                                                    textalign: TextAlign.center,
                                                    fontsize: 10,
                                                    fontwaight:
                                                        FontWeight.normal,
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
                                                        BorderRadius.circular(
                                                            4),
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
                                                    fontsize: 10,
                                                    fontwaight:
                                                        FontWeight.normal,
                                                    maxline: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                          /* Prime TAG  & Rent TAG */
                          (videoDetailsProvider.sectionDetailModel.result
                                          ?.isPremium ??
                                      0) ==
                                  1
                              ? Column(
                                  children: [
                                    /* Prime TAG */
                                    Container(
                                      margin: const EdgeInsets.only(top: 11),
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          MyText(
                                            color: primaryColor,
                                            text: primeTAG,
                                            textalign: TextAlign.start,
                                            fontsize: 16,
                                            fontwaight: FontWeight.w700,
                                            maxline: 1,
                                            overflow: TextOverflow.ellipsis,
                                            fontstyle: FontStyle.normal,
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          MyText(
                                            color: white,
                                            text: primeTAGDesc,
                                            textalign: TextAlign.center,
                                            fontsize: 12,
                                            fontwaight: FontWeight.normal,
                                            maxline: 1,
                                            overflow: TextOverflow.ellipsis,
                                            fontstyle: FontStyle.normal,
                                          ),
                                        ],
                                      ),
                                    ),
                                    /* Rent TAG */
                                    (videoDetailsProvider.sectionDetailModel
                                                    .result?.isRent ??
                                                0) ==
                                            1
                                        ? Container(
                                            margin:
                                                const EdgeInsets.only(top: 8),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 20, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 20,
                                                  height: 20,
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
                                                    fontsize: 11,
                                                    fontwaight: FontWeight.w800,
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
                                                    text: rentTAG,
                                                    textalign: TextAlign.center,
                                                    fontsize: 12,
                                                    fontwaight:
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
                                  ],
                                )
                              : const SizedBox.shrink(),
                          /* Play Video button */
                          ((videoDetailsProvider.sectionDetailModel.result
                                              ?.isPremium ??
                                          0) ==
                                      0 &&
                                  (videoDetailsProvider.sectionDetailModel
                                              .result?.stopTime ??
                                          0) ==
                                      0)
                              ? Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 18, 20, 0),
                                  child: InkWell(
                                    onTap: () {
                                      openPlayer(
                                          "Video",
                                          (videoDetailsProvider.sectionDetailModel.result?.id ??
                                              0),
                                          (videoDetailsProvider
                                                  .sectionDetailModel
                                                  .result
                                                  ?.videoType ??
                                              0),
                                          widget.typeId,
                                          (videoDetailsProvider
                                                  .sectionDetailModel
                                                  .result
                                                  ?.video ??
                                              ""),
                                          (videoDetailsProvider
                                                  .sectionDetailModel
                                                  .result
                                                  ?.name ??
                                              ""),
                                          (videoDetailsProvider
                                                  .sectionDetailModel
                                                  .result
                                                  ?.videoUploadType ??
                                              ""),
                                          (videoDetailsProvider
                                                  .sectionDetailModel
                                                  .result
                                                  ?.videoUrl ??
                                              ""));
                                    },
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                      height: 50,
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      decoration: BoxDecoration(
                                        color: primaryDark,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          MyImage(
                                              width: 20,
                                              height: 20,
                                              imagePath: "ic_play.png"),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          MyText(
                                            color: white,
                                            text: watchNow,
                                            textalign: TextAlign.center,
                                            fontsize: 15,
                                            fontwaight: FontWeight.w600,
                                            maxline: 1,
                                            overflow: TextOverflow.ellipsis,
                                            fontstyle: FontStyle.normal,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          /* Continue Watching Button */
                          ((videoDetailsProvider.sectionDetailModel.result
                                              ?.stopTime ??
                                          0) >
                                      0 &&
                                  videoDetailsProvider.sectionDetailModel.result
                                          ?.videoDuration !=
                                      null)
                              ? Container(
                                  height: 55,
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 18, 20, 0),
                                  decoration: BoxDecoration(
                                    color: primaryDark,
                                    borderRadius: BorderRadius.circular(5),
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
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            MyImage(
                                                width: 20,
                                                height: 20,
                                                imagePath: "ic_play.png"),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                MyText(
                                                  color: white,
                                                  text: continueWatching,
                                                  textalign: TextAlign.start,
                                                  fontsize: 15,
                                                  fontwaight: FontWeight.w600,
                                                  maxline: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontstyle: FontStyle.normal,
                                                ),
                                                MyText(
                                                  color: white,
                                                  text:
                                                      "${Utils.remainTimeInMin(((videoDetailsProvider.sectionDetailModel.result?.videoDuration ?? 0) - (videoDetailsProvider.sectionDetailModel.result?.stopTime ?? 0)).abs())} $left",
                                                  textalign: TextAlign.start,
                                                  fontsize: 12,
                                                  fontwaight: FontWeight.normal,
                                                  maxline: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontstyle: FontStyle.normal,
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
                                )
                              : const SizedBox.shrink(),
                          /* Subscription Button */
                          ((videoDetailsProvider.sectionDetailModel.result
                                              ?.isPremium ??
                                          0) ==
                                      1 &&
                                  ((videoDetailsProvider.sectionDetailModel
                                              .result?.isBuy ??
                                          0) ==
                                      0))
                              ? (videoDetailsProvider.sectionDetailModel.result
                                              ?.rentBuy ??
                                          0) ==
                                      0
                                  ? Container(
                                      height: 55,
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.fromLTRB(
                                          20, 18, 20, 0),
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: MyText(
                                        color: black,
                                        text: "$watchWith ${Constant.appName}",
                                        textalign: TextAlign.center,
                                        fontsize: 15,
                                        fontwaight: FontWeight.w600,
                                        maxline: 1,
                                        overflow: TextOverflow.ellipsis,
                                        fontstyle: FontStyle.normal,
                                      ),
                                    )
                                  : const SizedBox.shrink()
                              : const SizedBox.shrink(),
                          /* Rent Button */
                          ((videoDetailsProvider.sectionDetailModel.result
                                              ?.isPremium ??
                                          0) ==
                                      1 &&
                                  ((videoDetailsProvider.sectionDetailModel
                                                  .result?.isRent ??
                                              0) ==
                                          1 &&
                                      (videoDetailsProvider.sectionDetailModel
                                                  .result?.rentBuy ??
                                              0) ==
                                          0))
                              ? Container(
                                  height: 55,
                                  width: MediaQuery.of(context).size.width,
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 11, 20, 0),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: MyText(
                                    color: black,
                                    text:
                                        "$rentMovieAtJust ${Constant.currencySymbol}${videoDetailsProvider.sectionDetailModel.result?.rentPrice ?? 0}",
                                    textalign: TextAlign.center,
                                    fontsize: 15,
                                    fontwaight: FontWeight.w600,
                                    maxline: 1,
                                    overflow: TextOverflow.ellipsis,
                                    fontstyle: FontStyle.normal,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          /* Included Features buttons */
                          Container(
                            width: MediaQuery.of(context).size.width,
                            constraints: const BoxConstraints(minHeight: 0),
                            margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /* Start Over */
                                ((videoDetailsProvider.sectionDetailModel.result
                                                    ?.stopTime ??
                                                0) >
                                            0 &&
                                        videoDetailsProvider.sectionDetailModel
                                                .result?.videoDuration !=
                                            null)
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: Constant.featureSize,
                                            height: Constant.featureSize,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: primaryLight,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Constant.featureSize / 2),
                                            ),
                                            child: MyImage(
                                              width: Constant.featureIconSize,
                                              height: Constant.featureIconSize,
                                              color: lightGray,
                                              imagePath: "restart.png",
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          MyText(
                                            color: white,
                                            text: startOver,
                                            fontsize: 12,
                                            fontwaight: FontWeight.normal,
                                            maxline: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textalign: TextAlign.center,
                                            fontstyle: FontStyle.normal,
                                          ),
                                        ],
                                      )
                                    : /* Trailer */
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: Constant.featureSize,
                                            height: Constant.featureSize,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: primaryLight,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Constant.featureSize / 2),
                                            ),
                                            child: MyImage(
                                              width: Constant.featureIconSize,
                                              height: Constant.featureIconSize,
                                              color: lightGray,
                                              imagePath: "ic_borderplay.png",
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          MyText(
                                            color: white,
                                            text: trailer,
                                            fontsize: 12,
                                            fontwaight: FontWeight.normal,
                                            maxline: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textalign: TextAlign.center,
                                            fontstyle: FontStyle.normal,
                                          ),
                                        ],
                                      ),
                                /* Download */
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: Constant.featureSize,
                                      height: Constant.featureSize,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: primaryLight,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            Constant.featureSize / 2),
                                      ),
                                      child: MyImage(
                                        width: Constant.featureIconSize,
                                        height: Constant.featureIconSize,
                                        color: lightGray,
                                        imagePath: "ic_download.png",
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    MyText(
                                      color: white,
                                      text: download,
                                      fontsize: 12,
                                      fontwaight: FontWeight.normal,
                                      maxline: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal,
                                    ),
                                  ],
                                ),
                                /* Watchlist */
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        log("isBookmark ====> ${videoDetailsProvider.sectionDetailModel.result?.isBookmark ?? 0}");
                                        videoDetailsProvider.setBookMark(
                                          context,
                                          widget.typeId,
                                          widget.videoType,
                                          widget.videoId,
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(
                                          Constant.featureSize / 2),
                                      child: Container(
                                        width: Constant.featureSize,
                                        height: Constant.featureSize,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: primaryLight,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              Constant.featureSize / 2),
                                        ),
                                        child: Consumer<VideoDetailsProvider>(
                                          builder: (context,
                                              videoDetailsProvider, child) {
                                            return MyImage(
                                              width: Constant.featureIconSize,
                                              height: Constant.featureIconSize,
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
                                      text: watchlist,
                                      fontsize: 12,
                                      fontwaight: FontWeight.normal,
                                      maxline: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal,
                                    ),
                                  ],
                                ),
                                /* More */
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: Constant.featureSize,
                                      height: Constant.featureSize,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: primaryLight,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            Constant.featureSize / 2),
                                      ),
                                      child: MyImage(
                                        width: Constant.featureIconSize,
                                        height: Constant.featureIconSize,
                                        color: lightGray,
                                        imagePath: "ic_moreborder.png",
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    MyText(
                                      color: white,
                                      text: more,
                                      fontsize: 12,
                                      fontwaight: FontWeight.normal,
                                      maxline: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          /* Description, IMDb, Languages & Subtitles */
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  constraints:
                                      const BoxConstraints(minHeight: 0),
                                  alignment: Alignment.centerLeft,
                                  child: ExpandableText(
                                    videoDetailsProvider.sectionDetailModel
                                            .result?.description ??
                                        "",
                                    expandText: more,
                                    collapseText: less_,
                                    maxLines: 3,
                                    linkColor: white,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                      color: white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                Row(
                                  children: [
                                    MyImage(
                                      width: 50,
                                      height: 23,
                                      imagePath: "imdb.png",
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    MyText(
                                      color: otherColor,
                                      text:
                                          "${videoDetailsProvider.sectionDetailModel.result?.imdbRating ?? 0}",
                                      textalign: TextAlign.start,
                                      fontwaight: FontWeight.w600,
                                      fontsize: 14,
                                      maxline: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontstyle: FontStyle.normal,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(4),
                                  onTap: () {
                                    log("Tapped on : $languages_");
                                    log("language Length ====> ${videoDetailsProvider.sectionDetailModel.language?.length ?? 0}");
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
                                            buildLangSubtitleDialog(
                                                videoDetailsProvider
                                                    .sectionDetailModel
                                                    .language),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    constraints:
                                        const BoxConstraints(minHeight: 30),
                                    child: Row(
                                      children: [
                                        MyText(
                                          color: white,
                                          text: languages_,
                                          textalign: TextAlign.center,
                                          fontwaight: FontWeight.normal,
                                          fontsize: 13,
                                          maxline: 1,
                                          overflow: TextOverflow.ellipsis,
                                          fontstyle: FontStyle.normal,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        MyText(
                                          color: white,
                                          text:
                                              "$audio (${videoDetailsProvider.sectionDetailModel.language?.length ?? 0}), $subtitle (0)",
                                          textalign: TextAlign.center,
                                          fontwaight: FontWeight.normal,
                                          fontsize: 13,
                                          maxline: 1,
                                          overflow: TextOverflow.ellipsis,
                                          fontstyle: FontStyle.normal,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        MyImage(
                                          width: 7,
                                          height: 7,
                                          imagePath: "ic_dropdown.png",
                                          color: lightGray,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /* Customers also watched */
                          (videoDetailsProvider
                                          .sectionDetailModel.getRelatedVideo !=
                                      null &&
                                  (videoDetailsProvider.sectionDetailModel
                                              .getRelatedVideo?.length ??
                                          0) >
                                      0)
                              ? Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 55,
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      alignment: Alignment.bottomLeft,
                                      child: MyText(
                                        color: white,
                                        text: customersAlsoWatched,
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
                                      height: getDynamicHeight(
                                        "${videoDetailsProvider.sectionDetailModel.result?.videoType ?? ""}",
                                        "landscape",
                                      ),
                                      child: ListView.separated(
                                        itemCount: 5,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          width: 5,
                                        ),
                                        itemBuilder: (BuildContext context,
                                            int postion) {
                                          /* video_type =>  1-video,  2-show,  3-language,  4-category */
                                          /* screen_layout =>  landscape, potrait, square */
                                          return landscape(videoDetailsProvider
                                              .sectionDetailModel
                                              .getRelatedVideo);
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          /* Cast & Crew */
                          (videoDetailsProvider.sectionDetailModel.cast !=
                                      null &&
                                  (videoDetailsProvider.sectionDetailModel.cast
                                              ?.length ??
                                          0) >
                                      0)
                              ? Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 55,
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      alignment: Alignment.bottomLeft,
                                      child: MyText(
                                        color: white,
                                        text: castAndCrew,
                                        textalign: TextAlign.center,
                                        fontsize: 16,
                                        maxline: 1,
                                        fontwaight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis,
                                        fontstyle: FontStyle.normal,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: MyText(
                                              color: otherColor,
                                              text: detailsFrom,
                                              textalign: TextAlign.center,
                                              fontsize: 13,
                                              fontwaight: FontWeight.normal,
                                              maxline: 1,
                                              overflow: TextOverflow.ellipsis,
                                              fontstyle: FontStyle.normal,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            padding: const EdgeInsets.fromLTRB(
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
                                              text: "IMDb",
                                              textalign: TextAlign.center,
                                              fontsize: 12,
                                              fontwaight: FontWeight.w500,
                                              maxline: 1,
                                              overflow: TextOverflow.ellipsis,
                                              fontstyle: FontStyle.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    AlignedGridView.count(
                                      shrinkWrap: true,
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 8,
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, bottom: 15),
                                      itemCount: videoDetailsProvider
                                              .sectionDetailModel
                                              .cast
                                              ?.length ??
                                          0,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int position) {
                                        return InkWell(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                          child: Stack(
                                            alignment: Alignment.bottomCenter,
                                            clipBehavior: Clip.antiAlias,
                                            children: <Widget>[
                                              SizedBox(
                                                height: Constant.heightCast,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Constant.cardRadius),
                                                  child: MyNetworkImage(
                                                    imageUrl: videoDetailsProvider
                                                            .sectionDetailModel
                                                            .cast
                                                            ?.elementAt(
                                                                position)
                                                            .image ??
                                                        Constant
                                                            .userPlaceholder,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: Constant.heightCast,
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
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: MyText(
                                                  text: videoDetailsProvider
                                                          .sectionDetailModel
                                                          .cast
                                                          ?.elementAt(position)
                                                          .name ??
                                                      "",
                                                  fontstyle: FontStyle.normal,
                                                  fontsize: 12,
                                                  maxline: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontwaight: FontWeight.normal,
                                                  textalign: TextAlign.center,
                                                  color: white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 0.7,
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            color: primaryColor,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          /* Director */
                          (directorList != null &&
                                  (directorList?.length ?? 0) > 0)
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  constraints: BoxConstraints(
                                      minHeight: Constant.heightCast),
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.bottomCenter,
                                        clipBehavior: Clip.antiAlias,
                                        children: <Widget>[
                                          SizedBox(
                                            height: Constant.heightCast,
                                            width: Constant.widthCast,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Constant.cardRadius),
                                              child: MyNetworkImage(
                                                imageUrl: directorList
                                                        ?.elementAt(0)
                                                        .image ??
                                                    Constant.userPlaceholder,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(0),
                                            width: Constant.widthCast,
                                            height: Constant.heightCast,
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
                                              text: directorList
                                                      ?.elementAt(0)
                                                      .name ??
                                                  "",
                                              fontstyle: FontStyle.normal,
                                              fontsize: 12,
                                              maxline: 3,
                                              overflow: TextOverflow.ellipsis,
                                              fontwaight: FontWeight.normal,
                                              textalign: TextAlign.center,
                                              color: white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            MyText(
                                              color: white,
                                              text: directors,
                                              textalign: TextAlign.start,
                                              fontsize: 14,
                                              fontwaight: FontWeight.w600,
                                              maxline: 1,
                                              overflow: TextOverflow.ellipsis,
                                              fontstyle: FontStyle.normal,
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            MyText(
                                              color: otherColor,
                                              text: directorList
                                                      ?.elementAt(0)
                                                      .personalInfo ??
                                                  "",
                                              textalign: TextAlign.start,
                                              fontsize: 13,
                                              fontwaight: FontWeight.normal,
                                              maxline: 7,
                                              overflow: TextOverflow.ellipsis,
                                              fontstyle: FontStyle.normal,
                                            ),
                                          ],
                                        ),
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
          );
        } else {
          return const NoData();
        }
      } else {
        return const NoData();
      }
    }
  }

  double getDynamicHeight(String? videoType, String? layoutType) {
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

  Widget buildLangSubtitleDialog(List<Language>? languageList) {
    log("languageList Size ===> ${languageList?.length ?? 0}");
    String? audioLanguages;
    if ((languageList?.length ?? 0) > 0) {
      for (int i = 0; i < (languageList?.length ?? 0); i++) {
        if (i == 0) {
          audioLanguages = languageList?.elementAt(i).name ?? "";
        } else {
          audioLanguages =
              "$audioLanguages, ${languageList?.elementAt(i).name ?? ""}";
        }
      }
    }
    return Container(
      padding: const EdgeInsets.all(22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MyText(
            text: availableLanguages,
            fontsize: 17,
            fontstyle: FontStyle.normal,
            fontwaight: FontWeight.bold,
            maxline: 1,
            overflow: TextOverflow.ellipsis,
            textalign: TextAlign.start,
            color: white,
          ),
          const SizedBox(
            height: 5,
          ),
          MyText(
            text: languageChangeNote,
            fontsize: 13,
            fontstyle: FontStyle.normal,
            fontwaight: FontWeight.normal,
            maxline: 1,
            overflow: TextOverflow.ellipsis,
            textalign: TextAlign.start,
            color: otherColor,
          ),
          const SizedBox(
            height: 10,
          ),
          MyText(
            text: audio,
            fontsize: 17,
            fontstyle: FontStyle.normal,
            fontwaight: FontWeight.bold,
            maxline: 1,
            overflow: TextOverflow.ellipsis,
            textalign: TextAlign.start,
            color: white,
          ),
          const SizedBox(
            height: 2,
          ),
          MyText(
            text: audioLanguages ?? "-",
            fontsize: 13,
            fontstyle: FontStyle.normal,
            fontwaight: FontWeight.normal,
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
            text: subtitle,
            fontsize: 17,
            fontstyle: FontStyle.normal,
            fontwaight: FontWeight.bold,
            maxline: 1,
            overflow: TextOverflow.ellipsis,
            textalign: TextAlign.start,
            color: white,
          ),
          const SizedBox(
            height: 2,
          ),
          MyText(
            text: "-",
            fontsize: 13,
            fontstyle: FontStyle.normal,
            fontwaight: FontWeight.normal,
            maxline: 1,
            overflow: TextOverflow.ellipsis,
            textalign: TextAlign.start,
            color: otherColor,
          ),
        ],
      ),
    );
  }

  Widget landscape(List<GetRelatedVideo>? relatedDataList) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: Constant.heightLand,
      child: ListView.separated(
        itemCount: relatedDataList?.length ?? 0,
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MovieDetails(
                      relatedDataList?.elementAt(index).id ?? 0,
                      relatedDataList?.elementAt(index).videoType ?? 0,
                      relatedDataList?.elementAt(index).typeId ?? 0,
                    );
                  },
                ),
              );
            },
            child: Container(
              width: Constant.widthLand,
              height: Constant.heightLand,
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: MyNetworkImage(
                  imageUrl:
                      relatedDataList?.elementAt(index).landscape.toString() ??
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
    );
  }

  Widget portrait(List<GetRelatedVideo>? relatedDataList) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: Constant.heightPort,
      child: ListView.separated(
        itemCount: relatedDataList?.length ?? 0,
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MovieDetails(
                      relatedDataList?.elementAt(index).id ?? 0,
                      relatedDataList?.elementAt(index).videoType ?? 0,
                      relatedDataList?.elementAt(index).typeId ?? 0,
                    );
                  },
                ),
              );
            },
            child: Container(
              width: Constant.widthPort,
              height: Constant.heightPort,
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: MyNetworkImage(
                  imageUrl:
                      relatedDataList?.elementAt(index).thumbnail.toString() ??
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
    );
  }

  Widget square(List<GetRelatedVideo>? relatedDataList) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: Constant.heightSquare,
      child: ListView.separated(
        itemCount: relatedDataList?.length ?? 0,
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MovieDetails(
                      relatedDataList?.elementAt(index).id ?? 0,
                      relatedDataList?.elementAt(index).videoType ?? 0,
                      relatedDataList?.elementAt(index).typeId ?? 0,
                    );
                  },
                ),
              );
            },
            child: Container(
              width: Constant.widthSquare,
              height: Constant.heightSquare,
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: MyNetworkImage(
                  imageUrl:
                      relatedDataList?.elementAt(index).thumbnail.toString() ??
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
    );
  }

  void openPlayer(String playType, int vID, int vType, int vTypeID, String vUrl,
      String vTitle, String vUploadType, String vVideoUrl) {
    log("===>vUploadType $vUploadType");
    if (vUploadType == "youtube") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return YoutubeVideo(
              videoUrl: vVideoUrl,
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
              url: vVideoUrl,
            );
          },
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return PlayerPage(MediaQuery.of(context).size.height, vID, vType,
                vTypeID, vUrl, vTitle);
          },
        ),
      );
    }
  }
}
