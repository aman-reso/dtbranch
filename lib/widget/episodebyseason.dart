import 'dart:developer';

import 'package:dtlive/model/sectiondetailmodel.dart';
import 'package:dtlive/pages/loginsocial.dart';
import 'package:dtlive/subscription/subscription.dart';
import 'package:dtlive/model/episodebyseasonmodel.dart' as episode;
import 'package:dtlive/provider/episodeprovider.dart';
import 'package:dtlive/provider/showdetailsprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/dimens.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/pages/player_pod.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class EpisodeBySeason extends StatefulWidget {
  final int? videoId, typeId, seasonPos;
  final List<Session>? seasonList;
  final Result? sectionDetails;
  const EpisodeBySeason(this.videoId, this.typeId, this.seasonPos,
      this.seasonList, this.sectionDetails,
      {Key? key})
      : super(key: key);

  @override
  State<EpisodeBySeason> createState() => _EpisodeBySeasonState();
}

class _EpisodeBySeasonState extends State<EpisodeBySeason> {
  late EpisodeProvider episodeProvider;
  late ShowDetailsProvider showDetailsProvider;
  String? finalVUrl = "";
  Map<String, String> qualityUrlList = <String, String>{};

  @override
  void initState() {
    episodeProvider = Provider.of<EpisodeProvider>(context, listen: false);
    showDetailsProvider =
        Provider.of<ShowDetailsProvider>(context, listen: false);
    getAllEpisode();
    super.initState();
  }

