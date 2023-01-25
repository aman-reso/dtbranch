import 'package:dtlive/model/sectiondetailmodel.dart';
import 'package:dtlive/pages/player.dart';
import 'package:dtlive/pages/vimeoplayer.dart';
import 'package:dtlive/model/episodebyseasonmodel.dart' as episode;
import 'package:dtlive/pages/youtubevideo.dart';
import 'package:dtlive/provider/episodeprovider.dart';
import 'package:dtlive/provider/showdetailsprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class EpisodeBySeason extends StatefulWidget {
  final int videoId, typeId, seasonPos;
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
  EpisodeProvider episodeProvider = EpisodeProvider();
  String? finalVUrl = "";
  Map<String, String> qualityUrlList = <String, String>{};

  @override
  void initState() {
    getAllEpisode();
    super.initState();
  }

  getAllEpisode() async {
    debugPrint("seasonPos =====EpisodeBySeason=======> ${widget.seasonPos}");
    debugPrint("videoId =====EpisodeBySeason=======> ${widget.videoId}");
    final showDetailsProvider =
        Provider.of<ShowDetailsProvider>(context, listen: false);
    episodeProvider = Provider.of<EpisodeProvider>(context, listen: false);
    await episodeProvider.getEpisodeBySeason(
        widget.seasonList?.elementAt(widget.seasonPos).id ?? 0, widget.videoId);
    showDetailsProvider.episodeBySeasonModel =
        episodeProvider.episodeBySeasonModel;
    Future.delayed(Duration.zero).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final showDetailsProvider =
        Provider.of<ShowDetailsProvider>(context, listen: false);
    final episodeProvider =
        Provider.of<EpisodeProvider>(context, listen: false);
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
                      InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          debugPrint("===> index $index");
                          openPlayer(
                              "Show",
                              (showDetailsProvider
                                      .sectionDetailModel.result?.id ??
                                  0),
                              (showDetailsProvider
                                      .sectionDetailModel.result?.videoType ??
                                  0),
                              widget.typeId,
                              index,
                              episodeProvider.episodeBySeasonModel.result,
                              (showDetailsProvider
                                      .sectionDetailModel.result?.name ??
                                  ""));
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.centerLeft,
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
                              text: episodeProvider.episodeBySeasonModel
                                      .result?[index].description ??
                                  "",
                              textalign: TextAlign.start,
                              fontsize: 15,
                              multilanguage: false,
                              fontwaight: FontWeight.normal,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
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
                              fontsize: 13,
                              fontwaight: FontWeight.bold,
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
                      imgHeight: Constant.epiPoster,
                      imgWidth: MediaQuery.of(context).size.width,
                      imageUrl: episodeProvider.episodeBySeasonModel
                                  .result?[index].landscape !=
                              ""
                          ? (episodeProvider.episodeBySeasonModel.result?[index]
                                  .landscape ??
                              Constant.placeHolderLand)
                          : Constant.placeHolderLand,
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
                        fontsize: 14,
                        maxline: 5,
                        overflow: TextOverflow.ellipsis,
                        fontwaight: FontWeight.normal,
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
                            fontsize: 14,
                            fontwaight: FontWeight.normal,
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
                              fontsize: 14,
                              multilanguage: true,
                              fontwaight: FontWeight.w700,
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

  void openPlayer(String playType, int vID, int vType, int vTypeID, int epiPos,
      List<episode.Result>? episodeList, String vTitle) {
    if ((episodeList?.length ?? 0) > 0) {
      debugPrint(
          "vUploadType ===> ${episodeList?.elementAt(epiPos).videoUploadType}");
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
