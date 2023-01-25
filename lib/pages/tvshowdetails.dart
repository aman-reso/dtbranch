import 'dart:developer';

import 'package:dtlive/model/sectiondetailmodel.dart';
import 'package:dtlive/model/episodebyseasonmodel.dart' as episode;
import 'package:dtlive/widget/nodata.dart';
import 'package:dtlive/pages/player.dart';
import 'package:dtlive/pages/vimeoplayer.dart';
import 'package:dtlive/pages/youtubevideo.dart';
import 'package:dtlive/provider/episodeprovider.dart';
import 'package:dtlive/provider/showdetailsprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/widget/episodebyseason.dart';
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

class TvShowDetails extends StatefulWidget {
  final int videoId, videoType, typeId;
  const TvShowDetails(this.videoId, this.videoType, this.typeId, {Key? key})
      : super(key: key);

  @override
  State<TvShowDetails> createState() => TvShowDetailsState();
}

class TvShowDetailsState extends State<TvShowDetails> {
  List<Cast>? directorList;
  ShowDetailsProvider showDetailsProvider = ShowDetailsProvider();
  EpisodeProvider episodeProvider = EpisodeProvider();

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
    showDetailsProvider =
        Provider.of<ShowDetailsProvider>(context, listen: false);
    episodeProvider = Provider.of<EpisodeProvider>(context, listen: false);
    await showDetailsProvider.getSectionDetails(
        widget.typeId, widget.videoType, widget.videoId);
    Future.delayed(Duration.zero).then((value) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    showDetailsProvider.clearProvider();
    episodeProvider.clearProvider();
  }

