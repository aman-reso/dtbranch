import 'dart:developer';

import 'package:dtlive/model/searchmodel.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:dtlive/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  SearchModel searchModel = SearchModel();

  bool loading = false, isVideoClick = true, isShowClick = false;

  SharedPre sharePref = SharedPre();

  Future<void> getSearchVideo(searchText) async {
    debugPrint("getSearchVideos searchText :==> $searchText");
    loading = true;
    searchModel = await ApiService().searchVideo(searchText);
    debugPrint("search_video status :==> ${searchModel.status}");
    debugPrint("search_video message :==> ${searchModel.message}");
    loading = false;
    notifyListeners();
  }

  void setDataVisibility(bool isVideoVisible, bool isShowVisible) {
    log("setDataVisibility isVideoVisible :==> $isVideoVisible");
    log("setDataVisibility isShowVisible :==> $isShowVisible");
    isVideoClick = isVideoVisible;
    isShowClick = isShowVisible;
    notifyListeners();
  }

  void clearSearchProvider() {
    log("============ clearSearchProvider ============");
    searchModel = SearchModel();
    isVideoClick = true;
    isShowClick = false;
  }
}