import 'dart:developer';

import 'package:dtlive/pages/moviedetails.dart';
import 'package:dtlive/pages/tvshowdetails.dart';
import 'package:dtlive/provider/purchaselistprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/dimens.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/widget/nodata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class MyPurchaselist extends StatefulWidget {
  const MyPurchaselist({Key? key}) : super(key: key);

  @override
  State<MyPurchaselist> createState() => _MyPurchaselistState();
}

class _MyPurchaselistState extends State<MyPurchaselist> {
  late PurchaselistProvider purchaselistProvider;

  @override
  void initState() {
    purchaselistProvider =
        Provider.of<PurchaselistProvider>(context, listen: false);
    _getData();
    super.initState();
  }

  _getData() async {
    await purchaselistProvider.getUserRentVideoList();
  }

  @override
  void dispose() {
    purchaselistProvider.clearProvider();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: Utils.myAppBar(context, "purchases"),
      body: SafeArea(
        child: Consumer<PurchaselistProvider>(
          builder: (context, purchaselistProvider, child) {
            if (purchaselistProvider.loading) {
              return Utils.pageLoader();
            } else {
              if (purchaselistProvider.rentModel.status == 200) {
                if ((purchaselistProvider.rentModel.video?.length ?? 0) == 0 &&
                    (purchaselistProvider.rentModel.tvshow?.length ?? 0) == 0) {
                  return const NoData(
                    title: 'rent_and_buy_your_favorites',
                    subTitle: 'no_purchases_note',
                  );
                } else {
                  if (purchaselistProvider.rentModel.video != null ||
                      purchaselistProvider.rentModel.tvshow != null) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          ((purchaselistProvider.rentModel.video?.length ?? 0) >
                                  0)
                              ? Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 30,
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          MyText(
                                            color: white,
                                            text: "purchasvideo",
                                            multilanguage: true,
                                            textalign: TextAlign.center,
                                            fontsize: 16,
                                            maxline: 1,
                                            fontwaight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                            fontstyle: FontStyle.normal,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          MyText(
                                            color: otherColor,
                                            text: (purchaselistProvider
                                                            .rentModel
                                                            .video
                                                            ?.length ??
                                                        0) >
                                                    1
                                                ? "(${(purchaselistProvider.rentModel.video?.length ?? 0)} videos)"
                                                : "(${(purchaselistProvider.rentModel.video?.length ?? 0)} video)",
                                            textalign: TextAlign.center,
                                            fontsize: 13,
                                            maxline: 1,
                                            fontwaight: FontWeight.normal,
                                            overflow: TextOverflow.ellipsis,
                                            fontstyle: FontStyle.normal,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: (purchaselistProvider.rentModel
                                                      .video?.length ??
                                                  0) ==
                                              1
                                          ? Dimens.heightLand
                                          : ((purchaselistProvider.rentModel
                                                              .video?.length ??
                                                          0) >
                                                      1 &&
                                                  (purchaselistProvider
                                                              .rentModel
                                                              .video
                                                              ?.length ??
                                                          0) <
                                                      7)
                                              ? (Dimens.heightLand * 2)
                                              : (purchaselistProvider.rentModel
                                                              .video?.length ??
                                                          0) >
                                                      6
                                                  ? (Dimens.heightLand * 3)
                                                  : (Dimens.heightLand * 2),
                                      child: AlignedGridView.count(
                                        shrinkWrap: true,
                                        crossAxisCount: (purchaselistProvider
                                                        .rentModel
                                                        .video
                                                        ?.length ??
                                                    0) ==
                                                1
                                            ? 1
                                            : ((purchaselistProvider
                                                                .rentModel
                                                                .video
                                                                ?.length ??
                                                            0) >
                                                        1 &&
                                                    (purchaselistProvider
                                                                .rentModel
                                                                .video
                                                                ?.length ??
                                                            0) <
                                                        7)
                                                ? 2
                                                : (purchaselistProvider
                                                                .rentModel
                                                                .video
                                                                ?.length ??
                                                            0) >
                                                        6
                                                    ? 3
                                                    : 2,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        itemCount: (purchaselistProvider
                                                .rentModel.video?.length ??
                                            0),
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (BuildContext context,
                                            int position) {
                                          return InkWell(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            onTap: () {
                                              log("Clicked on position ==> $position");
                                              if ((purchaselistProvider
                                                          .rentModel
                                                          .video?[position]
                                                          .videoType ??
                                                      0) ==
                                                  1) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return MovieDetails(
                                                        purchaselistProvider
                                                                .rentModel
                                                                .video?[
                                                                    position]
                                                                .id ??
                                                            0,
                                                        purchaselistProvider
                                                                .rentModel
                                                                .video?[
                                                                    position]
                                                                .videoType ??
                                                            0,
                                                        purchaselistProvider
                                                                .rentModel
                                                                .video?[
                                                                    position]
                                                                .typeId ??
                                                            0,
                                                      );
                                                    },
                                                  ),
                                                );
                                              } else if ((purchaselistProvider
                                                          .rentModel
                                                          .video?[position]
                                                          .videoType ??
                                                      0) ==
                                                  2) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return TvShowDetails(
                                                        purchaselistProvider
                                                                .rentModel
                                                                .video?[
                                                                    position]
                                                                .id ??
                                                            0,
                                                        purchaselistProvider
                                                                .rentModel
                                                                .video?[
                                                                    position]
                                                                .videoType ??
                                                            0,
                                                        purchaselistProvider
                                                                .rentModel
                                                                .video?[
                                                                    position]
                                                                .typeId ??
                                                            0,
                                                      );
                                                    },
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              width: Dimens.widthLand,
                                              height: Dimens.heightLand,
                                              alignment: Alignment.center,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: MyNetworkImage(
                                                  imageUrl: purchaselistProvider
                                                          .rentModel
                                                          .video?[position]
                                                          .landscape
                                                          .toString() ??
                                                      "",
                                                  fit: BoxFit.cover,
                                                  imgHeight:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height,
                                                  imgWidth:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 22,
                          ),
                          ((purchaselistProvider.rentModel.tvshow?.length ??
                                      0) >
                                  0)
                              ? Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 30,
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          MyText(
                                            color: white,
                                            text: "purchaschow",
                                            textalign: TextAlign.center,
                                            multilanguage: true,
                                            fontsize: 16,
                                            maxline: 1,
                                            fontwaight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                            fontstyle: FontStyle.normal,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          MyText(
                                            color: otherColor,
                                            text: (purchaselistProvider
                                                            .rentModel
                                                            .tvshow
                                                            ?.length ??
                                                        0) >
                                                    1
                                                ? "(${(purchaselistProvider.rentModel.tvshow?.length ?? 0)} shows)"
                                                : "(${(purchaselistProvider.rentModel.tvshow?.length ?? 0)} show)",
                                            textalign: TextAlign.center,
                                            fontsize: 13,
                                            maxline: 1,
                                            fontwaight: FontWeight.normal,
                                            overflow: TextOverflow.ellipsis,
                                            fontstyle: FontStyle.normal,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: (purchaselistProvider.rentModel
                                                      .tvshow?.length ??
                                                  0) ==
                                              1
                                          ? Dimens.heightLand
                                          : ((purchaselistProvider.rentModel
                                                              .tvshow?.length ??
                                                          0) >
                                                      1 &&
                                                  (purchaselistProvider
                                                              .rentModel
                                                              .tvshow
                                                              ?.length ??
                                                          0) <
                                                      7)
                                              ? (Dimens.heightLand * 2)
                                              : (purchaselistProvider.rentModel
                                                              .tvshow?.length ??
                                                          0) >
                                                      6
                                                  ? (Dimens.heightLand * 3)
                                                  : (Dimens.heightLand * 2),
                                      child: AlignedGridView.count(
                                        shrinkWrap: true,
                                        crossAxisCount: (purchaselistProvider
                                                        .rentModel
                                                        .tvshow
                                                        ?.length ??
                                                    0) ==
                                                1
                                            ? 1
                                            : ((purchaselistProvider
                                                                .rentModel
                                                                .tvshow
                                                                ?.length ??
                                                            0) >
                                                        1 &&
                                                    (purchaselistProvider
                                                                .rentModel
                                                                .tvshow
                                                                ?.length ??
                                                            0) <
                                                        7)
                                                ? 2
                                                : (purchaselistProvider
                                                                .rentModel
                                                                .tvshow
                                                                ?.length ??
                                                            0) >
                                                        6
                                                    ? 3
                                                    : 2,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        itemCount: (purchaselistProvider
                                                .rentModel.tvshow?.length ??
                                            0),
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (BuildContext context,
                                            int position) {
                                          return InkWell(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            onTap: () {
                                              log("Clicked on position ==> $position");
                                              if ((purchaselistProvider
                                                          .rentModel
                                                          .tvshow?[position]
                                                          .videoType ??
                                                      0) ==
                                                  1) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return MovieDetails(
                                                        purchaselistProvider
                                                                .rentModel
                                                                .tvshow?[
                                                                    position]
                                                                .id ??
                                                            0,
                                                        purchaselistProvider
                                                                .rentModel
                                                                .tvshow?[
                                                                    position]
                                                                .videoType ??
                                                            0,
                                                        purchaselistProvider
                                                                .rentModel
                                                                .tvshow?[
                                                                    position]
                                                                .typeId ??
                                                            0,
                                                      );
                                                    },
                                                  ),
                                                );
                                              } else if ((purchaselistProvider
                                                          .rentModel
                                                          .tvshow?[position]
                                                          .videoType ??
                                                      0) ==
                                                  2) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return TvShowDetails(
                                                        purchaselistProvider
                                                                .rentModel
                                                                .tvshow?[
                                                                    position]
                                                                .id ??
                                                            0,
                                                        purchaselistProvider
                                                                .rentModel
                                                                .tvshow?[
                                                                    position]
                                                                .videoType ??
                                                            0,
                                                        purchaselistProvider
                                                                .rentModel
                                                                .tvshow?[
                                                                    position]
                                                                .typeId ??
                                                            0,
                                                      );
                                                    },
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              width: Dimens.widthLand,
                                              height: Dimens.heightLand,
                                              alignment: Alignment.center,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: MyNetworkImage(
                                                  imageUrl: purchaselistProvider
                                                          .rentModel
                                                          .tvshow?[position]
                                                          .landscape
                                                          .toString() ??
                                                      "",
                                                  fit: BoxFit.cover,
                                                  imgHeight:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height,
                                                  imgWidth:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const NoData(
                      title: 'rent_and_buy_your_favorites',
                      subTitle: 'no_purchases_note',
                    );
                  }
                }
              } else {
                return const NoData(
                  title: 'rent_and_buy_your_favorites',
                  subTitle: 'no_purchases_note',
                );
              }
            }
          },
        ),
      ),
    );
  }
}