  @override
  Widget build(BuildContext context) {
    final showDetailsProvider =
        Provider.of<ShowDetailsProvider>(context, listen: false);
    if (showDetailsProvider.sectionDetailModel.cast != null &&
        (showDetailsProvider.sectionDetailModel.cast?.length ?? 0) > 0) {
      directorList = <Cast>[];
      for (int i = 0;
          i < (showDetailsProvider.sectionDetailModel.cast?.length ?? 0);
          i++) {
        if (showDetailsProvider.sectionDetailModel.cast?.elementAt(i).type ==
            "Director") {
          Cast cast = Cast();
          cast.id =
              showDetailsProvider.sectionDetailModel.cast?.elementAt(i).id ?? 0;
          cast.name =
              showDetailsProvider.sectionDetailModel.cast?.elementAt(i).name ??
                  "";
          cast.image =
              showDetailsProvider.sectionDetailModel.cast?.elementAt(i).image ??
                  "";
          cast.type =
              showDetailsProvider.sectionDetailModel.cast?.elementAt(i).type ??
                  "";
          cast.personalInfo = showDetailsProvider.sectionDetailModel.cast
                  ?.elementAt(i)
                  .personalInfo ??
              "";
          cast.status = showDetailsProvider.sectionDetailModel.cast
                  ?.elementAt(i)
                  .status ??
              "";
          cast.createdAt = showDetailsProvider.sectionDetailModel.cast
                  ?.elementAt(i)
                  .createdAt ??
              "";
          cast.updatedAt = showDetailsProvider.sectionDetailModel.cast
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
        child: !showDetailsProvider.loading
            ? (showDetailsProvider.sectionDetailModel.status == 200 &&
                    showDetailsProvider.sectionDetailModel.result != null)
                ? SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        /* Poster */
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: Constant.detailPoster,
                              color: white,
                              child: MyNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: (showDetailsProvider
                                                .sectionDetailModel
                                                .result
                                                ?.landscape
                                                .toString() ??
                                            "")
                                        .isNotEmpty
                                    ? (showDetailsProvider.sectionDetailModel
                                            .result?.landscape ??
                                        Constant.placeHolderLand)
                                    : (showDetailsProvider.sectionDetailModel
                                            .result?.thumbnail ??
                                        Constant.placeHolderLand),
                              ),
                            ),
                            Container(
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
                                    "Show",
                                    (showDetailsProvider
                                            .sectionDetailModel.result?.id ??
                                        0),
                                    (showDetailsProvider.sectionDetailModel
                                            .result?.videoType ??
                                        0),
                                    widget.typeId,
                                    0,
                                    showDetailsProvider
                                        .episodeBySeasonModel.result,
                                    (showDetailsProvider
                                            .sectionDetailModel.result?.name ??
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
                                constraints:
                                    const BoxConstraints(minHeight: 85),
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                                          imageUrl: showDetailsProvider
                                                      .sectionDetailModel
                                                      .result
                                                      ?.thumbnail !=
                                                  ""
                                              ? (showDetailsProvider
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
                                            text: showDetailsProvider
                                                    .sectionDetailModel
                                                    .result
                                                    ?.name ??
                                                "",
                                            multilanguage: false,
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
                                              (showDetailsProvider
                                                              .sectionDetailModel
                                                              .result
                                                              ?.releaseYear !=
                                                          null &&
                                                      showDetailsProvider
                                                              .sectionDetailModel
                                                              .result
                                                              ?.releaseYear !=
                                                          "")
                                                  ? Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      child: MyText(
                                                        color: whiteLight,
                                                        text: showDetailsProvider
                                                                .sectionDetailModel
                                                                .result
                                                                ?.releaseYear ??
                                                            "",
                                                        textalign:
                                                            TextAlign.center,
                                                        fontsize: 13,
                                                        multilanguage: false,
                                                        fontwaight:
                                                            FontWeight.normal,
                                                        maxline: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontstyle:
                                                            FontStyle.normal,
                                                      ),
                                                    )
                                                  : const SizedBox.shrink(),
                                              /* Duration */
                                              (showDetailsProvider
                                                          .sectionDetailModel
                                                          .result
                                                          ?.videoDuration !=
                                                      null)
                                                  ? Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      child: MyText(
                                                        color: otherColor,
                                                        text: ((showDetailsProvider
                                                                        .sectionDetailModel
                                                                        .result
                                                                        ?.videoDuration ??
                                                                    0) >
                                                                0)
                                                            ? Utils.convertTimeToText(
                                                                showDetailsProvider
                                                                        .sectionDetailModel
                                                                        .result
                                                                        ?.videoDuration ??
                                                                    0)
                                                            : "",
                                                        textalign:
                                                            TextAlign.center,
                                                        fontsize: 13,
                                                        fontwaight:
                                                            FontWeight.normal,
                                                        maxline: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontstyle:
                                                            FontStyle.normal,
                                                      ),
                                                    )
                                                  : const SizedBox.shrink(),
                                              /* Age Limit */
                                              (showDetailsProvider
                                                              .sectionDetailModel
                                                              .result
                                                              ?.ageRestriction !=
                                                          null &&
                                                      showDetailsProvider
                                                              .sectionDetailModel
                                                              .result
                                                              ?.ageRestriction !=
                                                          "")
                                                  ? Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 1, 5, 1),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: otherColor,
                                                          width: .7,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        shape:
                                                            BoxShape.rectangle,
                                                      ),
                                                      child: MyText(
                                                        color: otherColor,
                                                        text: showDetailsProvider
                                                                .sectionDetailModel
                                                                .result
                                                                ?.ageRestriction ??
                                                            "",
                                                        textalign:
                                                            TextAlign.center,
                                                        fontsize: 10,
                                                        multilanguage: false,
                                                        fontwaight:
                                                            FontWeight.normal,
                                                        maxline: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontstyle:
                                                            FontStyle.normal,
                                                      ),
                                                    )
                                                  : const SizedBox.shrink(),
                                              /* MaxQuality */
                                              (showDetailsProvider
                                                              .sectionDetailModel
                                                              .result
                                                              ?.maxVideoQuality !=
                                                          null &&
                                                      showDetailsProvider
                                                              .sectionDetailModel
                                                              .result
                                                              ?.maxVideoQuality !=
                                                          "")
                                                  ? Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 1, 5, 1),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: otherColor,
                                                          width: .7,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        shape:
                                                            BoxShape.rectangle,
                                                      ),
                                                      child: MyText(
                                                        color: otherColor,
                                                        text: showDetailsProvider
                                                                .sectionDetailModel
                                                                .result
                                                                ?.maxVideoQuality ??
                                                            "",
                                                        textalign:
                                                            TextAlign.center,
                                                        fontsize: 10,
                                                        multilanguage: false,
                                                        fontwaight:
                                                            FontWeight.normal,
                                                        maxline: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontstyle:
                                                            FontStyle.normal,
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
                              const SizedBox(
                                height: 15,
                              ),

                              /* Season Title */
                              (showDetailsProvider.sectionDetailModel.session !=
                                          null &&
                                      (showDetailsProvider.sectionDetailModel
                                                  .session?.length ??
                                              0) >
                                          0)
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          onTap: () {
                                            log("session Length ====> ${showDetailsProvider.sectionDetailModel.session?.length ?? 0}");
                                            showModalBottomSheet(
                                              context: context,
                                              backgroundColor: lightBlack,
                                              isScrollControlled: true,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(0),
                                                ),
                                              ),
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              builder: (BuildContext context) {
                                                return Wrap(
                                                  children: <Widget>[
                                                    buildSeasonDialog(
                                                        showDetailsProvider
                                                                .sectionDetailModel
                                                                .result
                                                                ?.name ??
                                                            "",
                                                        showDetailsProvider
                                                            .sectionDetailModel
                                                            .session),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: SizedBox(
                                            height: 30,
                                            child: Row(
                                              children: [
                                                Consumer<ShowDetailsProvider>(
                                                  builder: (context,
                                                      showDetailsProvider,
                                                      child) {
                                                    return MyText(
                                                      color: white,
                                                      text: showDetailsProvider
                                                              .sectionDetailModel
                                                              .session
                                                              ?.elementAt(
                                                                  showDetailsProvider
                                                                      .seasonPos)
                                                              .name ??
                                                          "",
                                                      textalign:
                                                          TextAlign.center,
                                                      multilanguage: false,
                                                      fontwaight:
                                                          FontWeight.w600,
                                                      fontsize: 15,
                                                      maxline: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontstyle:
                                                          FontStyle.normal,
                                                    );
                                                  },
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                MyImage(
                                                  width: 12,
                                                  height: 12,
                                                  imagePath: "ic_dropdown.png",
                                                  color: lightGray,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),

                              /* Prime TAG  & Rent TAG */
                              (showDetailsProvider.sectionDetailModel.result
                                              ?.isPremium ??
                                          0) ==
                                      1
                                  ? Column(
                                      children: [
                                        /* Prime TAG */
                                        Container(
                                          margin: const EdgeInsets.only(top: 8),
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                                text: "primetag",
                                                textalign: TextAlign.start,
                                                fontsize: 16,
                                                multilanguage: true,
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
                                                text: "primetagdesc",
                                                textalign: TextAlign.center,
                                                fontsize: 12,
                                                multilanguage: true,
                                                fontwaight: FontWeight.normal,
                                                maxline: 1,
                                                overflow: TextOverflow.ellipsis,
                                                fontstyle: FontStyle.normal,
                                              ),
                                            ],
                                          ),
                                        ),

                                        /* Rent TAG */
                                        (showDetailsProvider.sectionDetailModel
                                                        .result?.isRent ??
                                                    0) ==
                                                1
                                            ? Container(
                                                margin: const EdgeInsets.only(
                                                    top: 8),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 0, 20, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 20,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            complimentryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        shape:
                                                            BoxShape.rectangle,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: MyText(
                                                        color: white,
                                                        text: Constant
                                                            .currencySymbol,
                                                        textalign:
                                                            TextAlign.center,
                                                        fontsize: 11,
                                                        fontwaight:
                                                            FontWeight.w800,
                                                        maxline: 1,
                                                        multilanguage: false,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontstyle:
                                                            FontStyle.normal,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: MyText(
                                                        color: white,
                                                        text: "renttag",
                                                        multilanguage: true,
                                                        textalign:
                                                            TextAlign.center,
                                                        fontsize: 12,
                                                        fontwaight:
                                                            FontWeight.normal,
                                                        maxline: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontstyle:
                                                            FontStyle.normal,
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
                              ((showDetailsProvider.sectionDetailModel.result
                                                  ?.isPremium ??
                                              0) ==
                                          0 &&
                                      (showDetailsProvider.sectionDetailModel
                                                  .result?.stopTime ??
                                              0) ==
                                          0)
                                  ? Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 0),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(5),
                                        onTap: () {
                                          openPlayer(
                                              "Show",
                                              (showDetailsProvider
                                                      .sectionDetailModel
                                                      .result
                                                      ?.id ??
                                                  0),
                                              (showDetailsProvider
                                                      .sectionDetailModel
                                                      .result
                                                      ?.videoType ??
                                                  0),
                                              widget.typeId,
                                              0,
                                              showDetailsProvider
                                                  .episodeBySeasonModel.result,
                                              (showDetailsProvider
                                                      .sectionDetailModel
                                                      .result
                                                      ?.name ??
                                                  ""));
                                        },
                                        child: Container(
                                          height: 50,
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 0, 20, 0),
                                          decoration: BoxDecoration(
                                            color: primaryDark,
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                                text: "watch_now",
                                                textalign: TextAlign.center,
                                                multilanguage: true,
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
                              ((showDetailsProvider.sectionDetailModel.result
                                                  ?.stopTime ??
                                              0) >
                                          0 &&
                                      showDetailsProvider.sectionDetailModel
                                              .result?.videoDuration !=
                                          null)
                                  ? Container(
                                      height: 55,
                                      margin: const EdgeInsets.fromLTRB(
                                          20, 18, 20, 0),
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
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    MyText(
                                                      color: white,
                                                      text: "continuewatching",
                                                      multilanguage: true,
                                                      textalign:
                                                          TextAlign.start,
                                                      fontsize: 15,
                                                      fontwaight:
                                                          FontWeight.w600,
                                                      maxline: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontstyle:
                                                          FontStyle.normal,
                                                    ),
                                                    MyText(
                                                      color: white,
                                                      multilanguage: false,
                                                      text:
                                                          "${Utils.remainTimeInMin(((showDetailsProvider.sectionDetailModel.result?.videoDuration ?? 0) - (showDetailsProvider.sectionDetailModel.result?.stopTime ?? 0)).abs())} left",
                                                      textalign:
                                                          TextAlign.start,
                                                      fontsize: 12,
                                                      fontwaight:
                                                          FontWeight.normal,
                                                      maxline: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontstyle:
                                                          FontStyle.normal,
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
                                            constraints: const BoxConstraints(
                                                minWidth: 0),
                                            margin: const EdgeInsets.all(3),
                                            child: LinearPercentIndicator(
                                              padding: const EdgeInsets.all(0),
                                              barRadius:
                                                  const Radius.circular(2),
                                              lineHeight: 4,
                                              percent: Utils.getPercentage(
                                                  showDetailsProvider
                                                          .sectionDetailModel
                                                          .result
                                                          ?.videoDuration ??
                                                      0,
                                                  showDetailsProvider
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
                              ((showDetailsProvider.sectionDetailModel.result
                                                  ?.isPremium ??
                                              0) ==
                                          1 &&
                                      ((showDetailsProvider.sectionDetailModel
                                                  .result?.isBuy ??
                                              0) ==
                                          0))
                                  ? (showDetailsProvider.sectionDetailModel
                                                  .result?.rentBuy ??
                                              0) ==
                                          0
                                      ? Container(
                                          height: 55,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.fromLTRB(
                                              20, 18, 20, 0),
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              MyText(
                                                color: black,
                                                text: "watchwith",
                                                textalign: TextAlign.center,
                                                fontsize: 15,
                                                multilanguage: true,
                                                fontwaight: FontWeight.w600,
                                                maxline: 1,
                                                overflow: TextOverflow.ellipsis,
                                                fontstyle: FontStyle.normal,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              MyText(
                                                color: black,
                                                text: "appname",
                                                textalign: TextAlign.center,
                                                fontsize: 15,
                                                multilanguage: true,
                                                fontwaight: FontWeight.w600,
                                                maxline: 1,
                                                overflow: TextOverflow.ellipsis,
                                                fontstyle: FontStyle.normal,
                                              ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox.shrink()
                                  : const SizedBox.shrink(),

                              /* Rent Button */
                              ((showDetailsProvider.sectionDetailModel.result
                                                  ?.isPremium ??
                                              0) ==
                                          1 &&
                                      ((showDetailsProvider.sectionDetailModel
                                                      .result?.isRent ??
                                                  0) ==
                                              1 &&
                                          (showDetailsProvider
                                                      .sectionDetailModel
                                                      .result
                                                      ?.rentBuy ??
                                                  0) ==
                                              0))
                                  ? Container(
                                      height: 55,
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.fromLTRB(
                                          20, 11, 20, 0),
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          MyText(
                                            color: black,
                                            text: "rentmovieatjust",
                                            textalign: TextAlign.center,
                                            fontsize: 15,
                                            fontwaight: FontWeight.w600,
                                            maxline: 1,
                                            multilanguage: true,
                                            overflow: TextOverflow.ellipsis,
                                            fontstyle: FontStyle.normal,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          MyText(
                                            color: black,
                                            text:
                                                "${Constant.currencySymbol}${showDetailsProvider.sectionDetailModel.result?.rentPrice ?? 0}",
                                            textalign: TextAlign.center,
                                            fontsize: 15,
                                            fontwaight: FontWeight.w600,
                                            maxline: 1,
                                            multilanguage: false,
                                            overflow: TextOverflow.ellipsis,
                                            fontstyle: FontStyle.normal,
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink(),

                              /* Included Features buttons */
                              Container(
                                width: MediaQuery.of(context).size.width,
                                constraints: const BoxConstraints(minHeight: 0),
                                margin:
                                    const EdgeInsets.fromLTRB(20, 30, 20, 0),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    /* Download */
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
                                          text: "download",
                                          multilanguage: true,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            log("isBookmark ====> ${showDetailsProvider.sectionDetailModel.result?.isBookmark ?? 0}");
                                            showDetailsProvider.setBookMark(
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
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Constant.featureSize / 2),
                                            ),
                                            child:
                                                Consumer<ShowDetailsProvider>(
                                              builder: (context,
                                                  showDetailsProvider, child) {
                                                return MyImage(
                                                  width:
                                                      Constant.featureIconSize,
                                                  height:
                                                      Constant.featureIconSize,
                                                  color: lightGray,
                                                  imagePath: (showDetailsProvider
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
                                          multilanguage: true,
                                          fontsize: 12,
                                          fontwaight: FontWeight.normal,
                                          maxline: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textalign: TextAlign.center,
                                          fontstyle: FontStyle.normal,
                                        ),
                                      ],
                                    ),

                                    /* Share */
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
                                            borderRadius: BorderRadius.circular(
                                                Constant.featureSize / 2),
                                          ),
                                          child: MyImage(
                                            width: Constant.featureIconSize,
                                            height: Constant.featureIconSize,
                                            color: lightGray,
                                            imagePath: "share.png",
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        MyText(
                                          color: white,
                                          text: "share",
                                          multilanguage: true,
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
                                margin:
                                    const EdgeInsets.fromLTRB(20, 30, 20, 0),
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
                                        showDetailsProvider.sectionDetailModel
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
                                              "${showDetailsProvider.sectionDetailModel.result?.imdbRating ?? 0}",
                                          textalign: TextAlign.start,
                                          fontwaight: FontWeight.w600,
                                          fontsize: 14,
                                          multilanguage: false,
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
                                        log("language Length ====> ${showDetailsProvider.sectionDetailModel.language?.length ?? 0}");
                                        showModalBottomSheet(
                                          context: context,
                                          backgroundColor: lightBlack,
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(0),
                                            ),
                                          ),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          builder: (BuildContext context) {
                                            return Wrap(
                                              children: <Widget>[
                                                buildLangSubtitleDialog(
                                                    showDetailsProvider
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
                                              text: "language_",
                                              multilanguage: true,
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
                                            Row(children: [
                                              MyText(
                                                color: white,
                                                text: "audios",
                                                multilanguage: true,
                                                textalign: TextAlign.center,
                                                fontwaight: FontWeight.normal,
                                                fontsize: 13,
                                                maxline: 1,
                                                overflow: TextOverflow.ellipsis,
                                                fontstyle: FontStyle.normal,
                                              ),
                                              const SizedBox(width: 5),
                                              MyText(
                                                color: white,
                                                text:
                                                    "(${showDetailsProvider.sectionDetailModel.language?.length ?? 0})",
                                                textalign: TextAlign.center,
                                                fontwaight: FontWeight.normal,
                                                fontsize: 13,
                                                multilanguage: false,
                                                maxline: 1,
                                                overflow: TextOverflow.ellipsis,
                                                fontstyle: FontStyle.normal,
                                              ),
                                              const SizedBox(width: 5),
                                              MyText(
                                                color: white,
                                                text: "subtitle",
                                                multilanguage: true,
                                                textalign: TextAlign.center,
                                                fontwaight: FontWeight.normal,
                                                fontsize: 13,
                                                maxline: 1,
                                                overflow: TextOverflow.ellipsis,
                                                fontstyle: FontStyle.normal,
                                              ),
                                            ]),
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

                              /* Episodes */
                              (showDetailsProvider.sectionDetailModel.session !=
                                          null &&
                                      (showDetailsProvider.sectionDetailModel
                                                  .session?.length ??
                                              0) >
                                          0)
                                  ? Column(
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 55,
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          alignment: Alignment.bottomLeft,
                                          child: MyText(
                                            color: white,
                                            text: "episodes",
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
                                        Container(
                                          padding: const EdgeInsets.all(0),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          constraints: const BoxConstraints(
                                              minHeight: 50),
                                          child: Consumer<ShowDetailsProvider>(
                                            builder: (context,
                                                showDetailsProvider, child) {
                                              return EpisodeBySeason(
                                                widget.videoId,
                                                widget.typeId,
                                                showDetailsProvider.seasonPos,
                                                showDetailsProvider
                                                    .sectionDetailModel.session,
                                                showDetailsProvider
                                                    .sectionDetailModel.result,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),

                              /* Customers also watched */
                              (showDetailsProvider.sectionDetailModel
                                              .getRelatedVideo !=
                                          null &&
                                      (showDetailsProvider.sectionDetailModel
                                                  .getRelatedVideo?.length ??
                                              0) >
                                          0)
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 0, 15, 0),
                                          child: MyText(
                                            color: white,
                                            text: "customer_also_watch",
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
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: getDynamicHeight(
                                            "${showDetailsProvider.sectionDetailModel.result?.videoType ?? ""}",
                                            "landscape",
                                          ),
                                          child: ListView.separated(
                                            itemCount: 5,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                              width: 5,
                                            ),
                                            itemBuilder: (BuildContext context,
                                                int postion) {
                                              /* video_type =>  1-video,  2-show,  3-language,  4-category */
                                              /* screen_layout =>  landscape, potrait, square */
                                              return landscape(
                                                  showDetailsProvider
                                                      .sectionDetailModel
                                                      .getRelatedVideo);
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),

                              /* Cast & Crew */
                              (showDetailsProvider.sectionDetailModel.cast !=
                                          null &&
                                      (showDetailsProvider.sectionDetailModel
                                                  .cast?.length ??
                                              0) >
                                          0)
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 0, 15, 0),
                                          child: MyText(
                                            color: white,
                                            text: "castandcrew",
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
                                                  text: "detailsfrom",
                                                  multilanguage: true,
                                                  textalign: TextAlign.center,
                                                  fontsize: 13,
                                                  fontwaight: FontWeight.normal,
                                                  maxline: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontstyle: FontStyle.normal,
                                                ),
                                              ),
                                              Container(
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
                                                  text: "IMDb",
                                                  textalign: TextAlign.center,
                                                  fontsize: 12,
                                                  multilanguage: false,
                                                  fontwaight: FontWeight.w500,
                                                  maxline: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                          itemCount: showDetailsProvider
                                                  .sectionDetailModel
                                                  .cast
                                                  ?.length ??
                                              0,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int position) {
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
                                                alignment:
                                                    Alignment.bottomCenter,
                                                clipBehavior: Clip.antiAlias,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: Constant.heightCast,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Constant
                                                                  .cardRadius),
                                                      child: MyNetworkImage(
                                                        imageUrl: showDetailsProvider
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
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: Constant.heightCast,
                                                    decoration:
                                                        const BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: Alignment.center,
                                                        end: Alignment
                                                            .bottomCenter,
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
                                                      text: showDetailsProvider
                                                              .sectionDetailModel
                                                              .cast
                                                              ?.elementAt(
                                                                  position)
                                                              .name ??
                                                          "",
                                                      fontstyle:
                                                          FontStyle.normal,
                                                      fontsize: 12,
                                                      maxline: 3,
                                                      multilanguage: false,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontwaight:
                                                          FontWeight.normal,
                                                      textalign:
                                                          TextAlign.center,
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
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                        Constant
                                                            .userPlaceholder,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(0),
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
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: MyText(
                                                  text: directorList
                                                          ?.elementAt(0)
                                                          .name ??
                                                      "",
                                                  fontstyle: FontStyle.normal,
                                                  fontsize: 12,
                                                  multilanguage: false,
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
                                                  text: "directors",
                                                  multilanguage: true,
                                                  textalign: TextAlign.start,
                                                  fontsize: 14,
                                                  fontwaight: FontWeight.w600,
                                                  maxline: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                  multilanguage: false,
                                                  fontsize: 13,
                                                  fontwaight: FontWeight.normal,
                                                  maxline: 7,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                  )
                : const NoData()
            : Utils.pageLoader(),
      ),
    );
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
            text: "avalablelanguage",
            fontsize: 17,
            multilanguage: true,
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
            text: "languagechangenote",
            fontsize: 13,
            fontstyle: FontStyle.normal,
            fontwaight: FontWeight.normal,
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
            fontsize: 17,
            fontstyle: FontStyle.normal,
            fontwaight: FontWeight.bold,
            multilanguage: true,
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
            text: "subtitle",
            fontsize: 17,
            fontstyle: FontStyle.normal,
            fontwaight: FontWeight.bold,
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

  Widget buildSeasonDialog(String? vTitle, List<Session>? seasonList) {
    log("seasonList Size ===> ${seasonList?.length ?? 0}");
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MyText(
            text: vTitle ?? "",
            fontsize: 16,
            fontstyle: FontStyle.normal,
            fontwaight: FontWeight.bold,
            maxline: 1,
            multilanguage: false,
            overflow: TextOverflow.ellipsis,
            textalign: TextAlign.start,
            color: white,
          ),
          const SizedBox(
            height: 13,
          ),
          AlignedGridView.count(
            shrinkWrap: true,
            crossAxisCount: 1,
            crossAxisSpacing: 0,
            mainAxisSpacing: 4,
            itemCount: seasonList?.length ?? 0,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  log("SeasonID ====> ${(seasonList?.elementAt(index).id ?? 0)}");
                  final detailsProvider =
                      Provider.of<ShowDetailsProvider>(context, listen: false);
                  Navigator.pop(context);
                  detailsProvider.setSeasonPosition(index);
                  getAllEpisode(detailsProvider.seasonPos,
                      detailsProvider.sectionDetailModel.session);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: MyText(
                    text: seasonList?.elementAt(index).name ?? "-",
                    fontsize: 15,
                    fontstyle: FontStyle.normal,
                    fontwaight: FontWeight.w500,
                    multilanguage: false,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.start,
                    color: white,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> getAllEpisode(int position, List<Session>? seasonList) async {
    final episodeProvider =
        Provider.of<EpisodeProvider>(context, listen: false);
    await episodeProvider.getEpisodeBySeason(
        seasonList?.elementAt(position).id ?? 0, widget.videoId);
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
                    return TvShowDetails(
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
                clipBehavior: Clip.antiAliasWithSaveLayer,
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
                    return TvShowDetails(
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
                clipBehavior: Clip.antiAliasWithSaveLayer,
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
                    return TvShowDetails(
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
                clipBehavior: Clip.antiAliasWithSaveLayer,
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

  void openPlayer(String playType, int vID, int vType, int vTypeID, int epiPos,
      List<episode.Result>? episodeList, String vTitle) {
    if ((episodeList?.length ?? 0) > 0) {
      log("===vUploadType ${episodeList?.elementAt(epiPos).videoUploadType}");
      if (episodeList?.elementAt(epiPos).videoUploadType == "youtube") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return YoutubeVideo(
                videoUrl: episodeList?.elementAt(epiPos).videoUrl,
              );
            },
          ),
        );
      } else if (episodeList?.elementAt(epiPos).videoUploadType == "vimeo") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return VimeoPlayerPage(
                url: episodeList?.elementAt(epiPos).videoUrl,
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
                  vTypeID, episodeList?.elementAt(epiPos).video ?? "", vTitle);
            },
          ),
        );
      }
    }
  }
}
