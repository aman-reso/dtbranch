import 'dart:developer';

import 'package:dtlive/model/profilemodel.dart';
import 'package:dtlive/model/rentmodel.dart';
import 'package:dtlive/model/watchlistmodel.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class MyStuffProvider extends ChangeNotifier {
  ProfileModel profileModel = ProfileModel();
  WatchlistModel watchlistModel = WatchlistModel();
  RentModel rentModel = RentModel();

  bool loading = false;

  Future<void> getProfile() async {
    debugPrint("getProfile userID :==> ${Constant.userID}");
    loading = true;
    profileModel = await ApiService().profile();
    debugPrint("get_profile status :==> ${profileModel.status}");
    debugPrint("get_profile message :==> ${profileModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> getWatchlist() async {
    debugPrint("getWatchlist userID :==> ${Constant.userID}");
    loading = true;
    watchlistModel = await ApiService().watchlist();
    debugPrint("get_bookmark_video status :==> ${watchlistModel.status}");
    debugPrint("get_bookmark_video message :==> ${watchlistModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> getUserRentVideoList() async {
    debugPrint("getUserRentVideoList userID :==> ${Constant.userID}");
    loading = true;
    rentModel = await ApiService().userRentVideoList();
    debugPrint("user_rent_video_list status :==> ${rentModel.status}");
    debugPrint("user_rent_video_list message :==> ${rentModel.message}");
    loading = false;
    notifyListeners();
  }

  clearRentStoreProvider() {
    log("<================ clearMyStuffProvider ================>");
    profileModel = ProfileModel();
    rentModel = RentModel();
    watchlistModel = WatchlistModel();
  }
}