  getAllEpisode() async {
    debugPrint("seasonPos =====EpisodeBySeason=======> ${widget.seasonPos}");
    debugPrint("videoId =====EpisodeBySeason=======> ${widget.videoId}");
    await episodeProvider.getEpisodeBySeason(
        widget.seasonList?[(widget.seasonPos ?? 0)].id ?? 0, widget.videoId);
    await showDetailsProvider
        .setEpisodeBySeason(episodeProvider.episodeBySeasonModel);
    Future.delayed(const Duration(seconds: 1)).then((value) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlignedGridView.count(
      shrinkWrap: true,
      crossAxisCount: 1,
      crossAxisSpacing: 0,
      mainAxisSpacing: 4,
      itemCount: episodeProvider.episodeBySeasonModel.result?.length ?? 0,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return ExpandableNotifier(
          child: Container(
            color: lightBlack,
            child: ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                  tapBodyToExpand: true,
                ),
                collapsed: Container(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  constraints: const BoxConstraints(minHeight: 60),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(16),
                            focusColor: gray.withOpacity(0.5),
                            onTap: () async {
                              debugPrint("===> index $index");
                              _onTapEpisodePlay(index);
                            },
                            child: Container(
                              width: 32,
                              height: 32,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: MyImage(
                                  fit: BoxFit.cover,
                                  height: 32,
                                  width: 32,
                                  imagePath: "play.png",
                                ),
                              ),
                            ),
                          ),
                          (episodeProvider.episodeBySeasonModel.result?[index]
                                          .videoDuration !=
                                      null &&
                                  (episodeProvider.episodeBySeasonModel
                                              .result?[index].stopTime ??
                                          0) >
                                      0)
                              ? Container(
                                  height: 2,
                                  width: 32,
                                  margin: const EdgeInsets.only(top: 8),
                                  child: LinearPercentIndicator(
                                    padding: const EdgeInsets.all(0),
                                    barRadius: const Radius.circular(2),
                                    lineHeight: 2,
                                    percent: Utils.getPercentage(
                                        episodeProvider.episodeBySeasonModel
                                                .result?[index].videoDuration ??
                                            0,
                                        episodeProvider.episodeBySeasonModel
                                                .result?[index].stopTime ??
                                            0),
                                    backgroundColor: secProgressColor,
                                    progressColor: primaryColor,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            MyText(
                              color: white,
                              text: episodeProvider.episodeBySeasonModel
                                      .result?[index].description ??
                                  "",
                              textalign: TextAlign.start,
                              fontsizeNormal: 13,
                              fontsizeWeb: 15,
                              multilanguage: false,
                              fontweight: FontWeight.w500,
                              maxline: 2,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal,
                            ),
                            const SizedBox(height: 5),
                            MyText(
                              color: primaryColor,
                              text: ((episodeProvider.episodeBySeasonModel
                                              .result?[index].videoDuration ??
                                          0) >
                                      0)
                                  ? Utils.convertToColonText(episodeProvider
                                          .episodeBySeasonModel
                                          .result?[index]
                                          .videoDuration ??
                                      0)
                                  : "-",
                              textalign: TextAlign.start,
                              fontsizeNormal: 12,
                              fontsizeWeb: 12,
                              fontweight: FontWeight.bold,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MyNetworkImage(
                      fit: BoxFit.fill,
                      imgHeight: Dimens.epiPoster,
                      imgWidth: MediaQuery.of(context).size.width,
                      imageUrl: (episodeProvider
                              .episodeBySeasonModel.result?[index].landscape ??
                          ""),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: MyText(
                        color: white,
                        text: episodeProvider.episodeBySeasonModel
                                .result?[index].description ??
                            "",
                        textalign: TextAlign.start,
                        fontstyle: FontStyle.normal,
                        fontsizeNormal: 13,
                        fontsizeWeb: 14,
                        maxline: 5,
                        overflow: TextOverflow.ellipsis,
                        fontweight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          MyText(
                            color: otherColor,
                            text: ((episodeProvider.episodeBySeasonModel
                                            .result?[index].videoDuration ??
                                        0) >
                                    0)
                                ? Utils.convertTimeToText(episodeProvider
                                        .episodeBySeasonModel
                                        .result?[index]
                                        .videoDuration ??
                                    0)
                                : "-",
                            textalign: TextAlign.start,
                            fontsizeNormal: 13,
                            fontsizeWeb: 14,
                            fontweight: FontWeight.w600,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            fontstyle: FontStyle.normal,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: MyText(
                              color: primaryColor,
                              text: "primetag",
                              textalign: TextAlign.start,
                              fontsizeNormal: 12,
                              fontsizeWeb: 14,
                              multilanguage: true,
                              fontweight: FontWeight.w700,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Expandable(
                    collapsed: collapsed,
                    expanded: expanded,
                    theme: const ExpandableThemeData(crossFadePoint: 0),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  _onTapEpisodePlay(index) async {
    final showDetailsProvider =
        Provider.of<ShowDetailsProvider>(context, listen: false);
    final episodeProvider =
        Provider.of<EpisodeProvider>(context, listen: false);
    if (Constant.userID != null) {
      if ((showDetailsProvider.sectionDetailModel.result?.isPremium ?? 0) ==
          1) {
        if ((showDetailsProvider.sectionDetailModel.result?.isBuy ?? 0) == 1 ||
            (showDetailsProvider.sectionDetailModel.result?.rentBuy ?? 0) ==
                1) {
          openPlayer(
              "Show", index, episodeProvider.episodeBySeasonModel.result);
        } else {
          if (Constant.userID != null) {
            if (kIsWeb) {
              Utils.showSnackbar(
                  context, "info", webPaymentNotAvailable, false);
              return;
            }
            dynamic isSubscribed = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const Subscription();
                },
              ),
            );
            if (isSubscribed != null && isSubscribed == true) {
              await showDetailsProvider.getSectionDetails(
                  widget.typeId,
                  showDetailsProvider.sectionDetailModel.result?.videoType ?? 0,
                  widget.videoId);
              getAllEpisode();
            }
          } else {
            if (kIsWeb) {
              Utils.buildWebAlertDialog(context, "login", "");
              return false;
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
        }
      } else if ((showDetailsProvider.sectionDetailModel.result?.isPremium ??
              0) ==
          1) {
        if ((showDetailsProvider.sectionDetailModel.result?.isBuy ?? 0) == 1 ||
            (showDetailsProvider.sectionDetailModel.result?.rentBuy ?? 0) ==
                1) {
          return true;
        } else {
          if (kIsWeb) {
            Utils.showSnackbar(context, "info", webPaymentNotAvailable, false);
            return false;
          }
          dynamic isSubscribed = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const Subscription();
              },
            ),
          );
          if (isSubscribed != null && isSubscribed == true) {
            await showDetailsProvider.getSectionDetails(
                widget.typeId,
                showDetailsProvider.sectionDetailModel.result?.videoType ?? 0,
                widget.videoId);
            getAllEpisode();
          }
          return false;
        }
      } else if ((showDetailsProvider.sectionDetailModel.result?.isRent ?? 0) ==
          1) {
        if ((showDetailsProvider.sectionDetailModel.result?.isBuy ?? 0) == 1 ||
            (showDetailsProvider.sectionDetailModel.result?.rentBuy ?? 0) ==
                1) {
          openPlayer(
              "Show", index, episodeProvider.episodeBySeasonModel.result);
        } else {
          if (Constant.userID != null) {
            if (kIsWeb) {
              Utils.showSnackbar(
                  context, "info", webPaymentNotAvailable, false);
              return;
            }
            dynamic isRented = await Utils.paymentForRent(
                context: context,
                videoId: widget.videoId.toString(),
                vTitle: showDetailsProvider.sectionDetailModel.result?.name
                    .toString(),
                vType: showDetailsProvider.sectionDetailModel.result?.videoType
                    .toString(),
                typeId: widget.typeId.toString(),
                rentPrice: showDetailsProvider
                    .sectionDetailModel.result?.rentPrice
                    .toString());
            if (isRented != null && isRented == true) {
              await showDetailsProvider.getSectionDetails(
                  widget.typeId,
                  showDetailsProvider.sectionDetailModel.result?.videoType ?? 0,
                  widget.videoId);
              getAllEpisode();
            }
          } else {
            if (kIsWeb) {
              Utils.buildWebAlertDialog(context, "login", "");
              return false;
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
        }
      } else {
        openPlayer("Show", index, episodeProvider.episodeBySeasonModel.result);
      }
    } else {
      if (kIsWeb) {
        Utils.buildWebAlertDialog(context, "login", "");
        return false;
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
  }

  void openPlayer(
      String playType, int epiPos, List<episode.Result>? episodeList) async {
    final showDetailsProvider =
        Provider.of<ShowDetailsProvider>(context, listen: false);
    if ((episodeList?.length ?? 0) > 0) {
      int? epiID = (episodeList?[epiPos].id ?? 0);
      int? vType =
          (showDetailsProvider.sectionDetailModel.result?.videoType ?? 0);
      int? vTypeID = widget.typeId;
      int? stopTime = (episodeList?[epiPos].stopTime ?? 0);
      String? vUploadType = (episodeList?[epiPos].videoUploadType ?? "");
      String? videoThumb = (episodeList?[epiPos].landscape ?? "");
      String? epiUrl = (episodeList?[epiPos].video320 ?? "");
      String? vSubtitle = (episodeList?[epiPos].subtitle ?? "");
      log("epiID ========> $epiID");
      log("vType ========> $vType");
      log("vTypeID ======> $vTypeID");
      log("stopTime =====> $stopTime");
      log("vUploadType ==> $vUploadType");
      log("videoThumb ==> $videoThumb");
      log("epiUrl =======> $epiUrl");
      log("vSubtitle ====> $vSubtitle");

      if (!mounted) return;
      var isContinue = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return PlayerPod(
              "Show",
              epiID,
              vType,
              vTypeID,
              epiUrl,
              vSubtitle,
              stopTime,
              vUploadType,
              videoThumb,
            );
          },
        ),
      );
      log("isContinue ===> $isContinue");
      if (isContinue != null && isContinue == true) {
        getAllEpisode();
      }

      // if (episodeList?[epiPos].videoUploadType == "youtube") {
      //   if (!mounted) return;
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) {
      //         return PlayerYoutube(
      //           videoUrl: episodeList?[epiPos].videoUrl,
      //         );
      //       },
      //     ),
      //   );
      // } else if (episodeList?[epiPos].videoUploadType == "vimeo") {
      //   if (!mounted) return;
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) {
      //         return PlayerVimeo(
      //           url: episodeList?[epiPos].videoUrl,
      //         );
      //       },
      //     ),
      //   );
      // } else {
      //   if (!mounted) return;
      //   var isContinue = await Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) {
      //         return PlayerPod(
      //           playType,
      //           epiID,
      //           vType,
      //           vTypeID,
      //           epiUrl,
      //           vSubtitle,
      //           stopTime,
      //           vUploadType,
      //           videoThumb,
      //         );
      //       },
      //     ),
      //   );
      //   log("isContinue ===> $isContinue");
      //   if (isContinue != null && isContinue == true) {
      //     getAllEpisode();
      //   }
      // }
    }
  }
}
