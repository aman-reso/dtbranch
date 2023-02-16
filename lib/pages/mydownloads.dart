import 'dart:developer';
import 'dart:io';

import 'package:dtlive/provider/downloadprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/dimens.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:dtlive/widget/mytext.dart';
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
  late DownloadProvider downloadProvider;

  @override
  void initState() {
    downloadProvider = Provider.of<DownloadProvider>(context, listen: false);
    _getData();
    super.initState();
  }

  _getData() async {}

  @override
  void dispose() {
    downloadProvider.clearProvider();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: Utils.myAppBar(context, "downloads"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 12, bottom: 8),
            child: Consumer<DownloadProvider>(
              builder: (context, downloadProvider, child) {
                if (downloadProvider.loading) {
                  return Utils.pageLoader();
                } else {
                  /* if (downloadProvider.watchlistModel.status == 200 &&
                      downloadProvider.watchlistModel.result != null) {
                    if ((downloadProvider.watchlistModel.result?.length ?? 0) >
                        0) { */
                  return Expanded(
                    child: AlignedGridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 1,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 8,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int position) {
                        return _buildDownloadItem(position);
                      },
                    ),
                  );
                  /* } else {
                      return const NoData(
                        title: 'browse_now_watch_later',
                        subTitle: 'watchlist_note',
                      );
                    } */
                  /* } else {
                    return const NoData(
                      title: 'browse_now_watch_later',
                      subTitle: 'watchlist_note',
                    );
                  } */
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
                      // if ((downloadProvider
                      //             .watchlistModel.result?[position].videoType ??
                      //         0) ==
                      //     1) {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) {
                      //         return MovieDetails(
                      //           downloadProvider
                      //                   .watchlistModel.result?[position].id ??
                      //               0,
                      //           downloadProvider.watchlistModel
                      //                   .result?[position].videoType ??
                      //               0,
                      //           downloadProvider.watchlistModel
                      //                   .result?[position].typeId ??
                      //               0,
                      //         );
                      //       },
                      //     ),
                      //   );
                      // } else if ((downloadProvider
                      //             .watchlistModel.result?[position].videoType ??
                      //         0) ==
                      //     2) {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) {
                      //         return TvShowDetails(
                      //           downloadProvider
                      //                   .watchlistModel.result?[position].id ??
                      //               0,
                      //           downloadProvider.watchlistModel
                      //                   .result?[position].videoType ??
                      //               0,
                      //           downloadProvider.watchlistModel
                      //                   .result?[position].typeId ??
                      //               0,
                      //         );
                      //       },
                      //     ),
                      //   );
                      // }
                    },
                    child: MyNetworkImage(
                      imageUrl: "",
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
                          text: "",
                          textalign: TextAlign.start,
                          maxline: 2,
                          overflow: TextOverflow.ellipsis,
                          fontsizeNormal: 13,
                          fontweight: FontWeight.w600,
                          fontstyle: FontStyle.normal,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        /* Release Year & Video Duration */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /* (downloadProvider.watchlistModel.result?[position]
                                            .releaseYear !=
                                        null &&
                                    (downloadProvider
                                                .watchlistModel
                                                .result?[position]
                                                .releaseYear ??
                                            "") !=
                                        "")
                                ?  */
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: MyText(
                                color: otherColor,
                                text: /* downloadProvider.watchlistModel
                                              .result?[position].releaseYear ?? */
                                    "",
                                maxline: 1,
                                overflow: TextOverflow.ellipsis,
                                textalign: TextAlign.start,
                                fontsizeNormal: 12,
                                fontweight: FontWeight.normal,
                                fontstyle: FontStyle.normal,
                              ),
                            ) /* : const SizedBox.shrink() */,
                            /* (downloadProvider.watchlistModel.result?[position]
                                            .videoType ??
                                        0) !=
                                    2
                                ? (downloadProvider
                                                .watchlistModel
                                                .result?[position]
                                                .videoDuration !=
                                            null &&
                                        (downloadProvider
                                                    .watchlistModel
                                                    .result?[position]
                                                    .videoDuration ??
                                                0) >
                                            0)
                                    ?  */
                            Container(
                              margin: const EdgeInsets.only(right: 20),
                              child: MyText(
                                color: otherColor,
                                text: Utils.convertInMin(
                                    /* downloadProvider
                                                      .watchlistModel
                                                      .result?[position]
                                                      .videoDuration ?? */
                                    0),
                                textalign: TextAlign.start,
                                maxline: 1,
                                overflow: TextOverflow.ellipsis,
                                fontsizeNormal: 12,
                                fontweight: FontWeight.normal,
                                fontstyle: FontStyle.normal,
                              ),
                            ) /* 
                                    : const SizedBox.shrink()
                                : const SizedBox.shrink() */
                            ,
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        /* Prime TAG  & Rent TAG */
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /* Prime TAG */
                            /* (downloadProvider.watchlistModel.result?[position]
                                            .isPremium ??
                                        0) ==
                                    1
                                ?  */
                            MyText(
                              color: primaryColor,
                              text: "primetag",
                              multilanguage: true,
                              textalign: TextAlign.start,
                              fontsizeNormal: 10,
                              fontweight: FontWeight.w800,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal,
                            ) /* 
                                : const SizedBox.shrink() */
                            ,
                            const SizedBox(
                              height: 3,
                            ),
                            /* Rent TAG */
                            /* (downloadProvider.watchlistModel.result?[position]
                                            .isRent ??
                                        0) ==
                                    1
                                ?  */
                            MyText(
                              color: white,
                              text: "renttag",
                              multilanguage: true,
                              textalign: TextAlign.start,
                              fontsizeNormal: 11,
                              fontweight: FontWeight.w500,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal,
                            ) /* 
                                : const SizedBox.shrink() */
                            ,
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
                  /* Release year, Video duration & Comment Icon */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: MyText(
                          color: otherColor,
                          text: "",
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          textalign: TextAlign.center,
                          fontsizeNormal: 12,
                          fontweight: FontWeight.w500,
                          fontstyle: FontStyle.normal,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: MyText(
                          color: otherColor,
                          text: "",
                          textalign: TextAlign.center,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontsizeNormal: 12,
                          fontweight: FontWeight.w500,
                          fontstyle: FontStyle.normal,
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
                    height: 8,
                  ),
                  /* Prime TAG  & Rent TAG */
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* Prime TAG */
                      MyText(
                        color: primaryColor,
                        text: "primetag",
                        multilanguage: true,
                        textalign: TextAlign.start,
                        fontsizeNormal: 12,
                        fontweight: FontWeight.w800,
                        maxline: 1,
                        overflow: TextOverflow.ellipsis,
                        fontstyle: FontStyle.normal,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      /* Rent TAG */
                      Row(
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
                            fontweight: FontWeight.normal,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            fontstyle: FontStyle.normal,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),

                  /* Watch Now / Resume */
                  /* ((downloadProvider
                                  .watchlistModel.result?[position].videoType ??
                              0) !=
                          2)
                      ? */
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () async {
                      Navigator.pop(context);
                      openPlayer("Video", position);
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
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: MyText(
                              text: "watch_now",
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
                  ) /* : const SizedBox.shrink() */,

                  /* Add to Watchlist / Remove from Watchlist */
                  // InkWell(
                  //   borderRadius: BorderRadius.circular(5),
                  //   onTap: () async {
                  //     Navigator.pop(context);
                  //     log("isBookmark ====> ${downloadProvider.watchlistModel.result?[position].isBookmark ?? 0}");
                  //     if (Constant.userID != null) {
                  //       await downloadProvider.setBookMark(
                  //         context,
                  //         position,
                  //         downloadProvider
                  //                 .watchlistModel.result?[position].typeId ??
                  //             0,
                  //         downloadProvider
                  //                 .watchlistModel.result?[position].videoType ??
                  //             0,
                  //         downloadProvider
                  //                 .watchlistModel.result?[position].id ??
                  //             0,
                  //       );
                  //     } else {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) {
                  //             return const LoginSocial();
                  //           },
                  //         ),
                  //       );
                  //     }
                  //   },
                  //   child: Container(
                  //     height: Dimens.minHtDialogContent,
                  //     padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         MyImage(
                  //           width: Dimens.dialogIconSize,
                  //           height: Dimens.dialogIconSize,
                  //           imagePath: ((downloadProvider.watchlistModel
                  //                           .result?[position].isBookmark ??
                  //                       0) ==
                  //                   1)
                  //               ? "watchlist_remove.png"
                  //               : "ic_plus.png",
                  //           fit: BoxFit.contain,
                  //           color: otherColor,
                  //         ),
                  //         const SizedBox(
                  //           width: 20,
                  //         ),
                  //         Expanded(
                  //           child: MyText(
                  //             text: ((downloadProvider.watchlistModel
                  //                             .result?[position].isBookmark ??
                  //                         0) ==
                  //                     1)
                  //                 ? "remove_from_watchlist"
                  //                 : "add_to_watchlist",
                  //             multilanguage: true,
                  //             fontsizeNormal: 16,
                  //             color: white,
                  //             fontstyle: FontStyle.normal,
                  //             fontweight: FontWeight.normal,
                  //             maxline: 1,
                  //             overflow: TextOverflow.ellipsis,
                  //             textalign: TextAlign.start,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  /* Download Add/Delete */
                  /* ((downloadProvider
                                  .watchlistModel.result?[position].videoType ??
                              0) !=
                          2)
                      ?  */
                  InkWell(
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
                  ) /* : const SizedBox.shrink() */,

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

                  /* View Details */
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () async {
                      Navigator.pop(context);
                      log("Clicked on position :==> $position");
                      // if ((downloadProvider
                      //             .watchlistModel.result?[position].videoType ??
                      //         0) ==
                      //     1) {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) {
                      //         return MovieDetails(
                      //           downloadProvider
                      //                   .watchlistModel.result?[position].id ??
                      //               0,
                      //           downloadProvider.watchlistModel
                      //                   .result?[position].videoType ??
                      //               0,
                      //           downloadProvider.watchlistModel
                      //                   .result?[position].typeId ??
                      //               0,
                      //         );
                      //       },
                      //     ),
                      //   );
                      // } else if ((downloadProvider
                      //             .watchlistModel.result?[position].videoType ??
                      //         0) ==
                      //     2) {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) {
                      //         return TvShowDetails(
                      //           downloadProvider
                      //                   .watchlistModel.result?[position].id ??
                      //               0,
                      //           downloadProvider.watchlistModel
                      //                   .result?[position].videoType ??
                      //               0,
                      //           downloadProvider.watchlistModel
                      //                   .result?[position].typeId ??
                      //               0,
                      //         );
                      //       },
                      //     ),
                      //   );
                      // }
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
                          fontweight: FontWeight.normal,
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
                            ? "Hey! I'm watching ${/* downloadProvider.watchlistModel.result?[position].name ?? */ ""}. Check it out now on ${Constant.appName}! \nhttps://apps.apple.com/us/app/${Constant.appName?.toLowerCase()}/${Constant.appPackageName} \n"
                            : "Hey! I'm watching ${/* downloadProvider.watchlistModel.result?[position].name ?? */ ""}. Check it out now on ${Constant.appName}! \nhttps://play.google.com/store/apps/details?id=${Constant.appPackageName} \n",
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

  openPlayer(playType, position) async {
    // Map<String, String> qualityUrlList = <String, String>{
    //   '320p': downloadProvider.watchlistModel.result?[position].video320 ?? '',
    //   '480p': downloadProvider.watchlistModel.result?[position].video480 ?? '',
    //   '720p': downloadProvider.watchlistModel.result?[position].video720 ?? '',
    //   '1080p':
    //       downloadProvider.watchlistModel.result?[position].video1080 ?? '',
    // };
    // debugPrint("qualityUrlList ==========> ${qualityUrlList.length}");
    // Constant.resolutionsUrls = qualityUrlList;
    // debugPrint(
    //     "resolutionsUrls ==========> ${Constant.resolutionsUrls.length}");
    // Utils.openPlayer(
    //   context: context,
    //   playType: playType ?? "",
    //   videoId: downloadProvider.watchlistModel.result?[position].id ?? 0,
    //   videoType:
    //       downloadProvider.watchlistModel.result?[position].videoType ?? 0,
    //   typeId: downloadProvider.watchlistModel.result?[position].typeId ?? 0,
    //   videoUrl:
    //       downloadProvider.watchlistModel.result?[position].video320 ?? "",
    //   trailerUrl:
    //       downloadProvider.watchlistModel.result?[position].trailerUrl ?? "",
    //   uploadType:
    //       downloadProvider.watchlistModel.result?[position].videoUploadType ??
    //           "",
    //   vSubtitle:
    //       downloadProvider.watchlistModel.result?[position].subtitle ?? "",
    //   vStopTime:
    //       downloadProvider.watchlistModel.result?[position].stopTime ?? 0,
    // );
  }
}
