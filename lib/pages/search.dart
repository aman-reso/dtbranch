import 'dart:developer';

import 'package:dtlive/pages/moviedetails.dart';
import 'package:dtlive/pages/tvshowdetails.dart';
import 'package:dtlive/provider/searchprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => SearchState();
}

class SearchState extends State<Search> {
  final searchController = TextEditingController();
  late SearchProvider searchProvider = SearchProvider();

  @override
  void initState() {
    searchProvider = Provider.of<SearchProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    searchProvider.clearSearchProvider();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appBgColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: appBgColor,
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                /* Search Box */
                searchBox(),
                const SizedBox(
                  height: 20,
                ),
                /* Searched Data */
                Consumer<SearchProvider>(
                  builder: (context, searchProvider, child) {
                    log("Browseby loading  ===>  ${searchProvider.loading}");
                    if (searchProvider.loading) {
                      return Utils.pageLoader();
                    } else {
                      if (searchProvider.searchModel.status == 200) {
                        if (searchProvider.searchModel.video != null &&
                            searchProvider.searchModel.tvshow != null) {
                          log("searchModel Video Size  ===>  ${(searchProvider.searchModel.video?.length ?? 0)}");
                          log("searchModel TvShow Size  ===>  ${(searchProvider.searchModel.tvshow?.length ?? 0)}");
                          return Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          searchProvider.setDataVisibility(
                                              true, false);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: MyText(
                                                color: white,
                                                text: "videos",
                                                multilanguage: true,
                                                textalign: TextAlign.center,
                                                fontsize: 16,
                                                fontwaight: FontWeight.w500,
                                                maxline: 1,
                                                overflow: TextOverflow.ellipsis,
                                                fontstyle: FontStyle.normal,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Visibility(
                                              visible:
                                                  searchProvider.isVideoClick,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 2,
                                                color: white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          searchProvider.setDataVisibility(
                                              false, true);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: MyText(
                                                color: white,
                                                text: "shows",
                                                textalign: TextAlign.center,
                                                fontsize: 16,
                                                multilanguage: true,
                                                fontwaight: FontWeight.w500,
                                                maxline: 1,
                                                overflow: TextOverflow.ellipsis,
                                                fontstyle: FontStyle.normal,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Visibility(
                                              visible:
                                                  searchProvider.isShowClick,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
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
                              const SizedBox(
                                height: 22,
                              ),
                              searchProvider.isVideoClick
                                  ? AlignedGridView.count(
                                      shrinkWrap: true,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      itemCount: (searchProvider
                                              .searchModel.video?.length ??
                                          0),
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int position) {
                                        return InkWell(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          onTap: () {
                                            log("Clicked on position ==> $position");
                                            if ((searchProvider
                                                        .searchModel.video
                                                        ?.elementAt(position)
                                                        .videoType ??
                                                    0) ==
                                                1) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return MovieDetails(
                                                      searchProvider
                                                              .searchModel.video
                                                              ?.elementAt(
                                                                  position)
                                                              .id ??
                                                          0,
                                                      searchProvider
                                                              .searchModel.video
                                                              ?.elementAt(
                                                                  position)
                                                              .videoType ??
                                                          0,
                                                      1,
                                                    );
                                                  },
                                                ),
                                              );
                                            } else if ((searchProvider
                                                        .searchModel.video
                                                        ?.elementAt(position)
                                                        .videoType ??
                                                    0) ==
                                                2) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return TvShowDetails(
                                                      searchProvider
                                                              .searchModel.video
                                                              ?.elementAt(
                                                                  position)
                                                              .id ??
                                                          0,
                                                      searchProvider
                                                              .searchModel.video
                                                              ?.elementAt(
                                                                  position)
                                                              .videoType ??
                                                          0,
                                                      4,
                                                    );
                                                  },
                                                ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: Constant.heightLand,
                                            alignment: Alignment.center,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: MyNetworkImage(
                                                imageUrl: searchProvider
                                                        .searchModel.video
                                                        ?.elementAt(position)
                                                        .landscape
                                                        .toString() ??
                                                    Constant.placeHolderLand,
                                                fit: BoxFit.cover,
                                                imgHeight:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height,
                                                imgWidth: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : searchProvider.isShowClick
                                      ? AlignedGridView.count(
                                          shrinkWrap: true,
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                          itemCount: (searchProvider
                                                  .searchModel.tvshow?.length ??
                                              0),
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int position) {
                                            return InkWell(
                                              onTap: () {
                                                log("Clicked on position ==> $position");
                                                if ((searchProvider
                                                            .searchModel.tvshow
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
                                                          searchProvider
                                                                  .searchModel
                                                                  .tvshow
                                                                  ?.elementAt(
                                                                      position)
                                                                  .id ??
                                                              0,
                                                          searchProvider
                                                                  .searchModel
                                                                  .tvshow
                                                                  ?.elementAt(
                                                                      position)
                                                                  .videoType ??
                                                              0,
                                                          1,
                                                        );
                                                      },
                                                    ),
                                                  );
                                                } else if ((searchProvider
                                                            .searchModel.tvshow
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
                                                          searchProvider
                                                                  .searchModel
                                                                  .tvshow
                                                                  ?.elementAt(
                                                                      position)
                                                                  .id ??
                                                              0,
                                                          searchProvider
                                                                  .searchModel
                                                                  .tvshow
                                                                  ?.elementAt(
                                                                      position)
                                                                  .videoType ??
                                                              0,
                                                          4,
                                                        );
                                                      },
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: Constant.heightLand,
                                                alignment: Alignment.centerLeft,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  child: MyNetworkImage(
                                                    imageUrl: searchProvider
                                                            .searchModel.tvshow
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
                                            );
                                          },
                                        )
                                      : const SizedBox.shrink(),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      } else {
                        return const SizedBox.shrink();
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchBox() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: BoxDecoration(
        color: primaryDarkColor,
        border: Border.all(
          color: primaryLight,
          width: 0.5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            child: MyImage(
              width: 20,
              height: 20,
              imagePath: "ic_find.png",
              color: white,
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: TextField(
                onSubmitted: (value) async {
                  log("value ====> $value");
                  if (value.isNotEmpty) {
                    final searchProvider =
                        Provider.of<SearchProvider>(context, listen: false);
                    await searchProvider.getSearchVideo(value.toString());
                  }
                },
                textInputAction: TextInputAction.done,
                obscureText: false,
                controller: searchController,
                keyboardType: TextInputType.text,
                maxLines: 1,
                style: const TextStyle(
                  color: white,
                  fontSize: 15,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  hintStyle: TextStyle(
                    color: otherColor,
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.normal,
                  ),
                  hintText: searchHint,
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
