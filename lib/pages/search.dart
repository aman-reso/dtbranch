import 'dart:developer';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:dtlive/pages/moviedetails.dart';
import 'package:dtlive/pages/tvshowdetails.dart';
import 'package:dtlive/provider/searchprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/dimens.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Search extends StatefulWidget {
  final String? searchText;
  const Search({Key? key, required this.searchText}) : super(key: key);

  @override
  State<Search> createState() => SearchState();
}

class SearchState extends State<Search> {
  final searchController = TextEditingController();
  late SearchProvider searchProvider = SearchProvider();
  final SpeechToText _speechToText = SpeechToText();
  bool speechEnabled = false, _isListening = false;
  String _lastWords = '';

  @override
  void initState() {
    _initSpeech();
    searchProvider = Provider.of<SearchProvider>(context, listen: false);
    searchController.text = widget.searchText ?? "";
    _getData();
    super.initState();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    debugPrint("<============== _startListening ==============>");
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _isListening = true;
    });
    Future.delayed(const Duration(seconds: 5), () {
      if (searchController.text.toString().isEmpty) {
        Utils.showSnackbar(context, "TextField", "speechnotavailable");
        _stopListening();
      }
    });
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    debugPrint("<============== _stopListening ==============>");
    _lastWords = '';
    _isListening = false;
    await _speechToText.stop();
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    debugPrint("<============== _onSpeechResult ==============>");
    setState(() async {
      _lastWords = result.recognizedWords;
      debugPrint("_lastWords ==============> $_lastWords");
      if (_lastWords.isNotEmpty && _isListening) {
        searchController.text = _lastWords.toString();
        _isListening = false;
        await searchProvider.getSearchVideo(_lastWords.toString());
        _lastWords = '';
      }
    });
  }

  @override
  void dispose() {
    _stopListening();
    searchController.dispose();
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
      resizeToAvoidBottomInset: true,
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
                                                        .searchModel
                                                        .video?[position]
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
                                                        .searchModel
                                                        .video?[position]
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
                                            height: Dimens.heightLand,
                                            alignment: Alignment.center,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: MyNetworkImage(
                                                imageUrl: searchProvider
                                                        .searchModel
                                                        .video?[position]
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
                                                                  .tvshow?[
                                                                      position]
                                                                  .id ??
                                                              0,
                                                          searchProvider
                                                                  .searchModel
                                                                  .tvshow?[
                                                                      position]
                                                                  .videoType ??
                                                              0,
                                                          1,
                                                        );
                                                      },
                                                    ),
                                                  );
                                                } else if ((searchProvider
                                                            .searchModel
                                                            .tvshow?[position]
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
                                                height: Dimens.heightLand,
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
        color: white,
        border: Border.all(
          color: primaryColor,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 50,
              height: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: MyImage(
                width: 16,
                height: 16,
                imagePath: "back.png",
                color: black,
              ),
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
                    await searchProvider.getSearchVideo(value.toString());
                  }
                },
                onChanged: (value) async {
                  await searchProvider.notifyProvider();
                },
                textInputAction: TextInputAction.done,
                obscureText: false,
                controller: searchController,
                keyboardType: TextInputType.text,
                maxLines: 1,
                style: const TextStyle(
                  color: black,
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: transparentColor,
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
          Consumer<SearchProvider>(
            builder: (context, searchProvider, child) {
              if (searchController.text.toString().isNotEmpty) {
                return InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () async {
                    debugPrint("Click on Clear!");
                    searchController.clear();
                    await searchProvider.clearProvider();
                    await searchProvider.notifyProvider();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.center,
                    child: MyImage(
                      imagePath: "ic_close.png",
                      color: black,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              } else {
                return InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () async {
                    debugPrint("Click on Microphone!");
                    _startListening();
                  },
                  child: _isListening
                      ? AvatarGlow(
                          glowColor: primaryLight,
                          endRadius: 25,
                          duration: const Duration(milliseconds: 2000),
                          repeat: true,
                          showTwoGlows: true,
                          repeatPauseDuration:
                              const Duration(milliseconds: 100),
                          child: Material(
                            elevation: 5,
                            color: transparentColor,
                            shape: const CircleBorder(),
                            child: Container(
                              width: 50,
                              height: 50,
                              color: transparentColor,
                              padding: const EdgeInsets.all(15),
                              alignment: Alignment.center,
                              child: MyImage(
                                imagePath: "ic_voice.png",
                                color: black,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: 50,
                          height: 50,
                          padding: const EdgeInsets.all(15),
                          alignment: Alignment.center,
                          child: MyImage(
                            imagePath: "ic_voice.png",
                            color: black,
                            fit: BoxFit.fill,
                          ),
                        ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
