import 'dart:developer';

import 'package:dtlive/model/videobyidmodel.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class VideoByIDProvider extends ChangeNotifier {
  VideoByIdModel videoByIdModel = VideoByIdModel();

  bool loading = false;

  Future<void> getVideoByCategory(categoryID) async {
    debugPrint("getVideoByCategory userID :==> ${Constant.userID}");
    debugPrint("getVideoByCategory categoryID :==> $categoryID");
    loading = true;
    videoByIdModel = await ApiService().videoByCategory(categoryID);
    debugPrint("video_by_category status :==> ${videoByIdModel.status}");
    debugPrint("video_by_category message :==> ${videoByIdModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> getVideoByLanguage(languageID) async {
    debugPrint("getVideoByLanguage userID :==> ${Constant.userID}");
    debugPrint("getVideoByLanguage languageID :==> $languageID");
    loading = true;
    videoByIdModel = await ApiService().videoByLanguage(languageID);
    debugPrint("video_by_language status :==> ${videoByIdModel.status}");
    debugPrint("video_by_language message :==> ${videoByIdModel.message}");
    loading = false;
    notifyListeners();
  }

  clearVideoByIDProvider() {
    log("<================ clearVideoByIDProvider ================>");
    videoByIdModel = VideoByIdModel();
  }
}
