import 'package:dtlive/pages/home.dart';
import 'package:dtlive/shimmer/shimmerutils.dart';
import 'package:dtlive/widget/nodata.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:dtlive/provider/searchprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/dimens.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class SearchWeb extends StatefulWidget {
  final String? searchText;
  const SearchWeb({Key? key, required this.searchText}) : super(key: key);

  @override
  State<SearchWeb> createState() => _SearchWebState();
}

class _SearchWebState extends State<SearchWeb> {
  HomeState? homeStateObject;
  late SearchProvider searchProvider;

  @override
  void initState() {
    homeStateObject = context.findAncestorStateOfType<HomeState>();
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
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                    return _buildSearchPage();
                  },
                ),
              ),
              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchPage() {
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
            ? _buildVideos()
            : searchProvider.isShowClick
                ? _buildShows()
                : const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildVideos() {
    if (searchProvider.loading) {
      return _shimmerSearch();
    } else {
      if (searchProvider.searchModel.status == 200) {
        if (searchProvider.searchModel.video != null) {
          return Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ResponsiveGridList(
                minItemWidth: Dimens.widthLand,
                minItemsPerRow: 2,
                maxItemsPerRow: 7,
                verticalGridSpacing: 8,
                horizontalGridSpacing: 8,
                children: List.generate(
                  (searchProvider.searchModel.video?.length ?? 0),
                  (position) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(4),
                      onTap: () {
                        debugPrint("Clicked on position ==> $position");
                        homeStateObject?.openDetailPage(
                          "videodetail",
                          searchProvider.searchModel.video?[position].id ?? 0,
                          searchProvider
                                  .searchModel.video?[position].videoType ??
                              0,
                          searchProvider.searchModel.video?[position].typeId ??
                              0,
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
                            imageUrl: searchProvider
                                    .searchModel.video?[position].landscape
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
                ),
              ),
            ),
          );
        } else {
          return const NoData(title: "", subTitle: "");
        }
      } else {
        return const SizedBox.shrink();
      }
    }
  }

  Widget _buildShows() {
    if (searchProvider.loading) {
      return _shimmerSearch();
    } else {
      if (searchProvider.searchModel.status == 200) {
        if (searchProvider.searchModel.tvshow != null) {
          return Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ResponsiveGridList(
                minItemWidth: Dimens.widthLand,
                minItemsPerRow: 2,
                maxItemsPerRow: 7,
                verticalGridSpacing: 8,
                horizontalGridSpacing: 8,
                children: List.generate(
                  (searchProvider.searchModel.tvshow?.length ?? 0),
                  (position) {
                    return InkWell(
                      onTap: () {
                        debugPrint("Clicked on position ==> $position");
                        homeStateObject?.openDetailPage(
                          "showdetail",
                          searchProvider.searchModel.tvshow?[position].id ?? 0,
                          searchProvider
                                  .searchModel.tvshow?[position].videoType ??
                              0,
                          searchProvider.searchModel.tvshow?[position].typeId ??
                              0,
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
                            imageUrl: searchProvider
                                    .searchModel.tvshow?[position].landscape
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
                ),
              ),
            ),
          );
        } else {
          return const NoData(title: "", subTitle: "");
        }
      } else {
        return const SizedBox.shrink();
      }
    }
  }

  Widget _shimmerSearch() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ShimmerUtils.responsiveGrid(
            context, Dimens.heightLand, Dimens.widthLand, 2, kIsWeb ? 40 : 20),
      ),
    );
  }
}
