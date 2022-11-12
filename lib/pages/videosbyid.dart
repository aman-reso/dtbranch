import 'dart:async';
import 'dart:developer';

import 'package:dtlive/pages/moviedetails.dart';
import 'package:dtlive/pages/nodata.dart';
import 'package:dtlive/pages/tvshowdetails.dart';
import 'package:dtlive/provider/videobyidprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class VideosByID extends StatefulWidget {
  final String appBarTitle, layoutType;
  final int itemID;
  const VideosByID(
    this.itemID,
    this.appBarTitle,
    this.layoutType, {
    Key? key,
  }) : super(key: key);

  @override
  State<VideosByID> createState() => VideosByIDState();
}

class VideosByIDState extends State<VideosByID> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    final videoByIDProvider =
        Provider.of<VideoByIDProvider>(context, listen: false);
    if (widget.layoutType == "ByCategory") {
      await videoByIDProvider.getVideoByCategory(widget.itemID);
    } else if (widget.layoutType == "ByLanguage") {
      await videoByIDProvider.getVideoByLanguage(widget.itemID);
    }
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoByIDProvider =
        Provider.of<VideoByIDProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: Utils.myAppBar(context, widget.appBarTitle),
      body: videoByIDProvider.loading
          ? Utils.pageLoader()
          : (videoByIDProvider.videoByIdModel.status == 200 &&
                  videoByIDProvider.videoByIdModel.result != null)
              ? (videoByIDProvider.videoByIdModel.result?.length ?? 0) > 0
                  ? SafeArea(
                      child: AlignedGridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        itemCount:
                            (videoByIDProvider.videoByIdModel.result?.length ??
                                0),
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int position) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () {
                              log("Clicked on position ==> $position");
                              if ((videoByIDProvider.videoByIdModel.result
                                          ?.elementAt(position)
                                          .videoType ??
                                      0) ==
                                  1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MovieDetails(
                                        videoByIDProvider.videoByIdModel.result
                                                ?.elementAt(position)
                                                .id ??
                                            0,
                                        videoByIDProvider.videoByIdModel.result
                                                ?.elementAt(position)
                                                .videoType ??
                                            0,
                                        videoByIDProvider.videoByIdModel.result
                                                ?.elementAt(position)
                                                .typeId ??
                                            0,
                                      );
                                    },
                                  ),
                                );
                              } else if ((videoByIDProvider
                                          .videoByIdModel.result
                                          ?.elementAt(position)
                                          .videoType ??
                                      0) ==
                                  2) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return TvShowDetails(
                                        videoByIDProvider.videoByIdModel.result
                                                ?.elementAt(position)
                                                .id ??
                                            0,
                                        videoByIDProvider.videoByIdModel.result
                                                ?.elementAt(position)
                                                .videoType ??
                                            0,
                                        videoByIDProvider.videoByIdModel.result
                                                ?.elementAt(position)
                                                .typeId ??
                                            0,
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: Constant.heightLand,
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: MyNetworkImage(
                                  imageUrl: videoByIDProvider
                                          .videoByIdModel.result
                                          ?.elementAt(position)
                                          .landscape
                                          .toString() ??
                                      Constant.placeHolderLand,
                                  fit: BoxFit.cover,
                                  imgHeight: MediaQuery.of(context).size.height,
                                  imgWidth: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const NoData()
              : const NoData(),
    );
  }
}
