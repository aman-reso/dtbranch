import 'dart:math';

import 'package:dtlive/widget/nodata.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:dtlive/provider/searchprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/dimens.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class SearchWeb extends StatefulWidget {
  final String? searchText;
  final Function openDetailPage;
  const SearchWeb(
      {Key? key, required this.searchText, required this.openDetailPage})
      : super(key: key);

  @override
  State<SearchWeb> createState() => _SearchWebState();
}

class _SearchWebState extends State<SearchWeb> {
  late SearchProvider searchProvider;
  final minCount = 4;

  @override
  void initState() {
    searchProvider = Provider.of<SearchProvider>(context, listen: false);
    _getData();
    super.initState();
  }

  @override
  void dispose() {
    searchProvider.clearProvider();
    super.dispose();
  }

  _getData() async {
    if ((widget.searchText ?? "").isNotEmpty) {
      final searchProvider =
          Provider.of<SearchProvider>(context, listen: false);
      await searchProvider.getSearchVideo(widget.searchText ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    final widthCount = (MediaQuery.of(context).size.width ~/ 250).toInt();
    debugPrint("widthCount ---------------> $widthCount");
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: appBgColor,
      child: Column(
        children: [
          if (kIsWeb) SizedBox(height: Dimens.homeTabHeight),
          /* Searched Data */
          Expanded(
            child: Consumer<SearchProvider>(
              builder: (context, searchProvider, child) {
                debugPrint("Browseby loading  ===>  ${searchProvider.loading}");
                if (searchProvider.loading) {
                  return Utils.pageLoader();
                } else {
                  if (searchProvider.searchModel.status == 200) {
                    if (searchProvider.searchModel.video != null &&
                        searchProvider.searchModel.tvshow != null) {
                      return _buildSearchPage(widthCount);
                    } else {
                      return const NoData(title: "", subTitle: "");
                    }
                  } else {
                    return const SizedBox.shrink();
                  }
                }
              },
            ),
          ),
          const SizedBox(height: 22),
        ],
      ),
    );
  }

  Widget _buildSearchPage(widthCount) {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            minWidth: 0,
            maxWidth: kIsWeb
                ? (MediaQuery.of(context).size.width * 0.5)
                : MediaQuery.of(context).size.width,
          ),
          height: 40,
          child: Row(
            children: [
              /* Video */
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () async {
                    searchProvider.setDataVisibility(true, false);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: MyText(
                            color: white,
                            text: "videos",
                            multilanguage: true,
                            textalign: TextAlign.center,
                            fontsizeNormal: 16,
                            fontsizeWeb: 17,
                            fontweight: FontWeight.w600,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            fontstyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Visibility(
                        visible: searchProvider.isVideoClick,
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

              /* Show */
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () async {
                    searchProvider.setDataVisibility(false, true);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: MyText(
                            color: white,
                            text: "shows",
                            textalign: TextAlign.center,
                            fontsizeNormal: 16,
                            fontsizeWeb: 17,
                            multilanguage: true,
                            fontweight: FontWeight.w600,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            fontstyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Visibility(
                        visible: searchProvider.isShowClick,
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
        const SizedBox(height: 12),
        searchProvider.isVideoClick
            ? Expanded(child: _buildVideos(widthCount))
            : searchProvider.isShowClick
                ? Expanded(child: _buildShows(widthCount))
                : const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildVideos(widthCount) {
    return AlignedGridView.count(
      shrinkWrap: true,
      crossAxisCount: min(widthCount ?? 0, minCount),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      itemCount: (searchProvider.searchModel.video?.length ?? 0),
      padding: const EdgeInsets.only(left: 20, right: 20),
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int position) {
        return InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () {
            debugPrint("Clicked on position ==> $position");
            widget.openDetailPage(
              "videodetail",
              searchProvider.searchModel.video?[position].id ?? 0,
              searchProvider.searchModel.video?[position].videoType ?? 0,
              searchProvider.searchModel.video?[position].typeId ?? 0,
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: Dimens.heightLand,
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: MyNetworkImage(
                imageUrl: searchProvider.searchModel.video?[position].landscape
                        .toString() ??
                    "",
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

  Widget _buildShows(widthCount) {
    return AlignedGridView.count(
      shrinkWrap: true,
      crossAxisCount: min(widthCount ?? 0, minCount),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      itemCount: (searchProvider.searchModel.tvshow?.length ?? 0),
      padding: const EdgeInsets.only(left: 20, right: 20),
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int position) {
        return InkWell(
          onTap: () {
            debugPrint("Clicked on position ==> $position");
            widget.openDetailPage(
              "showdetail",
              searchProvider.searchModel.tvshow?[position].id ?? 0,
              searchProvider.searchModel.tvshow?[position].videoType ?? 0,
              searchProvider.searchModel.tvshow?[position].typeId ?? 0,
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: Dimens.heightLand,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: MyNetworkImage(
                imageUrl: searchProvider.searchModel.tvshow?[position].landscape
                        .toString() ??
                    "",
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
}