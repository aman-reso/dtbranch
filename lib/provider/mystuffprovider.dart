import 'dart:developer';

import 'package:dtlive/model/profilemodel.dart';
import 'package:dtlive/model/rentmodel.dart';
import 'package:dtlive/model/successmodel.dart';
import 'package:dtlive/model/watchlistmodel.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class MyStuffProvider extends ChangeNotifier {
  ProfileModel profileModel = ProfileModel();
  WatchlistModel watchlistModel = WatchlistModel();
  RentModel rentModel = RentModel();
  SuccessModel successModel = SuccessModel();

  bool loadingProfile = false,
      loadingDownload = false,
      loadingWatchlist = false,
      loadingPurchase = false;

  Future<void> getProfile() async {
    debugPrint("getProfile userID :==> ${Constant.userID}");
    loadingProfile = true;
    profileModel = await ApiService().profile();
    debugPrint("get_profile status :==> ${profileModel.status}");
    debugPrint("get_profile message :==> ${profileModel.message}");
    loadingProfile = false;
    notifyListeners();
  }

  Future<void> getWatchlist() async {
    debugPrint("getWatchlist userID :==> ${Constant.userID}");
    loadingWatchlist = true;
    watchlistModel = await ApiService().watchlist();
    debugPrint("get_bookmark_video status :==> ${watchlistModel.status}");
    debugPrint("get_bookmark_video message :==> ${watchlistModel.message}");
    loadingWatchlist = false;
    notifyListeners();
  }

  Future<void> setBookMark(
      BuildContext context, position, typeId, videoType, videoId) async {
    loadingWatchlist = true;
    debugPrint("setBookMark typeId :==> $typeId");
    debugPrint("setBookMark videoType :==> $videoType");
    debugPrint("setBookMark videoId :==> $videoId");
    debugPrint(
        "watchlistModel videoId :==> ${(watchlistModel.result?[position].id ?? 0)}");
    if ((watchlistModel.result?[position].isBookmark ?? 0) == 0) {
      watchlistModel.result?[position].isBookmark = 1;
      Utils.showSnackbar(context, "WatchlistAdd", "addwatchlistmessage");
    } else {
      watchlistModel.result?[position].isBookmark = 0;
      watchlistModel.result?.removeAt(position);
      Utils.showSnackbar(context, "WatchlistRemove", "removewatchlistmessage");
    }
    loadingWatchlist = false;
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

  Future<void> getUserRentVideoList() async {
    debugPrint("getUserRentVideoList userID :==> ${Constant.userID}");
    loadingPurchase = true;
    rentModel = await ApiService().userRentVideoList();
    debugPrint("user_rent_video_list status :==> ${rentModel.status}");
    debugPrint("user_rent_video_list message :==> ${rentModel.message}");
    loadingPurchase = false;
    notifyListeners();
  }

  clearProvider() {
    log("<================ clearProvider ================>");
    profileModel = ProfileModel();
    rentModel = RentModel();
    watchlistModel = WatchlistModel();
    successModel = SuccessModel();
  }
}
