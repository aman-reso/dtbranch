import 'dart:developer';

import 'package:dtlive/model/episodebyseasonmodel.dart';
import 'package:dtlive/model/sectiondetailmodel.dart';
import 'package:dtlive/model/successmodel.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class ShowDetailsProvider extends ChangeNotifier {
  SuccessModel successModel = SuccessModel();
  SectionDetailModel sectionDetailModel = SectionDetailModel();
  EpisodeBySeasonModel episodeBySeasonModel = EpisodeBySeasonModel();

  bool loading = false;
  int seasonPos = 0;

  Future<void> getSectionDetails(typeId, videoType, videoId) async {
    loading = true;
    sectionDetailModel =
        await ApiService().sectionDetails(typeId, videoType, videoId);
    loading = false;
    notifyListeners();
  }

  Future<void> getEpisodeBySeason(seasonId, showId) async {
    loading = true;
    episodeBySeasonModel = await ApiService().episodeBySeason(seasonId, showId);
    loading = false;
    notifyListeners();
  }

  Future<void> setBookMark(
      BuildContext context, typeId, videoType, videoId) async {
    loading = true;
    if ((sectionDetailModel.result?.isBookmark ?? 0) == 0) {
      sectionDetailModel.result?.isBookmark = 1;
      Utils.showSnackbar(context, "WatchlistAdd", "addwatchlistmessage");
    } else {
      sectionDetailModel.result?.isBookmark = 0;
      Utils.showSnackbar(context, "WatchlistRemove", "removewatchlistmessage");
    }
    loading = false;
    notifyListeners();
    getAddBookMark(typeId, videoType, videoId);
  }

  Future<void> getAddBookMark(typeId, videoType, videoId) async {
    debugPrint("getAddBookMark typeId :==> $typeId");
    debugPrint("getAddBookMark videoType :==> $videoType");
    debugPrint("getAddBookMark videoId :==> $videoId");
    successModel =
        await ApiService().addRemoveBookmark(typeId, videoType, videoId);
    debugPrint("add_remove_bookmark status :==> ${successModel.status}");
    debugPrint("add_remove_bookmark message :==> ${successModel.message}");
  }

  setSeasonPosition(int position) {
    log("setSeasonPosition ===> $position");
    seasonPos = position;
    notifyListeners();
  }

  clearProvider() {
    log("<================ clearSectionProvider ================>");
    sectionDetailModel = SectionDetailModel();
    episodeBySeasonModel = EpisodeBySeasonModel();
    successModel = SuccessModel();
    seasonPos = 0;
  }
}
