import 'dart:developer';

import 'package:dtlive/pages/moviedetails.dart';
import 'package:dtlive/utils/dimens.dart';
import 'package:dtlive/widget/nodata.dart';
import 'package:dtlive/pages/tvshowdetails.dart';
import 'package:dtlive/provider/rentstoreprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class RentStore extends StatefulWidget {
  const RentStore({Key? key}) : super(key: key);

  @override
  State<RentStore> createState() => RentStoreState();
}

class RentStoreState extends State<RentStore> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    final rentStoreProvider =
        Provider.of<RentStoreProvider>(context, listen: false);
    await rentStoreProvider.getRentVideoList();
    Future.delayed(const Duration(seconds: 1)).then((value) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rentStoreProvider =
        Provider.of<RentStoreProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: Utils.myAppBar(context, "stor"),
      body: rentStoreProvider.loading
          ? Utils.pageLoader()
          : (rentStoreProvider.rentModel.status == 200)
              ? SafeArea(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        (rentStoreProvider.rentModel.video != null)
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
                                        Container(
                                          width: 20,
                                          height: 20,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: complimentryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: MyText(
                                            color: white,
                                            text: Constant.currencySymbol,
                                            textalign: TextAlign.center,
                                            fontsize: 11,
                                            multilanguage: false,
                                            maxline: 1,
                                            fontwaight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                            fontstyle: FontStyle.normal,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        MyText(
                                          color: white,
                                          text: "rentvideo",
                                          multilanguage: true,
                                          textalign: TextAlign.center,
                                          fontsize: 18,
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
                                          text:
                                              "(${(rentStoreProvider.rentModel.video?.length ?? 0)})",
                                          textalign: TextAlign.center,
                                          multilanguage: false,
                                          fontsize: 11,
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
                                          text: "videosmall",
                                          multilanguage: true,
                                          textalign: TextAlign.center,
                                          fontsize: 11,
                                          maxline: 1,
                                          fontwaight: FontWeight.bold,
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
                                    height: (rentStoreProvider
                                                    .rentModel.video?.length ??
                                                0) ==
                                            1
                                        ? Dimens.heightLand
                                        : ((rentStoreProvider.rentModel.video
                                                            ?.length ??
                                                        0) >
                                                    1 &&
                                                (rentStoreProvider.rentModel
                                                            .video?.length ??
                                                        0) <
                                                    7)
                                            ? (Dimens.heightLand * 2)
                                            : (rentStoreProvider.rentModel.video
                                                            ?.length ??
                                                        0) >
                                                    6
                                                ? (Dimens.heightLand * 3)
                                                : (Dimens.heightLand * 2),
                                    child: AlignedGridView.count(
                                      shrinkWrap: true,
                                      crossAxisCount: (rentStoreProvider
                                                      .rentModel
                                                      .video
                                                      ?.length ??
                                                  0) ==
                                              1
                                          ? 1
                                          : ((rentStoreProvider.rentModel.video
                                                              ?.length ??
                                                          0) >
                                                      1 &&
                                                  (rentStoreProvider.rentModel
                                                              .video?.length ??
                                                          0) <
                                                      7)
                                              ? 2
                                              : (rentStoreProvider.rentModel
                                                              .video?.length ??
                                                          0) >
                                                      6
                                                  ? 3
                                                  : 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      itemCount: (rentStoreProvider
                                              .rentModel.video?.length ??
                                          0),
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int position) {
                                        return InkWell(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          onTap: () {
                                            log("Clicked on position ==> $position");
                                            if ((rentStoreProvider
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
                                                      rentStoreProvider
                                                              .rentModel.video
                                                              ?.elementAt(
                                                                  position)
                                                              .id ??
                                                          0,
                                                      rentStoreProvider
                                                              .rentModel.video
                                                              ?.elementAt(
                                                                  position)
                                                              .videoType ??
                                                          0,
                                                      rentStoreProvider
                                                              .rentModel.video
                                                              ?.elementAt(
                                                                  position)
                                                              .typeId ??
                                                          0,
                                                    );
                                                  },
                                                ),
                                              );
                                            } else if ((rentStoreProvider
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
                                                      rentStoreProvider
                                                              .rentModel.video
                                                              ?.elementAt(
                                                                  position)
                                                              .id ??
                                                          0,
                                                      rentStoreProvider
                                                              .rentModel.video
                                                              ?.elementAt(
                                                                  position)
                                                              .videoType ??
                                                          0,
                                                      rentStoreProvider
                                                              .rentModel.video
                                                              ?.elementAt(
                                                                  position)
                                                              .typeId ??
                                                          0,
                                                    );
                                                  },
                                                ),
                                              );
                                            }
                                          },
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Container(
                                                width: Dimens.widthLand,
                                                height: Dimens.heightLand,
                                                alignment: Alignment.center,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  child: MyNetworkImage(
                                                    imageUrl: rentStoreProvider
                                                            .rentModel.video
                                                            ?.elementAt(
                                                                position)
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
                                              Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 15,
                                                  minWidth: 30,
                                                ),
                                                height: 22,
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: const BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(3),
                                                          topRight:
                                                              Radius.circular(
                                                                  4),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  8),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  3)),
                                                ),
                                                child: MyText(
                                                  color: black,
                                                  text:
                                                      "${Constant.currencySymbol} ${rentStoreProvider.rentModel.video?[position].rentPrice.toString() ?? "0"}",
                                                  textalign: TextAlign.center,
                                                  fontsize: 12,
                                                  fontwaight: FontWeight.w800,
                                                  maxline: 1,
                                                  multilanguage: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontstyle: FontStyle.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : const NoData(
                                title: '',
                                subTitle: '',
                              ),
                        const SizedBox(
                          height: 22,
                        ),
                        (rentStoreProvider.rentModel.tvshow != null)
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
                                        Container(
                                          width: 20,
                                          height: 20,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: complimentryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: MyText(
                                            color: white,
                                            text: Constant.currencySymbol,
                                            textalign: TextAlign.center,
                                            multilanguage: false,
                                            fontsize: 11,
                                            maxline: 1,
                                            fontwaight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                            fontstyle: FontStyle.normal,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        MyText(
                                          color: white,
                                          text: "rentshow",
                                          textalign: TextAlign.center,
                                          multilanguage: true,
                                          fontsize: 18,
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
                                          text:
                                              "(${(rentStoreProvider.rentModel.tvshow?.length ?? 0)})",
                                          textalign: TextAlign.center,
                                          fontsize: 11,
                                          maxline: 1,
                                          multilanguage: false,
                                          fontwaight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                          fontstyle: FontStyle.normal,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        MyText(
                                          color: otherColor,
                                          text: "showsmall",
                                          textalign: TextAlign.center,
                                          multilanguage: true,
                                          fontsize: 11,
                                          maxline: 1,
                                          fontwaight: FontWeight.bold,
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
                                    height: (rentStoreProvider
                                                    .rentModel.tvshow?.length ??
                                                0) ==
                                            1
                                        ? Dimens.heightLand
                                        : ((rentStoreProvider.rentModel.tvshow
                                                            ?.length ??
                                                        0) >
                                                    1 &&
                                                (rentStoreProvider.rentModel
                                                            .tvshow?.length ??
                                                        0) <
                                                    7)
                                            ? (Dimens.heightLand * 2)
                                            : (rentStoreProvider.rentModel
                                                            .tvshow?.length ??
                                                        0) >
                                                    6
                                                ? (Dimens.heightLand * 3)
                                                : (Dimens.heightLand * 2),
                                    child: AlignedGridView.count(
                                      shrinkWrap: true,
                                      crossAxisCount: (rentStoreProvider
                                                      .rentModel
                                                      .tvshow
                                                      ?.length ??
                                                  0) ==
                                              1
                                          ? 1
                                          : ((rentStoreProvider.rentModel.tvshow
                                                              ?.length ??
                                                          0) >
                                                      1 &&
                                                  (rentStoreProvider.rentModel
                                                              .tvshow?.length ??
                                                          0) <
                                                      7)
                                              ? 2
                                              : (rentStoreProvider.rentModel
                                                              .tvshow?.length ??
                                                          0) >
                                                      6
                                                  ? 3
                                                  : 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      itemCount: (rentStoreProvider
                                              .rentModel.tvshow?.length ??
                                          0),
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int position) {
                                        return Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              onTap: () {
                                                log("Clicked on position ==> $position");
                                                if ((rentStoreProvider
                                                            .rentModel.tvshow
                                                            ?.elementAt(
                                                                position)
                                                            .videoType ??
                                                        0) ==
                                                    1) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return MovieDetails(
                                                          rentStoreProvider
                                                                  .rentModel
                                                                  .tvshow
                                                                  ?.elementAt(
                                                                      position)
                                                                  .id ??
                                                              0,
                                                          rentStoreProvider
                                                                  .rentModel
                                                                  .tvshow
                                                                  ?.elementAt(
                                                                      position)
                                                                  .videoType ??
                                                              0,
                                                          rentStoreProvider
                                                                  .rentModel
                                                                  .tvshow
                                                                  ?.elementAt(
                                                                      position)
                                                                  .typeId ??
                                                              0,
                                                        );
                                                      },
                                                    ),
                                                  );
                                                } else if ((rentStoreProvider
                                                            .rentModel.tvshow
                                                            ?.elementAt(
                                                                position)
                                                            .videoType ??
                                                        0) ==
                                                    2) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return TvShowDetails(
                                                          rentStoreProvider
                                                                  .rentModel
                                                                  .tvshow
                                                                  ?.elementAt(
                                                                      position)
                                                                  .id ??
                                                              0,
                                                          rentStoreProvider
                                                                  .rentModel
                                                                  .tvshow
                                                                  ?.elementAt(
                                                                      position)
                                                                  .videoType ??
                                                              0,
                                                          rentStoreProvider
                                                                  .rentModel
                                                                  .tvshow
                                                                  ?.elementAt(
                                                                      position)
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
                                                    imageUrl: rentStoreProvider
                                                            .rentModel.tvshow
                                                            ?.elementAt(
                                                                position)
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
                                            ),
                                            Container(
                                              constraints: const BoxConstraints(
                                                minHeight: 15,
                                                minWidth: 30,
                                              ),
                                              height: 22,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(5),
                                              decoration: const BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(3),
                                                    topRight:
                                                        Radius.circular(4),
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(3)),
                                              ),
                                              child: MyText(
                                                color: black,
                                                text:
                                                    "${Constant.currencySymbol} ${rentStoreProvider.rentModel.tvshow?[position].rentPrice.toString() ?? "0"}",
                                                textalign: TextAlign.center,
                                                fontsize: 12,
                                                multilanguage: false,
                                                fontwaight: FontWeight.w800,
                                                maxline: 1,
                                                overflow: TextOverflow.ellipsis,
                                                fontstyle: FontStyle.normal,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : const NoData(
                                title: '',
                                subTitle: '',
                              ),
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
}