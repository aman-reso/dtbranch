import 'dart:developer';
import 'dart:io';

import 'package:dtlive/model/taskinfomodel.dart';
import 'package:dtlive/pages/moviedetails.dart';
import 'package:dtlive/pages/tvshowdetails.dart';
import 'package:dtlive/provider/videodownloadprovider.dart';
import 'package:dtlive/provider/videodetailsprovider.dart';
import 'package:dtlive/shimmer/shimmerutils.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/dimens.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/widget/nodata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:social_share/social_share.dart';

class MyDownloads extends StatefulWidget {
  const MyDownloads({Key? key}) : super(key: key);

  @override
  State<MyDownloads> createState() => _MyDownloadsState();
}

class _MyDownloadsState extends State<MyDownloads> {
  late VideoDownloadProvider downloadProvider;
  List<TaskInfo>? myDownloadsList;

  @override
  void initState() {
    downloadProvider =
        Provider.of<VideoDownloadProvider>(context, listen: false);
    _getData();
    super.initState();
  }

  _getData() async {
    myDownloadsList = await downloadProvider.getDownloadsByType("video");
    log("myDownloadsList =================> ${myDownloadsList?.length}");
    Future.delayed(Duration.zero).then((value) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    downloadProvider.clearProvider();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: Utils.myAppBarWithBack(context, "downloads", true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 12, bottom: 8),
            child: Consumer<VideoDownloadProvider>(
              builder: (context, downloadProvider, child) {
                if (downloadProvider.loading) {
                  return Expanded(
                      child: ShimmerUtils.buildDownloadShimmer(context, 10));
                } else {
                  if (myDownloadsList != null) {
                    if ((myDownloadsList?.length ?? 0) > 0) {
                      return Expanded(
                        child: AlignedGridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 1,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 8,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: myDownloadsList?.length ?? 0,
                          itemBuilder: (BuildContext context, int position) {
                            return _buildDownloadItem(position);
                          },
                        ),
                      );
                    } else {
                      return const NoData(title: 'no_downloads', subTitle: '');
                    }
                  } else {
                    return const NoData(title: 'no_downloads', subTitle: '');
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadItem(position) {
    return Container(
      width: MediaQuery.of(context).size.width,
      constraints: BoxConstraints(
        minHeight: Dimens.heightWatchlist,
      ),
      color: lightBlack,
      child: Row(
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: Dimens.heightWatchlist,
              maxWidth: MediaQuery.of(context).size.width * 0.44,
            ),
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  constraints: BoxConstraints(
                    minHeight: Dimens.heightWatchlist,
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(0),
                    onTap: () {
                      log("Clicked on position ==> $position");
                      if ((myDownloadsList?[position].videoType ?? 0) == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MovieDetails(
                                myDownloadsList?[position].id ?? 0,
                                myDownloadsList?[position].videoType ?? 0,
                                myDownloadsList?[position].typeId ?? 0,
                              );
                            },
                          ),
                        );
                      } else if ((myDownloadsList?[position].videoType ?? 0) ==
                          2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return TvShowDetails(
                                myDownloadsList?[position].id ?? 0,
                                myDownloadsList?[position].videoType ?? 0,
                                myDownloadsList?[position].typeId ?? 0,
                              );
                            },
                          ),
                        );
                      }
                    },
                    child: MyNetworkImage(
                      imageUrl: myDownloadsList?[position].landscapeImg ?? "",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                minHeight: Dimens.heightWatchlist,
                maxWidth: MediaQuery.of(context).size.width * 0.66,
              ),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /* Title */
                        MyText(
                          color: white,
                          text: myDownloadsList?[position].name ?? "",
                          textalign: TextAlign.start,
                          maxline: 2,
                          overflow: TextOverflow.ellipsis,
                          fontsizeNormal: 13,
                          fontweight: FontWeight.w600,
                          fontstyle: FontStyle.normal,
                        ),
                        const SizedBox(height: 3),
                        /* Release Year & Video Duration */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            (myDownloadsList?[position].releaseYear != null &&
                                    (myDownloadsList?[position].releaseYear ??
                                            "") !=
                                        "")
                                ? Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    child: MyText(
                                      color: otherColor,
                                      text: myDownloadsList?[position]
                                              .releaseYear ??
                                          "",
                                      maxline: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textalign: TextAlign.start,
                                      fontsizeNormal: 12,
                                      fontweight: FontWeight.w500,
                                      fontstyle: FontStyle.normal,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            (myDownloadsList?[position].videoType ?? 0) != 2
                                ? (myDownloadsList?[position].videoDuration !=
                                            null &&
                                        (myDownloadsList?[position]
                                                    .videoDuration ??
                                                0) >
                                            0)
                                    ? Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        child: MyText(
                                          color: otherColor,
                                          text: Utils.convertInMin(
                                              myDownloadsList?[position]
                                                      .videoDuration ??
                                                  0),
                                          textalign: TextAlign.start,
                                          maxline: 1,
                                          overflow: TextOverflow.ellipsis,
                                          fontsizeNormal: 12,
                                          fontweight: FontWeight.w500,
                                          fontstyle: FontStyle.normal,
                                        ),
                                      )
                                    : const SizedBox.shrink()
                                : const SizedBox.shrink(),
                          ],
                        ),
                        const SizedBox(height: 6),
                        /* Prime TAG  & Rent TAG */
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /* Prime TAG */
                            (myDownloadsList?[position].isPremium ?? 0) == 1
                                ? MyText(
                                    color: primaryColor,
                                    text: "primetag",
                                    multilanguage: true,
                                    textalign: TextAlign.start,
                                    fontsizeNormal: 10,
                                    fontweight: FontWeight.w800,
                                    maxline: 1,
                                    overflow: TextOverflow.ellipsis,
                                    fontstyle: FontStyle.normal,
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(height: 3),
                            /* Rent TAG */
                            (myDownloadsList?[position].isRent ?? 0) == 1
                                ? MyText(
                                    color: white,
                                    text: "renttag",
                                    multilanguage: true,
                                    textalign: TextAlign.start,
                                    fontsizeNormal: 11,
                                    fontweight: FontWeight.w500,
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
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: InkWell(
                      onTap: () {
                        _buildVideoMoreDialog(position);
                      },
                      child: Container(
                        width: 25,
                        height: 25,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(6),
                        child: MyImage(
                          width: 18,
                          height: 18,
                          imagePath: "ic_more.png",
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
  }

  _buildVideoMoreDialog(position) {
    showModalBottomSheet(
      context: context,
      backgroundColor: lightBlack,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
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
                    text: myDownloadsList?[position].name ?? "",
                    multilanguage: false,
                    fontsizeNormal: 18,
                    color: white,
                    fontstyle: FontStyle.normal,
                    fontweight: FontWeight.w700,
                    maxline: 2,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.start,
                  ),
                  const SizedBox(height: 5),
                  /* Release year, Video duration & Comment Icon */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (myDownloadsList?[position].releaseYear ?? "").isNotEmpty
                          ? Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: MyText(
                                color: otherColor,
                                text: myDownloadsList?[position].releaseYear ??
                                    "",
                                maxline: 1,
                                overflow: TextOverflow.ellipsis,
                                textalign: TextAlign.center,
                                fontsizeNormal: 12,
                                fontweight: FontWeight.w500,
                                fontstyle: FontStyle.normal,
                              ),
                            )
                          : const SizedBox.shrink(),
                      (myDownloadsList?[position].videoType ?? 0) != 2
                          ? (myDownloadsList?[position].videoDuration != null &&
                                  (myDownloadsList?[position].videoDuration ??
                                          0) >
                                      0)
                              ? Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: MyText(
                                    color: otherColor,
                                    text: Utils.convertInMin(
                                        myDownloadsList?[position]
                                                .videoDuration ??
                                            0),
                                    textalign: TextAlign.center,
                                    maxline: 1,
                                    overflow: TextOverflow.ellipsis,
                                    fontsizeNormal: 12,
                                    fontweight: FontWeight.w500,
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
                  const SizedBox(height: 8),
                  /* Prime TAG  & Rent TAG */
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* Prime TAG */
                      (myDownloadsList?[position].isPremium ?? 0) == 1
                          ? MyText(
                              color: primaryColor,
                              text: "primetag",
                              multilanguage: true,
                              textalign: TextAlign.start,
                              fontsizeNormal: 12,
                              fontweight: FontWeight.w800,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal,
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(height: 5),
                      /* Rent TAG */
                      (myDownloadsList?[position].isRent ?? 0) == 1
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
                                    fontsizeNormal: 10,
                                    multilanguage: false,
                                    fontweight: FontWeight.w800,
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
                                  fontsizeNormal: 12,
                                  fontweight: FontWeight.w500,
                                  maxline: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontstyle: FontStyle.normal,
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  const SizedBox(height: 12),

                  /* Watch Now / Resume */
                  ((myDownloadsList?[position].videoType ?? 0) != 2)
                      ? InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () async {
                            Navigator.pop(context);
                            openPlayer(position);
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
                                  imagePath: "ic_play.png",
                                  fit: BoxFit.contain,
                                  color: otherColor,
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: MyText(
                                    text: "watch_now",
                                    multilanguage: true,
                                    fontsizeNormal: 14,
                                    color: white,
                                    fontstyle: FontStyle.normal,
                                    fontweight: FontWeight.w600,
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
                  ((myDownloadsList?[position].videoType ?? 0) != 2)
                      ? InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () async {
                            Navigator.pop(context);
                            await Utils.openPlayer(
                                context: context,
                                playType: "Trailer",
                                videoId: myDownloadsList?[position].id ?? 0,
                                videoType:
                                    myDownloadsList?[position].videoType ?? 0,
                                typeId: myDownloadsList?[position].typeId ?? 0,
                                videoUrl: "",
                                trailerUrl:
                                    myDownloadsList?[position].trailerUrl ?? "",
                                uploadType: myDownloadsList?[position]
                                        .videoUploadType ??
                                    "",
                                videoThumb:
                                    myDownloadsList?[position].landscapeImg ??
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
                                const SizedBox(width: 20),
                                Expanded(
                                  child: MyText(
                                    text: "watch_trailer",
                                    multilanguage: true,
                                    fontsizeNormal: 14,
                                    color: white,
                                    fontstyle: FontStyle.normal,
                                    fontweight: FontWeight.w600,
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

                  /* Download Add/Delete */
                  ((myDownloadsList?[position].videoType ?? 0) != 2)
                      ? InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () async {
                            if (myDownloadsList?[position].isDownload == 1) {
                              List<TaskInfo>? dummyDownloadsList =
                                  myDownloadsList;
                              final videoDetailsProvider =
                                  Provider.of<VideoDetailsProvider>(context,
                                      listen: false);
                              myDownloadsList?.removeAt(position);
                              setState(() {});
                              Navigator.pop(context);
                              await videoDetailsProvider.setDownloadComplete(
                                  context,
                                  dummyDownloadsList?[position].id,
                                  dummyDownloadsList?[position].videoType,
                                  dummyDownloadsList?[position].typeId);
                              await downloadProvider.checkVideoInSecure(
                                  dummyDownloadsList,
                                  dummyDownloadsList?[position].id.toString() ??
                                      "");
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
                                  imagePath:
                                      myDownloadsList?[position].isDownload == 1
                                          ? "ic_delete.png"
                                          : "ic_download.png",
                                  fit: BoxFit.contain,
                                  color: otherColor,
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: MyText(
                                    text:
                                        myDownloadsList?[position].isDownload ==
                                                1
                                            ? "delete_download"
                                            : "download",
                                    multilanguage: true,
                                    fontsizeNormal: 14,
                                    color: white,
                                    fontstyle: FontStyle.normal,
                                    fontweight: FontWeight.w600,
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
                              fontsizeNormal: 14,
                              color: white,
                              fontstyle: FontStyle.normal,
                              fontweight: FontWeight.w600,
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
                      if ((myDownloadsList?[position].videoType ?? 0) == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MovieDetails(
                                myDownloadsList?[position].id ?? 0,
                                myDownloadsList?[position].videoType ?? 0,
                                myDownloadsList?[position].typeId ?? 0,
                              );
                            },
                          ),
                        );
                      } else if ((myDownloadsList?[position].videoType ?? 0) ==
                          2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return TvShowDetails(
                                myDownloadsList?[position].id ?? 0,
                                myDownloadsList?[position].videoType ?? 0,
                                myDownloadsList?[position].typeId ?? 0,
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
                          const SizedBox(width: 20),
                          Expanded(
                            child: MyText(
                              text: "view_details",
                              multilanguage: true,
                              fontsizeNormal: 14,
                              color: white,
                              fontstyle: FontStyle.normal,
                              fontweight: FontWeight.w600,
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
                    text: "",
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
                      Container(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: Utils.setBGWithBorder(
                            transparentColor, otherColor, 3, 0.7),
                        child: MyText(
                          text: "",
                          multilanguage: false,
                          fontsizeNormal: 10,
                          color: otherColor,
                          fontstyle: FontStyle.normal,
                          fontweight: FontWeight.w500,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          textalign: TextAlign.start,
                        ),
                      ),
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
                            'sms:?body=${Uri.encodeComponent("Hey! I'm watching ${/* downloadProvider.watchlistModel.result?[position].name ??  */ ""}. Check it out now on ${Constant.appName}! \nhttps://play.google.com/store/apps/details?id=${Constant.appPackageName} \n")}');
                      } else if (Platform.isIOS) {
                        Utils.redirectToUrl(
                            'sms:&body=${Uri.encodeComponent("Hey! I'm watching ${/* downloadProvider.watchlistModel.result?[position].name ?? */ ""}. Check it out now on ${Constant.appName}! \nhttps://apps.apple.com/us/app/${Constant.appName?.toLowerCase()}/${Constant.appPackageName} \n")}');
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
                              fontweight: FontWeight.w500,
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
                          ? "Hey! I'm watching ${/* downloadProvider.watchlistModel.result?[position].name ?? */ ""}. Check it out now on ${Constant.appName}! \nhttps://apps.apple.com/us/app/${Constant.appName?.toLowerCase()}/${Constant.appPackageName} \n"
                          : "Hey! I'm watching ${/* downloadProvider.watchlistModel.result?[position].name ?? */ ""}. Check it out now on ${Constant.appName}! \nhttps://play.google.com/store/apps/details?id=${Constant.appPackageName} \n");
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
                              fontweight: FontWeight.w500,
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
                            ? "Hey! I'm watching ${/* downloadProvider.watchlistModel.result?[position].name ?? */ ""}. Check it out now on ${Constant.appName}! \nhttps://apps.apple.com/us/app/${Constant.appName?.toLowerCase()}/${Constant.appPackageName} \n"
                            : "Hey! I'm watching ${/* downloadProvider.watchlistModel.result?[position].name ?? */ ""}. Check it out now on ${Constant.appName}! \nhttps://play.google.com/store/apps/details?id=${Constant.appPackageName} \n",
                      ).then((data) {
                        debugPrint(data);
                        Utils.showSnackbar(
                            context, "success", "link_copied", true);
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
                              fontweight: FontWeight.w500,
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
                          ? "Hey! I'm watching ${/* downloadProvider.watchlistModel.result?[position].name ?? */ ""}. Check it out now on ${Constant.appName}! \nhttps://apps.apple.com/us/app/${Constant.appName?.toLowerCase()}/${Constant.appPackageName} \n"
                          : "Hey! I'm watching ${/* downloadProvider.watchlistModel.result?[position].name ?? */ ""}. Check it out now on ${Constant.appName}! \nhttps://play.google.com/store/apps/details?id=${Constant.appPackageName} \n");
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
                              fontweight: FontWeight.w500,
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

  openPlayer(position) async {
    Utils.openPlayer(
      context: context,
      playType: "Download",
      videoId: myDownloadsList?[position].id ?? 0,
      videoType: myDownloadsList?[position].videoType ?? 0,
      typeId: myDownloadsList?[position].typeId ?? 0,
      videoUrl: myDownloadsList?[position].savedFile ?? "",
      trailerUrl: myDownloadsList?[position].trailerUrl ?? "",
      uploadType: myDownloadsList?[position].videoUploadType ?? "",
      videoThumb: myDownloadsList?[position].landscapeImg ?? "",
      vSubtitle: "",
      vStopTime: 0,
    );
  }
}
