import 'dart:developer';

import 'package:dtlive/model/sectiondetailmodel.dart';
import 'package:dtlive/model/successmodel.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class VideoDetailsProvider extends ChangeNotifier {
  SuccessModel successModel = SuccessModel();
  SectionDetailModel sectionDetailModel = SectionDetailModel();

  bool loading = false;

  Future<void> getSectionDetails(typeId, videoType, videoId) async {
    debugPrint("getSectionDetails typeId :==> $typeId");
    debugPrint("getSectionDetails videoType :==> $videoType");
    debugPrint("getSectionDetails videoId :==> $videoId");
    loading = true;
    sectionDetailModel =
        await ApiService().sectionDetails(typeId, videoType, videoId);
    debugPrint("section_detail status :==> ${sectionDetailModel.status}");
    debugPrint("section_detail message :==> ${sectionDetailModel.message}");
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

  clearProvider() {
    log("<================ clearSectionProvider ================>");
    sectionDetailModel = SectionDetailModel();
    successModel = SuccessModel();
  }
}
